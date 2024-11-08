%%%-----------------------------------------------------------------------------
%%% @copyright (C) 2010-2022, 2600Hz
%%% @doc This Source Code Form is subject to the terms of the Mozilla Public
%%% License, v. 2.0. If a copy of the MPL was not distributed with this
%%% file, You can obtain one at https://mozilla.org/MPL/2.0/.
%%%
%%% @end
%%%-----------------------------------------------------------------------------
-module(asr_request).

-export([
    account_db/1,
    set_account_db/2,
    account_id/1,
    set_account_id/2,
    amount/1,
    set_amount/2,
    asr_provider/1,
    set_asr_provider/2,
    attachment/1,
    set_attachment/2,
    billing_method/1,
    billing_seconds/1,
    binary_media/1,
    set_binary_media/2,
    call_id/1,
    content_type/1,
    set_content_type/2,
    description/1,
    set_description/2,
    error/1,
    add_error/2,
    from_call/1,
    from_voicemail/2,
    impact_reseller/1,
    set_impact_reseller/2,
    is_valid/1,
    media_id/1,
    set_media_id/2,
    new/0,
    recording_milliseconds/1,
    set_recording_milliseconds/2,
    reseller_id/1, reseller_id/2,
    set_reseller_id/2,
    services/1,
    set_services/2,
    setters/2,
    timestamp/1,
    set_timestamp/2,
    modb/1,
    set_modb/2,
    transcribe/1,
    transcription/1,
    set_transcription/2,
    validate/1
]).

-type setter_fun_1() :: fun((asr_req()) -> asr_req()).
-type setter_fun_2() :: fun((asr_req(), any()) -> asr_req()).
-type setter_fun_3() :: fun((asr_req(), any(), any()) -> asr_req()).
-type setter_fun() :: setter_fun_1() | setter_fun_2() | setter_fun_3().
-export_type([
    setter_fun/0,
    setter_fun_1/0,
    setter_fun_2/0,
    setter_fun_3/0,
    setters/0
]).

-type setter_kv() ::
    setter_fun_1()
    | {setter_fun_2(), any()}
    | {setter_fun_3(), any(), any()}.
-type setters() :: [setter_kv()].

-include("kazoo_speech.hrl").

-define(ASR_TRIM_MEDIA_ENABLED,
    kapps_config:get_boolean(?MOD_CONFIG_CAT, <<"asr_trim_media_enabled">>, 'false')
).
-define(ASR_TRIM_MEDIA_SECONDS,
    kapps_config:get_integer(?MOD_CONFIG_CAT, <<"asr_trim_media_seconds">>, 60)
).
-define(MEDIA_NORMALIZE_EXECUTABLE,
    kapps_config:get_binary(<<"media">>, <<"normalize_executable">>, <<"sox">>)
).

