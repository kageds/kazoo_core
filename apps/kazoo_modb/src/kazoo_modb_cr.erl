-module(kazoo_modb_cr).

-export([save_doc/2, save_doc/3, save_doc/4]).
-export([init/0, test/0]).

-define(MAX_RETRIES, 2).

%%--------------------------------------------------------------------
%% @public
%% @doc
%%
%% @end
%%--------------------------------------------------------------------
save_doc(Account, Doc) ->
    save_doc(Account, Doc, []).

save_doc(Account, Doc, Options) when is_list(Options) ->
%%    MaxRetries = props:get_integer_value('max_retries', Options, ?MAX_RETRIES),
    MaxRetries = ?MAX_RETRIES,
    crdb_save(Account, Doc, Options, 'first_try', MaxRetries);
save_doc(Account, Doc, Timestamp) ->
    save_doc(Account, Doc, Timestamp, []).

save_doc(Account, Doc, Timestamp, Options) when is_list(Options) ->
    MaxRetries = props:get_integer_value('max_retries', Options, ?MAX_RETRIES),
    crdb_save(Account, Doc, Options, 'first_try', MaxRetries);
save_doc(Account, Doc, Year, Month) ->
    save_doc(Account, Doc, Year, Month, []).

save_doc(Account, Doc, Year, Month, Options) ->
    MaxRetries = props:get_integer_value('max_retries', Options, ?MAX_RETRIES),
    crdb_save(Account, Doc, Options, 'first_try', MaxRetries).

strip_modb_options(ViewOptions) ->
    [Option || Option <- ViewOptions,
               not is_modb_option(Option)
    ].

is_modb_option({'year', _}) -> 'true';
is_modb_option({'month', _}) -> 'true';
is_modb_option({'create_db', _}) -> 'true';
is_modb_option({'allow_old_modb_creation', _}) -> 'true';
is_modb_option({'ensure_saved', _}) -> 'true';
is_modb_option({'max_retries', _}) -> 'true';
is_modb_option(_) -> 'false'.

crdb_save(AccountMODb, _Doc, _Options, Reason, Retry) when Retry =< 0 ->
    lager:debug("max retries to save doc in ~s: ~p", [AccountMODb, Reason]),
    {'error', Reason};
crdb_save(AccountMODb, Doc, Options, _Reason, Retry) ->
    case save(AccountMODb, Doc, strip_modb_options(Options)) of
        {'ok', _}=Ok -> Ok;
        {'error', 'not_found'} = NotFound ->
            ShouldCreate = props:get_is_true('create_db', Options, 'true'),
            lager:info("modb ~p not found, maybe creating...", [AccountMODb]),
            case ShouldCreate
            of
                'true' ->
                    crdb_save(AccountMODb, Doc, Options, 'not_found', Retry-1);
                'too_old' ->
                    NotFound;
                'false' when ShouldCreate ->
                    lager:info("modb ~s creation failed, maybe due to race condition, re-trying save_doc", [AccountMODb]),
                    crdb_save(AccountMODb, Doc, Options, 'not_found', Retry-1);
                'false' ->
                    lager:info("create_db is false, not creating modb ~s ...", [AccountMODb]),
                    NotFound
            end;
        {'error', 'conflict'}=Conflict -> Conflict;
        {'error', 'timeout'} -> crdb_save(AccountMODb, Doc, Options, 'timeout', Retry-1);
        Error -> Error
    end.

save(MODb, Doc, Options) ->
    pgapp:equery(pgpool, "INSERT INTO cdrs (db_name, cdr) values ($1,$2)", [MODb, Doc]).

init() ->
    {'ok',[],[]} = pgapp:equery(pgpool, "DROP TABLE cdrs", []),
    {'ok',[],[]} = pgapp:equery(pgpool, "CREATE TABLE cdrs (id SERIAL PRIMARY KEY, db_name varchar(80), cdr jsonb NOT NULL)", []).

