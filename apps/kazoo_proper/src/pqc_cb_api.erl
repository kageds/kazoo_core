%%%-----------------------------------------------------------------------------
%%% @copyright (C) 2010-2022, 2600Hz
%%% @doc
%%% @author James Aimonetti
%%% @end
%%%-----------------------------------------------------------------------------
-module(pqc_cb_api).

-export([
    authenticate/0,
    authenticate/3,
    v2_base_url/0,
    auth_account_id/1,

    request_headers/1, request_headers/2,
    create_envelope/1, create_envelope/2,
    make_request/4, make_request/5,

    cleanup/1,

    set_log_level/1,

    init_api/2
]).

-include("kazoo_proper.hrl").

-define(TRACE_FORMAT, [
    {'elapsed', <<"-0">>},
    "|",
    'request_id',
    "|",
    'module',
    ":",
    'line',
    " (",
    'pid',
    ")|",
    'message',
    "\n"
]).

-type expected_code() :: 200..600.
-type expected_codes() :: [expected_code()].
-type expected_headers() :: kz_http:headers().
-type expectation() :: #{
    'response_codes' := expected_codes(),
    'response_headers' => expected_headers()
}.
-type expectations() :: [expectation()].

-type response_code() :: 200..600.
-type response_headers() :: kz_http:headers().

-type response() ::
    binary()
    | {'error', any()}.

-type fun_2() :: fun((string(), kz_term:proplist()) -> kz_http:ret()).
-type fun_3() :: fun((string(), kz_term:proplist(), iodata()) -> kz_http:ret()).

-type state() :: #{
    'auth_token' => kz_term:ne_binary(),
    'account_id' => kz_term:ne_binary(),
    'request_id' => kz_term:ne_binary(),
    'trace_file' => kz_data_tracing:trace_ref(),
    'start' => kz_time:now()
}.

-export_type([
    state/0,
    response/0,
    expectations/0
]).

-spec cleanup(state()) -> any().
cleanup(#{
    'trace_file' := Trace,
    'start' := Start
}) ->
    lager:info("cleanup after ~p ms", [kz_time:elapsed_ms(Start)]),
    kz_data_tracing:stop_trace(Trace).

-define(API_BASE, net_adm:localhost()).

api_base() ->
    Host = kz_network_utils:get_hostname(),
    {Scheme, Port} =
        case kapps_config:get_integer(<<"crossbar">>, <<"port">>) of
            'undefined' ->
                {"https://", kapps_config:get_integer(<<"crossbar">>, <<"ssl_port">>)};
            P ->
                {"http://", P}
        end,
    Scheme ++ Host ++ [$: | integer_to_list(Port)] ++ "/v2".

-spec authenticate() -> state().
authenticate() ->
    URL = api_base() ++ "/api_auth",
    Data = kz_json:from_list([{<<"api_key">>, api_key()}]),
    Envelope = create_envelope(Data),

    {'ok', Trace} = start_trace(),

    Resp = make_request(
        [201],
        fun kz_http:put/3,
        URL,
        default_request_headers(kz_util:get_callid()),
        kz_json:encode(Envelope)
    ),
    create_api_state(Resp, Trace).

-spec authenticate(kz_term:ne_binary(), kz_term:ne_binary(), kz_term:ne_binary()) -> state().
authenticate(AccountName, Username, Password) ->
    URL = api_base() ++ "/user_auth",
    Creds = kz_term:to_hex_binary(crypto:hash('md5', <<Username/binary, ":", Password/binary>>)),
    Data = kz_json:from_list([
        {<<"account_name">>, AccountName},
        {<<"credentials">>, Creds}
    ]),
    Envelope = create_envelope(Data),

    {'ok', Trace} = start_trace(),

    Resp = make_request(
        [201],
        fun kz_http:put/3,
        URL,
        default_request_headers(kz_util:get_callid()),
        kz_json:encode(Envelope)
    ),
    create_api_state(Resp, Trace).

-spec api_key() -> kz_term:ne_binary().
api_key() ->
    case kapps_util:get_master_account_id() of
        {'ok', MasterAccountId} ->
            api_key(MasterAccountId);
        {'error', _} ->
            lager:error("failed to find master account, please create an account first"),
            throw('no_master_account')
    end.

-spec api_key(kz_term:ne_binary()) -> kz_term:ne_binary().
api_key(MasterAccountId) ->
    case kzd_accounts:fetch(MasterAccountId) of
        {'ok', MasterAccount} ->
            APIKey = kzd_accounts:api_key(MasterAccount),
            case is_binary(APIKey) of
                'true' ->
                    APIKey;
                'false' ->
                    lager:error("failed to fetch api key for ~s", [MasterAccountId]),
                    throw('missing_api_key')
            end;
        {'error', _E} ->
            lager:error("failed to fetch master account ~s: ~p", [MasterAccountId, _E]),
            throw('missing_master_account')
    end.