%%------------------------------------------------------------------------------
%% @doc account_db getter
%% @end
%%------------------------------------------------------------------------------
-spec account_db(asr_req()) -> kz_term:ne_binary().
account_db(#asr_req{account_db = AccountDb}) -> AccountDb.

%%------------------------------------------------------------------------------
%% @doc account_id getter
%% @end
%%------------------------------------------------------------------------------
-spec account_id(asr_req()) -> kz_term:ne_binary().
account_id(#asr_req{account_id = AccountId}) -> AccountId.

%%------------------------------------------------------------------------------
%% @doc amount getter
%% @end
%%------------------------------------------------------------------------------
-spec amount(asr_req()) -> non_neg_integer().
amount(#asr_req{amount = Amount}) -> Amount.

%%------------------------------------------------------------------------------
%% @doc asr_provider getter
%% @end
%%------------------------------------------------------------------------------
-spec asr_provider(asr_req()) -> kz_term:ne_binary().
asr_provider(#asr_req{asr_provider = ASRProvider}) -> ASRProvider.

%%------------------------------------------------------------------------------
%% @doc attachment getter
%% @end
%%------------------------------------------------------------------------------
-spec attachment(asr_req()) -> kz_term:ne_binary().
attachment(#asr_req{attachment_id = AttachmentId}) -> AttachmentId.

%%------------------------------------------------------------------------------
%% @doc attachment getter
%% @end
%%------------------------------------------------------------------------------
-spec authorize(asr_req()) -> asr_req().
authorize(#asr_req{billing_method = BillingMethod} = Request) -> BillingMethod:authorize(Request).

%%------------------------------------------------------------------------------
%% @doc billing_method getter
%% @end
%%------------------------------------------------------------------------------
-spec billing_method(asr_req()) -> asr_billing_method().
billing_method(#asr_req{billing_method = BillingMethod}) -> BillingMethod.

%%------------------------------------------------------------------------------
%% @doc billing_seconds getter
%% @end
%%------------------------------------------------------------------------------
-spec billing_seconds(asr_req()) -> non_neg_integer().
billing_seconds(#asr_req{billing_seconds = BillingSecs}) -> BillingSecs.

%%------------------------------------------------------------------------------
%% @doc asr request binary_media getter
%% @end
%%------------------------------------------------------------------------------
-spec binary_media(asr_req()) -> binary().
binary_media(#asr_req{binary_media = BinaryMedia}) -> BinaryMedia.

%%------------------------------------------------------------------------------
%% @doc call_id getter
%% @end
%%------------------------------------------------------------------------------
-spec call_id(asr_req()) -> kz_term:ne_binary().
call_id(#asr_req{call_id = CallId}) -> CallId.

%%------------------------------------------------------------------------------
%% @doc content_type getter
%% @end
%%------------------------------------------------------------------------------
-spec content_type(asr_req()) -> kz_term:ne_binary().
content_type(#asr_req{content_type = ContentType}) -> ContentType.

%%------------------------------------------------------------------------------
%% @doc transcription description getter
%% @end
%%------------------------------------------------------------------------------
-spec description(asr_req()) -> kz_term:ne_binary().
description(#asr_req{description = Description}) -> Description.

%%------------------------------------------------------------------------------
%% @doc error getter
%% @end
%%------------------------------------------------------------------------------
-spec error(asr_req()) ->
    'undefined'
    | {'error', provider_error()}
    | {'error', 'asr_provider_failure', kz_term:ne_binary()}.
error(#asr_req{error = Error}) -> Error.

%%------------------------------------------------------------------------------
%% @doc error setter
%% @end
%%------------------------------------------------------------------------------
-spec add_error(asr_req(), provider_return()) -> asr_req().
add_error(Request, {'error', _} = Error) -> Request#asr_req{error = Error};
add_error(Request, {'error', 'asr_provider_failure', _} = Error) -> Request#asr_req{error = Error};
add_error(Request, _) -> Request.

%%------------------------------------------------------------------------------
%% @doc
%% @end
%%------------------------------------------------------------------------------
fetch_attachment(
    #asr_req{account_modb = AccountMODB, attachment_id = AttachmentId, media_id = MediaId} =
        _Request
) ->
    case kz_datamgr:fetch_attachment(AccountMODB, MediaId, AttachmentId) of
        {'ok', Bin} ->
            lager:info("transcribing first attachment ~s", [AttachmentId]),
            Bin;
        {'error', E} ->
            lager:error("error fetching vm: ~p", [E]),
            'undefined'
    end.

%%------------------------------------------------------------------------------
%% @doc create asr_request record from a kapps_call record
%% @end
%%------------------------------------------------------------------------------
-spec from_call(kapps_call:call()) -> asr_req().
from_call(Call) ->
    from_call(new(), Call).

-spec from_call(asr_req(), kapps_call:call()) -> asr_req().
from_call(Request, Call) ->
    AccountId = kapps_call:account_id(Call),
    ASRProvider = kazoo_asr:default_provider(),
    Request#asr_req{
        'account_authorized' = 'false',
        'account_db' = kapps_call:account_db(Call),
        'account_id' = AccountId,
        'asr_provider' = ASRProvider,
        'call_id' = kapps_call:call_id(Call),
        'description' = <<ASRProvider/binary, " ASR transcription">>,
        'reseller_id' = kz_services_reseller:get_id(AccountId),
        'services' = kz_services:fetch(AccountId)
    }.
%%------------------------------------------------------------------------------
%% @doc
%% @end
%%------------------------------------------------------------------------------
-spec from_voicemail(kapps_call:call(), kz_term:ne_binary()) -> asr_req().
from_voicemail(Call, MediaId) ->
    Setters = [
        {fun from_call/2, Call},
        {fun set_media_id/2, MediaId},
        fun set_attachment_metadata/1
    ],
    setters(new(), Setters).

%%------------------------------------------------------------------------------
%% @doc should we bill the reseller
%% @end
%%------------------------------------------------------------------------------
-spec impact_reseller(asr_req()) -> boolean().
impact_reseller(#asr_req{impact_reseller = ImpactReseller}) -> ImpactReseller.

%%------------------------------------------------------------------------------
%% @doc determine if we should also propagate billing to the reseller
%% @end
%%------------------------------------------------------------------------------
-spec maybe_impact_reseller(asr_req()) -> boolean().
maybe_impact_reseller(#asr_req{account_id = AccountId, reseller_id = ResellerId}) ->
    maybe_impact_reseller(ResellerId, AccountId).

-spec maybe_impact_reseller(kz_term:ne_binary(), kz_term:ne_binary()) -> boolean().
maybe_impact_reseller(_ResellerId = ?NE_BINARY, _AccountId = ?NE_BINARY) -> 'true';
maybe_impact_reseller(_ResellerId = 'undefined', _AccountId = ?NE_BINARY) -> 'false';
maybe_impact_reseller(_ResellerId = _, _AccountId = _) -> 'false'.

%%------------------------------------------------------------------------------
%% @doc If the request has passed validation (request's `validated' is true),
%% load the binary media attachment from db and store it in the request.
%% @end
%%------------------------------------------------------------------------------
-spec load_binary_media_into_request(asr_req()) -> asr_req().
load_binary_media_into_request(#asr_req{validated = 'false'} = Request) ->
    Request;
load_binary_media_into_request(#asr_req{} = Request) ->
    case fetch_attachment(Request) of
        'undefined' ->
            add_error(Request, {'error', 'media_not_found'});
        BinaryMedia ->
            set_binary_media(Request, BinaryMedia)
    end.

%%------------------------------------------------------------------------------
%% @doc If `?ASR_TRIM_MEDIA_LENGTH' is true and the media length is greater than
%% `?ASR_TRIM_MEDIA_SECONDS', then trim the media to `?ASR_TRIM_MEDIA_SECONDS'
%% and update the request with the trimmed media and new `recording_milliseconds'
%% length.
%% If the request's `validated' field is set to false or `binary_media' is set
%% to `undefined', then skip any trim checks and return the unaltered request.
%% @end
%%------------------------------------------------------------------------------
-spec maybe_trim_binary_media_length(asr_req()) -> asr_req().
maybe_trim_binary_media_length(#asr_req{validated = 'false'} = Request) ->
    Request;
maybe_trim_binary_media_length(#asr_req{binary_media = 'undefined'} = Request) ->
    Request;
maybe_trim_binary_media_length(#asr_req{recording_milliseconds = RecordingMilliseconds} = Request) ->
    ConfigTrimLengthMillisec = (?ASR_TRIM_MEDIA_SECONDS * 1000),
    case
        ?ASR_TRIM_MEDIA_ENABLED andalso
            RecordingMilliseconds > ConfigTrimLengthMillisec
    of
        'false' -> Request;
        'true' -> trim_binary_media_length(Request, ConfigTrimLengthMillisec)
    end.

%%------------------------------------------------------------------------------
%% @doc Trim the request's `binary_media' to a length defined in milliseconds.
%% If the request's `binary_media' is `undefined' then return the unaltered
%% request.
%% If the trim operation fails then return the request with the error set.
%% If the trim is successful then update the request's `binary_media' and
%% `recording_milliseconds' with the trimmed values.
%% @end
%%------------------------------------------------------------------------------
-spec trim_binary_media_length(asr_req(), integer()) -> asr_req().
trim_binary_media_length(#asr_req{binary_media = 'undefined'} = Request, _TrimLengthMillisec) ->
    Request;
trim_binary_media_length(
    #asr_req{
        binary_media = BinaryMedia,
        attachment_id = AttachmentId,
        recording_milliseconds = RecordingMilliseconds
    } = Request,
    TrimLengthMillisec
) ->
    lager:debug("trimming media to ~p (currently ~b) milliseconds", [
        TrimLengthMillisec, RecordingMilliseconds
    ]),
    SrcFile = filename:join(?TMP_PATH, AttachmentId),
    TrimmedFile = filename:join(?TMP_PATH, <<"trimmed-", AttachmentId/binary>>),
    kz_util:write_file(SrcFile, BinaryMedia),
    Command = generate_trim_media_command(
        ?MEDIA_NORMALIZE_EXECUTABLE,
        SrcFile,
        TrimmedFile,
        TrimLengthMillisec
    ),
    CommandResp = kz_os:cmd(Command),
    case file:read_file(TrimmedFile) of
        {'ok', TrimmedBinaryMedia} ->
            _ = file:delete(SrcFile),
            _ = file:delete(TrimmedFile),
            set_recording_milliseconds(
                set_binary_media(Request, TrimmedBinaryMedia), TrimLengthMillisec
            );
        {'error', _R} ->
            lager:error("failed to trim media with command '~s', response: ~p", [
                Command, CommandResp
            ]),
            _ = file:delete(SrcFile),
            add_error(Request, {'error', CommandResp})
    end.

%%------------------------------------------------------------------------------
%% @doc For an executable, generate and return the command to be run to trim
%% an audio file to `TrimLengthMillisec'.
%% @end
%%------------------------------------------------------------------------------
-spec generate_trim_media_command(
    kz_term:ne_binary(), kz_term:ne_binary(), kz_term:ne_binary(), integer()
) -> 'undefined' | io_lib:chars().
generate_trim_media_command(<<"sox">>, SrcFile, DestFile, TrimLengthMillisec) ->
    io_lib:format("sox ~s ~s trim 0 ~f", [
        SrcFile,
        DestFile,
        (TrimLengthMillisec / 1000)
    ]);
generate_trim_media_command(<<"ffmpeg">>, SrcFile, DestFile, TrimLengthMillisec) ->
    io_lib:format("ffmpeg -i ~s -ss 0 -to ~f -c copy ~s", [
        SrcFile,
        (TrimLengthMillisec / 1000),
        DestFile
    ]);
generate_trim_media_command(Executable, _SrcFile, _DestFile, _TrimLengthMillisec) ->
    lager:error("missing trim command for executable '~p', not implemented", [Executable]),
    'undefined'.

%%------------------------------------------------------------------------------
%% @doc Transcribe the media if the request's `validated' is true and
%% request's `binary_media' is not `undefined'.
%% @end
%%------------------------------------------------------------------------------
maybe_transcribe(#asr_req{validated = 'false'} = Request) ->
    Request;
maybe_transcribe(#asr_req{binary_media = 'undefined'} = Request) ->
    Request;
maybe_transcribe(
    #asr_req{
        account_modb = AccountDb,
        content_type = ContentType,
        media_id = MediaId,
        binary_media = Bin
    } = Request
) ->
    {'ok', MediaDoc} = kz_datamgr:open_doc(AccountDb, MediaId),
    case kazoo_asr:freeform(Bin, ContentType) of
        {'ok', Resp} ->
            lager:info("transcription resp: ~p", [Resp]),
            MediaDoc1 = kz_json:set_value(<<"transcription">>, Resp, MediaDoc),
            _ = kz_datamgr:ensure_saved(AccountDb, MediaDoc1),
            Resp0 = is_valid_transcription(
                kz_json:get_value(<<"result">>, Resp),
                kz_json:get_value(<<"text">>, Resp),
                Resp
            ),
            set_transcription(Request, Resp0);
        {'error', ErrorCode} = Err ->
            lager:error("error transcribing: ~p", [ErrorCode]),
            add_error(Request, Err);
        {'error', ErrorCode, Description} = Err ->
            lager:error("error transcribing: ~p, ~p", [ErrorCode, Description]),
            add_error(Request, Err)
    end.

%%------------------------------------------------------------------------------
%% @doc media_id getter
%% @end
%%------------------------------------------------------------------------------
-spec media_id(asr_req()) -> kz_term:ne_binary().
media_id(#asr_req{media_id = MediaId}) -> MediaId.

%%------------------------------------------------------------------------------
%% @doc modb getter
%% @end
%%------------------------------------------------------------------------------
-spec modb(asr_req()) -> kz_term:ne_binary().
modb(#asr_req{account_modb = AccountMODB}) -> AccountMODB.

%%------------------------------------------------------------------------------
%% @doc create empty asr_req record
%% @end
%%------------------------------------------------------------------------------
-spec new() -> asr_req().
new() -> #asr_req{}.

%%------------------------------------------------------------------------------
%% @doc recording duration getter
%% @end
%%------------------------------------------------------------------------------
-spec recording_milliseconds(asr_req()) -> non_neg_integer().
recording_milliseconds(#asr_req{recording_milliseconds = Duration}) -> Duration.

%%------------------------------------------------------------------------------
%% @doc reseller_id getter
%% @end
%%------------------------------------------------------------------------------
-spec reseller_id(asr_req()) -> kz_term:ne_binary().
reseller_id(#asr_req{reseller_id = ResellerId}) -> ResellerId.

%%------------------------------------------------------------------------------
%% @doc reseller_id getter from CCVs
%% @end
%%------------------------------------------------------------------------------
-spec reseller_id(kz_term:ne_binary(), kz_json:object()) -> kz_term:ne_binary().
reseller_id(AccountId, CCVs) ->
    case kz_json:get_value(<<"Reseller-ID">>, CCVs) of
        'undefined' -> kz_services_reseller:find_id(AccountId);
        ResellerId -> ResellerId
    end.

%%------------------------------------------------------------------------------
%% @doc services
%% @end
%%------------------------------------------------------------------------------
-spec services(asr_req()) -> kz_services:services().
services(#asr_req{services = Services}) -> Services.

%%------------------------------------------------------------------------------
%% @doc account_db setter
%% @end
%%------------------------------------------------------------------------------
-spec set_account_db(asr_req(), kz_term:ne_binary()) -> asr_req().
set_account_db(Request, AccountDb) ->
    Request#asr_req{account_db = AccountDb}.

%%------------------------------------------------------------------------------
%% @doc account_id setter
%% @end
%%------------------------------------------------------------------------------
-spec set_account_id(asr_req(), kz_term:ne_binary()) -> asr_req().
set_account_id(Request, AccountId) ->
    Request#asr_req{account_id = AccountId}.

%%------------------------------------------------------------------------------
%% @doc amount getter
%% @end
%%------------------------------------------------------------------------------
-spec set_amount(asr_req(), non_neg_integer()) -> asr_req().
set_amount(Request, Amount) ->
    Request#asr_req{amount = Amount}.

%%------------------------------------------------------------------------------
%% @doc asr_provider setter
%% @end
%%------------------------------------------------------------------------------
-spec set_asr_provider(asr_req(), kz_term:ne_binary()) -> asr_req().
set_asr_provider(Request, ASRProvider) ->
    Request#asr_req{asr_provider = ASRProvider}.

%%------------------------------------------------------------------------------
%% @doc
%% @end
%%------------------------------------------------------------------------------
-spec set_attachment(asr_req(), kz_term:ne_binary()) -> asr_req().
set_attachment(Request, AttachmentId) ->
    Request#asr_req{attachment_id = AttachmentId}.

-spec set_attachment_metadata(asr_req()) -> asr_req().
set_attachment_metadata(#asr_req{account_id = AccountId, media_id = MediaId} = Request) ->
    AccountMODB = kvm_util:get_db(AccountId, MediaId),
    {'ok', MediaDoc} = kz_datamgr:open_doc(AccountMODB, MediaId),
    case kz_doc:attachment_names(MediaDoc) of
        [] ->
            lager:warning("no audio attachments on media doc ~s: ~p", [MediaId, MediaDoc]),
            'undefined';
        [AttachmentId | _] ->
            ContentType = kz_doc:attachment_content_type(MediaDoc, AttachmentId),
            Setters = [
                {fun set_content_type/2, ContentType},
                {fun set_modb/2, AccountMODB},
                {fun set_attachment/2, AttachmentId},
                {fun set_recording_milliseconds/2, kzd_box_message:length(MediaDoc)},
                {fun set_timestamp/2, kzd_box_message:utc_seconds(MediaDoc)},
                {fun set_impact_reseller/2, maybe_impact_reseller(Request)}
            ],
            setters(Request, Setters)
    end.

%%------------------------------------------------------------------------------
%% @doc binary_media response setter
%% @end
%%------------------------------------------------------------------------------
-spec set_binary_media(asr_req(), 'undefined' | binary()) -> asr_req().
set_binary_media(Request, BinaryMedia) ->
    Request#asr_req{binary_media = BinaryMedia}.

%%------------------------------------------------------------------------------
%% @doc media content_type setter
%% @end
%%------------------------------------------------------------------------------
-spec set_content_type(asr_req(), kz_term:ne_binary()) -> asr_req().
set_content_type(Request, ContentType) ->
    Request#asr_req{content_type = ContentType}.

%%------------------------------------------------------------------------------
%% @doc description setter
%% @end
%%------------------------------------------------------------------------------
-spec set_description(asr_req(), kz_term:ne_binary()) -> asr_req().
set_description(Request, Description) ->
    Request#asr_req{description = Description}.

%%------------------------------------------------------------------------------
%% @doc
%% @end
%%------------------------------------------------------------------------------
-spec set_impact_reseller(asr_req(), boolean()) -> asr_req().
set_impact_reseller(Request, ImpactReseller) ->
    Request#asr_req{impact_reseller = ImpactReseller}.

%%------------------------------------------------------------------------------
%% @doc voicemail/recording's media_id setter
%% @end
%%------------------------------------------------------------------------------
-spec set_media_id(asr_req(), kz_term:ne_binary()) -> asr_req().
set_media_id(Request, MediaId) ->
    Request#asr_req{media_id = MediaId}.

%%------------------------------------------------------------------------------
%% @doc voicemail/recording's media_id setter
%% @end
%%------------------------------------------------------------------------------
-spec set_modb(asr_req(), kz_term:ne_binary()) -> asr_req().
set_modb(Request, AccountMODB) ->
    Request#asr_req{account_modb = AccountMODB}.

%%------------------------------------------------------------------------------
%% @doc voicemail/recording's media_id setter
%% @end
%%------------------------------------------------------------------------------
-spec set_recording_milliseconds(asr_req(), non_neg_integer()) -> asr_req().
set_recording_milliseconds(Request, Duration) ->
    Request#asr_req{recording_milliseconds = Duration}.

%%------------------------------------------------------------------------------
%% @doc reseller_id setter
%% @end
%%------------------------------------------------------------------------------
-spec set_reseller_id(asr_req(), kz_term:ne_binary()) -> asr_req().
set_reseller_id(Request, ResellerId) ->
    Request#asr_req{reseller_id = ResellerId}.

%%------------------------------------------------------------------------------
%% @doc
%% @end
%%------------------------------------------------------------------------------
-spec set_services(asr_req(), kz_services:services()) -> asr_req().
set_services(Request, Services) ->
    Request#asr_req{services = Services}.

%%------------------------------------------------------------------------------
%% @doc
%% @end
%%------------------------------------------------------------------------------
-spec set_timestamp(asr_req(), non_neg_integer()) -> asr_req().
set_timestamp(Request, Timestamp) ->
    Request#asr_req{timestamp = Timestamp}.

%%------------------------------------------------------------------------------
%% @doc transcription response setter
%% @end
%%------------------------------------------------------------------------------
-spec set_transcription(asr_req(), 'undefined' | asr_resp()) -> asr_req().
set_transcription(Request, Transcription) ->
    Request#asr_req{transcription = Transcription}.

%%------------------------------------------------------------------------------
%% @doc fold over list of functions to set asr_req fields
%% @end
%%------------------------------------------------------------------------------
-spec setters(asr_req(), setters()) -> asr_req().
setters(Request, []) -> Request;
setters(Request, [_ | _] = Setters) -> lists:foldl(fun setters_fold/2, Request, Setters).

%%------------------------------------------------------------------------------
%% @doc fold fun patterns for setters
%% @end
%%------------------------------------------------------------------------------
-spec setters_fold(setter_kv(), asr_req()) -> asr_req().
setters_fold({F, V}, R) -> F(R, V);
setters_fold({F, K, V}, R) -> F(R, K, V);
setters_fold(F, R) when is_function(F, 1) -> F(R).

%%------------------------------------------------------------------------------
%% @doc
%% @end
%%------------------------------------------------------------------------------
-spec timestamp(asr_req()) -> non_neg_integer().
timestamp(#asr_req{timestamp = Timestamp}) -> Timestamp.

%%------------------------------------------------------------------------------
%% @doc
%% @end
%%------------------------------------------------------------------------------
-spec transcribe(asr_req()) -> asr_req().
transcribe(Request) ->
    Validators = [
        fun authorize/1,
        fun validate/1,
        fun load_binary_media_into_request/1,
        fun maybe_trim_binary_media_length/1,
        fun maybe_transcribe/1,
        fun debit/1
    ],
    lists:foldl(
        fun(F, RequestAcc) when is_function(F, 1) -> F(RequestAcc) end,
        Request,
        Validators
    ).

-spec debit(asr_req()) -> asr_req().
debit(#asr_req{error = {'error', _}} = Request) ->
    Request;
debit(#asr_req{error = {'error', 'asr_provider_failure', _}} = Request) ->
    Request;
debit(#asr_req{billing_method = BillingMethod, error = 'undefined'} = Request) ->
    BillingMethod:debit(Request).

%%------------------------------------------------------------------------------
%% @doc transcription response getter
%% @end
%%------------------------------------------------------------------------------
-spec transcription(asr_req()) -> 'undefined' | asr_resp().
transcription(#asr_req{transcription = Transcription}) -> Transcription.

%%------------------------------------------------------------------------------
%% @doc did the asr_request pass validation
%% @end
%%------------------------------------------------------------------------------
-spec is_valid(asr_req()) -> boolean().
is_valid(#asr_req{validated = Valid}) -> Valid.

%%------------------------------------------------------------------------------
%% @doc
%% @end
%%------------------------------------------------------------------------------
-spec is_valid_transcription(kz_term:api_binary(), binary(), kz_json:object()) ->
    'undefined' | kz_term:api_object().
is_valid_transcription(<<"success">>, ?NE_BINARY, Resp) ->
    Resp;
is_valid_transcription(<<"success">>, <<"">>, Resp) ->
    lager:info("successful but empty transcription"),
    Resp;
is_valid_transcription(Res, Txt, _) ->
    lager:info("not a valid transcription: ~s: '~s'", [Res, Txt]),
    'undefined'.

%%------------------------------------------------------------------------------
%% @doc validate the content can be processed
%% @end
%%------------------------------------------------------------------------------
-spec validate(asr_req()) -> asr_req().
validate(
    #asr_req{account_authorized = 'true', reseller_authorized = 'true', content_type = ContentType} =
        Request
) ->
    case lists:member(ContentType, kazoo_asr:accepted_content_types()) of
        'false' ->
            lager:info("content type ~s cannot be converted for transcription", [ContentType]),
            add_error(Request, {'error', 'unsupported_content_type'});
        'true' ->
            Request#asr_req{validated = 'true'}
    end;
validate(Request) ->
    Request.