test() ->
  save_doc(<<"account%2Fdf%2F2d%2Fe8572071dd7d1b115f912cece081-202211">>, {[{<<"_id">>,<<"202211-b84ad181c5afc7facbc09f63db5467fc">>},
  {<<"call_id">>,<<"7c0759da1e680402">>},
  {<<"callee_id_name">>,<<>>},
  {<<"callee_id_number">>,<<"1002">>},
  {<<"caller_id_name">>,<<"Agent One">>},
  {<<"caller_id_number">>,<<"1001">>},
  {<<"cdr_id">>,<<"202211-7c0759da1e680402">>},
  {<<"content_type">>,<<"audio/mpeg">>},
  {<<"custom_channel_vars">>,
   {[{<<"Account-ID">>,<<"df2de8572071dd7d1b115f912cece081">>},
     {<<"Account-Name">>,<<"Call Queues">>},
     {<<"Account-Realm">>,<<"cq.sip.kageds.com">>},
     {<<"Application-Name">>,<<"callflow">>},
     {<<"Application-Node">>,<<"kazoo_apps@aio1.kageds.com">>},
     {<<"Authorizing-ID">>,<<"798bfd9aa7d02b421396c14faba78ef1">>},
     {<<"Authorizing-Type">>,<<"device">>},
     {<<"Bridge-ID">>,<<"7c0759da1e680402">>},
     {<<"Call-Interaction-ID">>,<<"63835148802-df4a1e25">>},
     {<<"CallFlow-ID">>,<<"c5f80392398a6329e6ce8e5cc94da654">>},
     {<<"Channel-Authorized">>,<<"true">>},
     {<<"Ecallmgr-Node">>,<<"ecallmgr@aio1.kageds.com">>},
     {<<"Fetch-ID">>,<<"826d7880-3039-4ff4-83b0-353377e686e4">>},
     {<<"Media-Name">>,<<"1ea89dc470cf12bfe3ecc49501cc652b.mp3">>},
     {<<"Media-Names">>,<<"1ea89dc470cf12bfe3ecc49501cc652b.mp3">>},
     {<<"Media-Recorder">>,<<"kz_media_recording">>},
     {<<"Media-Recording-ID">>,<<"202211-b84ad181c5afc7facbc09f63db5467fc">>},
     {<<"Media-Recordings">>,<<"202211-b84ad181c5afc7facbc09f63db5467fc">>},
     {<<"Owner-ID">>,<<"8724c865ae0bbe97212129c1d988151a">>},
     {<<"Privacy-Hide-Name">>,<<"false">>},
     {<<"Privacy-Hide-Number">>,<<"false">>},
     {<<"Realm">>,<<"cq.sip.kageds.com">>},
     {<<"Username">>,<<"user_apzhwb7d3v">>}]}},
  {<<"description">>,<<"recording 1ea89dc470cf12bfe3ecc49501cc652b.mp3">>},
  {<<"direction">>,<<"inbound">>},
  {<<"duration">>,3},
  {<<"duration_ms">>,3180},
  {<<"from">>,<<"user_apZHWb7d3V@cq.sip.kageds.com">>},
  {<<"interaction_id">>,<<"63835148802-df4a1e25">>},
  {<<"media_source">>,<<"recorded">>},
  {<<"media_type">>,<<"mp3">>},
  {<<"name">>,<<"1ea89dc470cf12bfe3ecc49501cc652b.mp3">>},
  {<<"origin">>,<<"inbound from onnet to account">>},
  {<<"owner_id">>,<<"8724c865ae0bbe97212129c1d988151a">>},
  {<<"request">>,<<"1002@cq.sip.kageds.com">>},
  {<<"source_type">>,<<"kzc_recording">>},
  {<<"start">>,63835148816},
  {<<"to">>,<<"1002@cq.sip.kageds.com">>},
  {<<"pvt_account_id">>,<<"df2de8572071dd7d1b115f912cece081">>},
  {<<"pvt_account_db">>,
   <<"account%2Fdf%2F2d%2Fe8572071dd7d1b115f912cece081-202211">>},
  {<<"pvt_created">>,63835148806},
  {<<"pvt_modified">>,63835148806},
  {<<"pvt_type">>,<<"call_recording">>},
  {<<"pvt_node">>,<<"kazoo_apps@aio1.kageds.com">>},
  {<<"pvt_document_hash">>,<<"1e15b0e01bb701f30d509e154ded9f17">>}]}, [{ensure_saved,true}]).