-spec create_api_state(binary(), kz_data_tracing:trace_ref()) -> state().
create_api_state(<<RespJSON/binary>>, Trace) ->
    RespEnvelope = kz_json:decode(RespJSON),
    #{
        'auth_token' => kz_json:get_ne_binary_value(<<"auth_token">>, RespEnvelope),
        'account_id' => kz_json:get_ne_binary_value([<<"data">>, <<"account_id">>], RespEnvelope),
        'request_id' => kz_util:get_callid(),
        'trace_file' => Trace,
        'start' => get('now')
    }.

-spec v2_base_url() -> string().
v2_base_url() -> api_base().

-spec auth_account_id(state()) -> kz_term:ne_binary().
auth_account_id(#{'account_id' := AccountId}) -> AccountId.

-spec request_headers(state()) -> kz_term:proplist().
request_headers(API) ->
    request_headers(API, []).

-spec request_headers(state(), kz_term:proplist()) -> kz_term:proplist().
request_headers(
    #{
        'auth_token' := AuthToken,
        'request_id' := RequestId
    },
    RequestHeaders
) ->
    lager:md([{'request_id', RequestId}]),
    props:set_values(
        RequestHeaders,
        [
            {<<"x-auth-token">>, kz_term:to_list(AuthToken)}
            | default_request_headers(RequestId)
        ]
    ).

-spec default_request_headers() -> kz_term:proplist().
default_request_headers() ->
    [
        {<<"content-type">>, <<"application/json">>},
        {<<"accept">>, <<"application/json">>}
    ].

-spec default_request_headers(kz_term:ne_binary()) -> kz_term:proplist().
default_request_headers(RequestId) ->
    NowMS = kz_time:now_ms(),
    APIRequestID = kz_term:to_list(RequestId) ++ "-" ++ integer_to_list(NowMS),
    lager:debug("request id ~s", [APIRequestID]),
    [
        {<<"x-request-id">>, APIRequestID}
        | default_request_headers()
    ].

-spec make_request(
    expectations() | expectation() | expected_code() | expected_codes(),
    fun_2(),
    iolist(),
    kz_term:proplist()
) ->
    response().
make_request(Code, HTTP, URL, RequestHeaders) when is_integer(Code) ->
    make_request([#{'response_codes' => [Code]}], HTTP, URL, RequestHeaders);
make_request([Code | _] = Codes, HTTP, URL, RequestHeaders) when is_integer(Code) ->
    make_request([#{'response_codes' => Codes}], HTTP, URL, RequestHeaders);
make_request(#{'response_codes' := _} = Expectation, HTTP, URL, RequestHeaders) ->
    make_request([Expectation], HTTP, URL, RequestHeaders);
make_request([#{} | _] = Expectations, HTTP, URL, RequestHeaders) ->
    lager:info("~p: ~s", [HTTP, URL]),
    lager:debug("~p", [RequestHeaders]),

    handle_response(Expectations, HTTP(URL, RequestHeaders)).

-spec make_request(
    expectations() | expectation() | expected_code() | expected_codes(),
    fun_3(),
    iolist(),
    kz_term:proplist(),
    iodata()
) ->
    response().
make_request(Code, HTTP, URL, RequestHeaders, RequestBody) when is_integer(Code) ->
    make_request([#{'response_codes' => [Code]}], HTTP, URL, RequestHeaders, RequestBody);
make_request([Code | _] = Codes, HTTP, URL, RequestHeaders, RequestBody) when is_integer(Code) ->
    make_request([#{'response_codes' => Codes}], HTTP, URL, RequestHeaders, RequestBody);
make_request(#{'response_codes' := _} = Expectation, HTTP, URL, RequestHeaders, RequestBody) ->
    make_request([Expectation], HTTP, URL, RequestHeaders, RequestBody);
make_request([#{} | _] = Expectations, HTTP, URL, RequestHeaders, RequestBody) ->
    lager:info("~p: ~s", [HTTP, URL]),
    lager:debug("headers: ~p", [RequestHeaders]),
    lager:debug("body: ~s", [RequestBody]),
    handle_response(Expectations, HTTP(URL, RequestHeaders, iolist_to_binary(RequestBody))).

-spec create_envelope(kz_json:json_term()) ->
    kz_json:object().
create_envelope(Data) ->
    create_envelope(Data, kz_json:new()).

-spec create_envelope(kz_json:json_term(), kz_json:object()) ->
    kz_json:object().
create_envelope(Data, Envelope) ->
    kz_json:set_value(<<"data">>, Data, Envelope).

-spec handle_response(expectations(), kz_http:ret()) -> response().
handle_response([#{} | _] = Expectations, {'ok', ActualCode, RespHeaders, <<RespBody/binary>>}) ->
    case expectations_met(Expectations, ActualCode, [{"resp_code", ActualCode} | RespHeaders]) of
        'true' ->
            RespBody;
        'false' ->
            lager:info("expectations not met: ~w", [Expectations]),
            lager:debug("~p: ~p", [ActualCode, RespHeaders]),
            {'error', RespBody}
    end;
handle_response(_Expectations, {'error', {'failed_connect', 'econnrefused'}}) ->
    lager:warning("failed to connect to Crossbar; is it running?"),
    throw({'error', 'econnrefused'});
handle_response(_Expectations, {'error', 'socket_closed_remotely'} = E) ->
    lager:error("~nwe broke crossbar!"),
    throw(E);
handle_response(_Expectations, {'error', E}) ->
    lager:warning("failed to query API: ~p", [E]),
    throw({'error', E}).

-spec expectations_met(expectations(), response_code(), response_headers()) -> boolean().
expectations_met(Expectations, RespCode, RespHeaders) ->
    lager:info("checking expectations against ~p: ~p", [RespCode, RespHeaders]),
    lists:any(
        fun(E) -> expectation_met(E, RespCode, RespHeaders) end,
        Expectations
    ).

-spec expectation_met(expectation(), response_code(), response_headers()) -> boolean().
expectation_met(#{} = Expectation, RespCode, RespHeaders) ->
    CodeMatches = response_code_matches(Expectation, RespCode),
    HeadersMatch = response_headers_match(Expectation, RespHeaders),
    lager:info("code: ~p headers: ~p", [CodeMatches, HeadersMatch]),
    CodeMatches andalso
        HeadersMatch.

-spec response_code_matches(expectation(), response_code()) -> boolean().
response_code_matches(#{'response_codes' := ExpectedCodes}, ResponseCode) ->
    case lists:member(ResponseCode, ExpectedCodes) of
        'true' ->
            'true';
        'false' ->
            lager:info(
                "failed expectation: code ~w but expected ~w",
                [ResponseCode, ExpectedCodes]
            ),
            'false'
    end;
response_code_matches(_Expectation, _Code) ->
    'true'.

-spec response_headers_match(expectation(), response_headers()) -> boolean().
response_headers_match(#{'response_headers' := ExpectedHeaders}, RespHeaders) ->
    lists:all(
        fun(ExpectedHeader) -> response_header_matches(ExpectedHeader, RespHeaders) end,
        ExpectedHeaders
    );
response_headers_match(_Expectation, _RespHeaders) ->
    'true'.

-spec response_header_matches({string(), string()}, response_headers()) -> boolean().
response_header_matches({ExpectedHeader, ExpectedValue}, RespHeaders) ->
    kz_term:to_list(ExpectedValue) =:=
        kz_http_util:get_resp_header(kz_term:to_list(ExpectedHeader), RespHeaders).

-spec start_trace() -> {'ok', kz_data_tracing:trace_ref()}.
start_trace() ->
    RequestId =
        case kz_util:get_callid() of
            'undefined' ->
                RID = kz_binary:rand_hex(5),
                kz_util:put_callid(RID),
                RID;
            RID ->
                RID
        end,
    lager:md([{'request_id', RequestId}]),
    put('now', kz_time:now()),

    TracePath = trace_path(),

    TraceFile = filename:join(TracePath, kz_term:to_list(RequestId) ++ ".log"),
    lager:info("tracing at ~s", [TraceFile]),

    {'ok', _} =
        OK = kz_data_tracing:trace_file(
            [glc_ops:eq('request_id', RequestId)],
            TraceFile,
            ?TRACE_FORMAT,
            get_log_level()
        ),
    lager:info("authenticating...~s", [RequestId]),
    OK.

-spec trace_path() -> file:filename_all().
trace_path() ->
    case application:get_env('kazoo_proper', 'trace_path') of
        'undefined' -> "/tmp";
        {'ok', Path} -> Path
    end.

-spec set_log_level(atom()) -> atom().
set_log_level(LogLevel) ->
    put('log_level', LogLevel).

-spec get_log_level() -> atom().
get_log_level() ->
    case get('log_level') of
        'undefined' -> 'debug';
        LogLevel -> LogLevel
    end.

-spec init_api([atom()], [module()]) -> state().
init_api(AppsToStart, ModulesToStart) when
    is_list(AppsToStart) andalso
        is_list(ModulesToStart)
->
    Model = initial_state(AppsToStart, ModulesToStart),
    pqc_kazoo_model:api(Model).

-spec initial_state([atom()], [module()]) -> pqc_kazoo_model:model().
initial_state(AppsToStart, ModulesToStart) ->
    _ = init_system(AppsToStart, ModulesToStart),
    API = authenticate(),
    pqc_kazoo_model:new(API).

-spec init_system([atom()], [module()]) -> 'ok'.
init_system(AppsToStart, ModulesToStart) ->
    TestId = kz_binary:rand_hex(5),
    kz_util:put_callid(TestId),

    _ = kz_data_tracing:clear_all_traces(),
    _ = [
        kapps_controller:start_app(App)
     || App <- AppsToStart
    ],
    _ = [
        crossbar_maintenance:start_module(Mod)
     || Mod <- ModulesToStart
    ],

    lager:info("INIT FINISHED").
