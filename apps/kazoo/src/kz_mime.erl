%%%-----------------------------------------------------------------------------
%%% @copyright (C) 2011-2022, 2600Hz
%%% @doc Utilities for working with file extensions.
%%% @end
%%%-----------------------------------------------------------------------------
-module(kz_mime).

-export([to_extension/1, to_extensions/1]).
-export([from_extension/1]).
-export([from_filename/1]).
-export([to_filename/1]).
-export([normalize_content_type/1]).

%%------------------------------------------------------------------------------
%% @doc Transform a mimetype to an extension
%%      Example:
%%
%% ```
%% 1> kz_mime:to_extensions(<<"text/plain">>).
%% [<<"txt">>,<<"text">>,<<"conf">>,<<"def">>,<<"list">>,<<"log">>,<<"in">>]
%% 2> kz_mime:to_extension(<<"text/plain">>).
%% <<"txt">>
%% '''
%% @end
%%------------------------------------------------------------------------------

-spec to_extension(binary()) -> binary().
to_extension(CT) ->
    hd(to_extensions(CT)).

%%------------------------------------------------------------------------------
%% @doc Return the mime-type for any file by looking at its extension.
%% Example:
%%
%% ```
%% 1> kz_mime:from_filename(<<"test.cpp">>).
%% <<"text/x-c">>
%% '''
%% @end
%%------------------------------------------------------------------------------

-spec from_filename(file:filename_all()) -> binary().
from_filename(Path) ->
    from_extension(filename:extension(Path)).

%%------------------------------------------------------------------------------
%% @doc generate a filename with extension for content-type.
%%
%% Example:
%%
%% ```
%% 1> kz_mime:to_filename(<<"text/plain">>).
%% <<"1345678wdfghjk34rtghjk.txt">>
%% '''
%% @end
%%------------------------------------------------------------------------------

-spec to_filename(binary()) -> binary().
to_filename(CT) ->
    list_to_binary([kz_binary:rand_hex(16), ".", hd(to_extensions(CT))]).

%%------------------------------------------------------------------------------
%% @doc normalize the content types.
%%
%% Example:
%%
%% ```
%% 1> kz_mime:normalize_content_type(<<"image/tiff">>).
%% <<"image/tiff">>
%% '''
%% @todo make this work for all the content typs in applications/crossbar/src/crossbar_types.hrl
%%
%% @end
%%------------------------------------------------------------------------------
-spec normalize_content_type(kz_term:text()) -> kz_term:ne_binary().
normalize_content_type(<<"image/tif">>) -> <<"image/tiff">>;
normalize_content_type(<<"image/x-tif">>) -> <<"image/tiff">>;
normalize_content_type(<<"image/tiff">>) -> <<"image/tiff">>;
normalize_content_type(<<"image/x-tiff">>) -> <<"image/tiff">>;
normalize_content_type(<<"application/tif">>) -> <<"image/tiff">>;
normalize_content_type(<<"apppliction/x-tif">>) -> <<"image/tiff">>;
normalize_content_type(<<"apppliction/tiff">>) -> <<"image/tiff">>;
normalize_content_type(<<"apppliction/x-tiff">>) -> <<"image/tiff">>;
normalize_content_type(<<"application/pdf">>) -> <<"application/pdf">>;
normalize_content_type(<<"application/x-pdf">>) -> <<"application/pdf">>;
normalize_content_type(<<"text/pdf">>) -> <<"application/pdf">>;
normalize_content_type(<<"text/x-pdf">>) -> <<"application/pdf">>;
normalize_content_type(<<_/binary>> = Else) -> Else;
normalize_content_type(CT) -> normalize_content_type(kz_term:to_binary(CT)).

%%------------------------------------------------------------------------------
%% @doc Return the mime type for any file by looking at its extension.
%%
%% Example:
%%
%% ```
%% 1> kzd_mime:from_extension(<<".c">>).
%% <<"text/x-c">>
%% '''
%% @end
%%------------------------------------------------------------------------------

-spec from_extension(binary()) -> binary().

%% GENERATED
from_extension(Ext) when not is_binary(Ext) -> from_extension(kz_term:to_lower_binary(Ext));
from_extension(<<$., Ext/binary>>) ->
    from_extension(kz_term:to_lower_binary(Ext));
from_extension(<<"123">>) ->
    <<"application/vnd.lotus-1-2-3">>;
from_extension(<<"3dml">>) ->
    <<"text/vnd.in3d.3dml">>;
from_extension(<<"3ds">>) ->
    <<"image/x-3ds">>;
from_extension(<<"3g2">>) ->
    <<"video/3gpp2">>;
from_extension(<<"3gp">>) ->
    <<"video/3gpp">>;
from_extension(<<"7z">>) ->
    <<"application/x-7z-compressed">>;
from_extension(<<"aab">>) ->
    <<"application/x-authorware-bin">>;
from_extension(<<"aac">>) ->
    <<"audio/x-aac">>;
from_extension(<<"aam">>) ->
    <<"application/x-authorware-map">>;
from_extension(<<"aas">>) ->
    <<"application/x-authorware-seg">>;
from_extension(<<"abw">>) ->
    <<"application/x-abiword">>;
from_extension(<<"ac">>) ->
    <<"application/pkix-attr-cert">>;
from_extension(<<"acc">>) ->
    <<"application/vnd.americandynamics.acc">>;
from_extension(<<"ace">>) ->
    <<"application/x-ace-compressed">>;
from_extension(<<"acu">>) ->
    <<"application/vnd.acucobol">>;
from_extension(<<"acutc">>) ->
    <<"application/vnd.acucorp">>;
from_extension(<<"adp">>) ->
    <<"audio/adpcm">>;
from_extension(<<"aep">>) ->
    <<"application/vnd.audiograph">>;
from_extension(<<"afm">>) ->
    <<"application/x-font-type1">>;
from_extension(<<"afp">>) ->
    <<"application/vnd.ibm.modcap">>;
from_extension(<<"ahead">>) ->
    <<"application/vnd.ahead.space">>;
from_extension(<<"ai">>) ->
    <<"application/postscript">>;
from_extension(<<"aif">>) ->
    <<"audio/x-aiff">>;
from_extension(<<"aifc">>) ->
    <<"audio/x-aiff">>;
from_extension(<<"aiff">>) ->
    <<"audio/x-aiff">>;
from_extension(<<"air">>) ->
    <<"application/vnd.adobe.air-application-installer-package+zip">>;
from_extension(<<"ait">>) ->
    <<"application/vnd.dvb.ait">>;
from_extension(<<"ami">>) ->
    <<"application/vnd.amiga.ami">>;
from_extension(<<"apk">>) ->
    <<"application/vnd.android.package-archive">>;
from_extension(<<"appcache">>) ->
    <<"text/cache-manifest">>;
from_extension(<<"application">>) ->
    <<"application/x-ms-application">>;
from_extension(<<"apr">>) ->
    <<"application/vnd.lotus-approach">>;
from_extension(<<"arc">>) ->
    <<"application/x-freearc">>;
from_extension(<<"asc">>) ->
    <<"application/pgp-signature">>;
from_extension(<<"asf">>) ->
    <<"video/x-ms-asf">>;
from_extension(<<"asm">>) ->
    <<"text/x-asm">>;
from_extension(<<"aso">>) ->
    <<"application/vnd.accpac.simply.aso">>;
from_extension(<<"asx">>) ->
    <<"video/x-ms-asf">>;
from_extension(<<"atc">>) ->
    <<"application/vnd.acucorp">>;
from_extension(<<"atom">>) ->
    <<"application/atom+xml">>;
from_extension(<<"atomcat">>) ->
    <<"application/atomcat+xml">>;
from_extension(<<"atomsvc">>) ->
    <<"application/atomsvc+xml">>;
from_extension(<<"atx">>) ->
    <<"application/vnd.antix.game-component">>;
from_extension(<<"au">>) ->
    <<"audio/basic">>;
from_extension(<<"avi">>) ->
    <<"video/x-msvideo">>;
from_extension(<<"avif">>) ->
    <<"image/avif">>;
from_extension(<<"aw">>) ->
    <<"application/applixware">>;
from_extension(<<"azf">>) ->
    <<"application/vnd.airzip.filesecure.azf">>;
from_extension(<<"azs">>) ->
    <<"application/vnd.airzip.filesecure.azs">>;
from_extension(<<"azw">>) ->
    <<"application/vnd.amazon.ebook">>;
from_extension(<<"bat">>) ->
    <<"application/x-msdownload">>;
from_extension(<<"bcpio">>) ->
    <<"application/x-bcpio">>;
from_extension(<<"bdf">>) ->
    <<"application/x-font-bdf">>;
from_extension(<<"bdm">>) ->
    <<"application/vnd.syncml.dm+wbxml">>;
from_extension(<<"bed">>) ->
    <<"application/vnd.realvnc.bed">>;
from_extension(<<"bh2">>) ->
    <<"application/vnd.fujitsu.oasysprs">>;
from_extension(<<"bin">>) ->
    <<"application/octet-stream">>;
from_extension(<<"blb">>) ->
    <<"application/x-blorb">>;
from_extension(<<"blorb">>) ->
    <<"application/x-blorb">>;
from_extension(<<"bmi">>) ->
    <<"application/vnd.bmi">>;
from_extension(<<"bmp">>) ->
    <<"image/bmp">>;
from_extension(<<"book">>) ->
    <<"application/vnd.framemaker">>;
from_extension(<<"box">>) ->
    <<"application/vnd.previewsystems.box">>;
from_extension(<<"boz">>) ->
    <<"application/x-bzip2">>;
from_extension(<<"bpk">>) ->
    <<"application/octet-stream">>;
from_extension(<<"btif">>) ->
    <<"image/prs.btif">>;
from_extension(<<"bz">>) ->
    <<"application/x-bzip">>;
from_extension(<<"bz2">>) ->
    <<"application/x-bzip2">>;
from_extension(<<"c">>) ->
    <<"text/x-c">>;
from_extension(<<"c11amc">>) ->
    <<"application/vnd.cluetrust.cartomobile-config">>;
from_extension(<<"c11amz">>) ->
    <<"application/vnd.cluetrust.cartomobile-config-pkg">>;
from_extension(<<"c4d">>) ->
    <<"application/vnd.clonk.c4group">>;
from_extension(<<"c4f">>) ->
    <<"application/vnd.clonk.c4group">>;
from_extension(<<"c4g">>) ->
    <<"application/vnd.clonk.c4group">>;
from_extension(<<"c4p">>) ->
    <<"application/vnd.clonk.c4group">>;
from_extension(<<"c4u">>) ->
    <<"application/vnd.clonk.c4group">>;
from_extension(<<"cab">>) ->
    <<"application/vnd.ms-cab-compressed">>;
from_extension(<<"caf">>) ->
    <<"audio/x-caf">>;
from_extension(<<"cap">>) ->
    <<"application/vnd.tcpdump.pcap">>;
from_extension(<<"car">>) ->
    <<"application/vnd.curl.car">>;
from_extension(<<"cat">>) ->
    <<"application/vnd.ms-pki.seccat">>;
from_extension(<<"cb7">>) ->
    <<"application/x-cbr">>;
from_extension(<<"cba">>) ->
    <<"application/x-cbr">>;
from_extension(<<"cbr">>) ->
    <<"application/x-cbr">>;
from_extension(<<"cbt">>) ->
    <<"application/x-cbr">>;
from_extension(<<"cbz">>) ->
    <<"application/x-cbr">>;
from_extension(<<"cc">>) ->
    <<"text/x-c">>;
from_extension(<<"cct">>) ->
    <<"application/x-director">>;
from_extension(<<"ccxml">>) ->
    <<"application/ccxml+xml">>;
from_extension(<<"cdbcmsg">>) ->
    <<"application/vnd.contact.cmsg">>;
from_extension(<<"cdf">>) ->
    <<"application/x-netcdf">>;
from_extension(<<"cdkey">>) ->
    <<"application/vnd.mediastation.cdkey">>;
from_extension(<<"cdmia">>) ->
    <<"application/cdmi-capability">>;
from_extension(<<"cdmic">>) ->
    <<"application/cdmi-container">>;
from_extension(<<"cdmid">>) ->
    <<"application/cdmi-domain">>;
from_extension(<<"cdmio">>) ->
    <<"application/cdmi-object">>;
from_extension(<<"cdmiq">>) ->
    <<"application/cdmi-queue">>;
from_extension(<<"cdx">>) ->
    <<"chemical/x-cdx">>;
from_extension(<<"cdxml">>) ->
    <<"application/vnd.chemdraw+xml">>;
from_extension(<<"cdy">>) ->
    <<"application/vnd.cinderella">>;
from_extension(<<"cer">>) ->
    <<"application/pkix-cert">>;
from_extension(<<"cfs">>) ->
    <<"application/x-cfs-compressed">>;
from_extension(<<"cgm">>) ->
    <<"image/cgm">>;
from_extension(<<"chat">>) ->
    <<"application/x-chat">>;
from_extension(<<"chm">>) ->
    <<"application/vnd.ms-htmlhelp">>;
from_extension(<<"chrt">>) ->
    <<"application/vnd.kde.kchart">>;
from_extension(<<"cif">>) ->
    <<"chemical/x-cif">>;
from_extension(<<"cii">>) ->
    <<"application/vnd.anser-web-certificate-issue-initiation">>;
from_extension(<<"cil">>) ->
    <<"application/vnd.ms-artgalry">>;
from_extension(<<"cla">>) ->
    <<"application/vnd.claymore">>;
from_extension(<<"class">>) ->
    <<"application/java-vm">>;
from_extension(<<"clkk">>) ->
    <<"application/vnd.crick.clicker.keyboard">>;
from_extension(<<"clkp">>) ->
    <<"application/vnd.crick.clicker.palette">>;
from_extension(<<"clkt">>) ->
    <<"application/vnd.crick.clicker.template">>;
from_extension(<<"clkw">>) ->
    <<"application/vnd.crick.clicker.wordbank">>;
from_extension(<<"clkx">>) ->
    <<"application/vnd.crick.clicker">>;
from_extension(<<"clp">>) ->
    <<"application/x-msclip">>;
from_extension(<<"cmc">>) ->
    <<"application/vnd.cosmocaller">>;
from_extension(<<"cmdf">>) ->
    <<"chemical/x-cmdf">>;
from_extension(<<"cml">>) ->
    <<"chemical/x-cml">>;
from_extension(<<"cmp">>) ->
    <<"application/vnd.yellowriver-custom-menu">>;
from_extension(<<"cmx">>) ->
    <<"image/x-cmx">>;
from_extension(<<"cod">>) ->
    <<"application/vnd.rim.cod">>;
from_extension(<<"com">>) ->
    <<"application/x-msdownload">>;
from_extension(<<"conf">>) ->
    <<"text/plain">>;
from_extension(<<"cpio">>) ->
    <<"application/x-cpio">>;
from_extension(<<"cpp">>) ->
    <<"text/x-c">>;
from_extension(<<"cpt">>) ->
    <<"application/mac-compactpro">>;
from_extension(<<"crd">>) ->
    <<"application/x-mscardfile">>;
from_extension(<<"crl">>) ->
    <<"application/pkix-crl">>;
from_extension(<<"crt">>) ->
    <<"application/x-x509-ca-cert">>;
from_extension(<<"cryptonote">>) ->
    <<"application/vnd.rig.cryptonote">>;
from_extension(<<"csh">>) ->
    <<"application/x-csh">>;
from_extension(<<"csml">>) ->
    <<"chemical/x-csml">>;
from_extension(<<"csp">>) ->
    <<"application/vnd.commonspace">>;
from_extension(<<"css">>) ->
    <<"text/css">>;
from_extension(<<"cst">>) ->
    <<"application/x-director">>;
from_extension(<<"csv">>) ->
    <<"text/csv">>;
from_extension(<<"cu">>) ->
    <<"application/cu-seeme">>;
from_extension(<<"curl">>) ->
    <<"text/vnd.curl">>;
from_extension(<<"cww">>) ->
    <<"application/prs.cww">>;
from_extension(<<"cxt">>) ->
    <<"application/x-director">>;
from_extension(<<"cxx">>) ->
    <<"text/x-c">>;
from_extension(<<"dae">>) ->
    <<"model/vnd.collada+xml">>;
from_extension(<<"daf">>) ->
    <<"application/vnd.mobius.daf">>;
from_extension(<<"dart">>) ->
    <<"application/vnd.dart">>;
from_extension(<<"dataless">>) ->
    <<"application/vnd.fdsn.seed">>;
from_extension(<<"davmount">>) ->
    <<"application/davmount+xml">>;
from_extension(<<"dbk">>) ->
    <<"application/docbook+xml">>;
from_extension(<<"dcr">>) ->
    <<"application/x-director">>;
from_extension(<<"dcurl">>) ->
    <<"text/vnd.curl.dcurl">>;
from_extension(<<"dd2">>) ->
    <<"application/vnd.oma.dd2+xml">>;
from_extension(<<"ddd">>) ->
    <<"application/vnd.fujixerox.ddd">>;
from_extension(<<"deb">>) ->
    <<"application/x-debian-package">>;
from_extension(<<"def">>) ->
    <<"text/plain">>;
from_extension(<<"deploy">>) ->
    <<"application/octet-stream">>;
from_extension(<<"der">>) ->
    <<"application/x-x509-ca-cert">>;
from_extension(<<"dfac">>) ->
    <<"application/vnd.dreamfactory">>;
from_extension(<<"dgc">>) ->
    <<"application/x-dgc-compressed">>;
from_extension(<<"dic">>) ->
    <<"text/x-c">>;
from_extension(<<"dir">>) ->
    <<"application/x-director">>;
from_extension(<<"dis">>) ->
    <<"application/vnd.mobius.dis">>;
from_extension(<<"dist">>) ->
    <<"application/octet-stream">>;
from_extension(<<"distz">>) ->
    <<"application/octet-stream">>;
from_extension(<<"djv">>) ->
    <<"image/vnd.djvu">>;
from_extension(<<"djvu">>) ->
    <<"image/vnd.djvu">>;
from_extension(<<"dll">>) ->
    <<"application/x-msdownload">>;
from_extension(<<"dmg">>) ->
    <<"application/x-apple-diskimage">>;
from_extension(<<"dmp">>) ->
    <<"application/vnd.tcpdump.pcap">>;
from_extension(<<"dms">>) ->
    <<"application/octet-stream">>;
from_extension(<<"dna">>) ->
    <<"application/vnd.dna">>;
from_extension(<<"doc">>) ->
    <<"application/msword">>;
from_extension(<<"docm">>) ->
    <<"application/vnd.ms-word.document.macroenabled.12">>;
from_extension(<<"docx">>) ->
    <<"application/vnd.openxmlformats-officedocument.wordprocessingml.document">>;
from_extension(<<"dot">>) ->
    <<"application/msword">>;
from_extension(<<"dotm">>) ->
    <<"application/vnd.ms-word.template.macroenabled.12">>;
from_extension(<<"dotx">>) ->
    <<"application/vnd.openxmlformats-officedocument.wordprocessingml.template">>;
from_extension(<<"dp">>) ->
    <<"application/vnd.osgi.dp">>;
from_extension(<<"dpg">>) ->
    <<"application/vnd.dpgraph">>;
from_extension(<<"dra">>) ->
    <<"audio/vnd.dra">>;
from_extension(<<"dsc">>) ->
    <<"text/prs.lines.tag">>;
from_extension(<<"dssc">>) ->
    <<"application/dssc+der">>;
from_extension(<<"dtb">>) ->
    <<"application/x-dtbook+xml">>;
from_extension(<<"dtd">>) ->
    <<"application/xml-dtd">>;
from_extension(<<"dts">>) ->
    <<"audio/vnd.dts">>;
from_extension(<<"dtshd">>) ->
    <<"audio/vnd.dts.hd">>;
from_extension(<<"dump">>) ->
    <<"application/octet-stream">>;
from_extension(<<"dvb">>) ->
    <<"video/vnd.dvb.file">>;
from_extension(<<"dvi">>) ->
    <<"application/x-dvi">>;
from_extension(<<"dwf">>) ->
    <<"model/vnd.dwf">>;
from_extension(<<"dwg">>) ->
    <<"image/vnd.dwg">>;
from_extension(<<"dxf">>) ->
    <<"image/vnd.dxf">>;
from_extension(<<"dxp">>) ->
    <<"application/vnd.spotfire.dxp">>;
from_extension(<<"dxr">>) ->
    <<"application/x-director">>;
from_extension(<<"ecelp4800">>) ->
    <<"audio/vnd.nuera.ecelp4800">>;
from_extension(<<"ecelp7470">>) ->
    <<"audio/vnd.nuera.ecelp7470">>;
from_extension(<<"ecelp9600">>) ->
    <<"audio/vnd.nuera.ecelp9600">>;
from_extension(<<"ecma">>) ->
    <<"application/ecmascript">>;
from_extension(<<"edm">>) ->
    <<"application/vnd.novadigm.edm">>;
from_extension(<<"edx">>) ->
    <<"application/vnd.novadigm.edx">>;
from_extension(<<"efif">>) ->
    <<"application/vnd.picsel">>;
from_extension(<<"ei6">>) ->
    <<"application/vnd.pg.osasli">>;
from_extension(<<"elc">>) ->
    <<"application/octet-stream">>;
from_extension(<<"emf">>) ->
    <<"application/x-msmetafile">>;
from_extension(<<"eml">>) ->
    <<"message/rfc822">>;
from_extension(<<"emma">>) ->
    <<"application/emma+xml">>;
from_extension(<<"emz">>) ->
    <<"application/x-msmetafile">>;
from_extension(<<"eol">>) ->
    <<"audio/vnd.digital-winds">>;
from_extension(<<"eot">>) ->
    <<"application/vnd.ms-fontobject">>;
from_extension(<<"eps">>) ->
    <<"application/postscript">>;
from_extension(<<"epub">>) ->
    <<"application/epub+zip">>;
from_extension(<<"es3">>) ->
    <<"application/vnd.eszigno3+xml">>;
from_extension(<<"esa">>) ->
    <<"application/vnd.osgi.subsystem">>;
from_extension(<<"esf">>) ->
    <<"application/vnd.epson.esf">>;
from_extension(<<"et3">>) ->
    <<"application/vnd.eszigno3+xml">>;
from_extension(<<"etx">>) ->
    <<"text/x-setext">>;
from_extension(<<"eva">>) ->
    <<"application/x-eva">>;
from_extension(<<"evy">>) ->
    <<"application/x-envoy">>;
from_extension(<<"exe">>) ->
    <<"application/x-msdownload">>;
from_extension(<<"exi">>) ->
    <<"application/exi">>;
from_extension(<<"ext">>) ->
    <<"application/vnd.novadigm.ext">>;
from_extension(<<"ez">>) ->
    <<"application/andrew-inset">>;
from_extension(<<"ez2">>) ->
    <<"application/vnd.ezpix-album">>;
from_extension(<<"ez3">>) ->
    <<"application/vnd.ezpix-package">>;
from_extension(<<"f">>) ->
    <<"text/x-fortran">>;
from_extension(<<"f4v">>) ->
    <<"video/x-f4v">>;
from_extension(<<"f77">>) ->
    <<"text/x-fortran">>;
from_extension(<<"f90">>) ->
    <<"text/x-fortran">>;
from_extension(<<"fbs">>) ->
    <<"image/vnd.fastbidsheet">>;
from_extension(<<"fcdt">>) ->
    <<"application/vnd.adobe.formscentral.fcdt">>;
from_extension(<<"fcs">>) ->
    <<"application/vnd.isac.fcs">>;
from_extension(<<"fdf">>) ->
    <<"application/vnd.fdf">>;
from_extension(<<"fe_launch">>) ->
    <<"application/vnd.denovo.fcselayout-link">>;
from_extension(<<"fg5">>) ->
    <<"application/vnd.fujitsu.oasysgp">>;
from_extension(<<"fgd">>) ->
    <<"application/x-director">>;
from_extension(<<"fh">>) ->
    <<"image/x-freehand">>;
from_extension(<<"fh4">>) ->
    <<"image/x-freehand">>;
from_extension(<<"fh5">>) ->
    <<"image/x-freehand">>;
from_extension(<<"fh7">>) ->
    <<"image/x-freehand">>;
from_extension(<<"fhc">>) ->
    <<"image/x-freehand">>;
from_extension(<<"fig">>) ->
    <<"application/x-xfig">>;
from_extension(<<"flac">>) ->
    <<"audio/x-flac">>;
from_extension(<<"fli">>) ->
    <<"video/x-fli">>;
from_extension(<<"flo">>) ->
    <<"application/vnd.micrografx.flo">>;
from_extension(<<"flv">>) ->
    <<"video/x-flv">>;
from_extension(<<"flw">>) ->
    <<"application/vnd.kde.kivio">>;
from_extension(<<"flx">>) ->
    <<"text/vnd.fmi.flexstor">>;
from_extension(<<"fly">>) ->
    <<"text/vnd.fly">>;
from_extension(<<"fm">>) ->
    <<"application/vnd.framemaker">>;
from_extension(<<"fnc">>) ->
    <<"application/vnd.frogans.fnc">>;
from_extension(<<"for">>) ->
    <<"text/x-fortran">>;
from_extension(<<"fpx">>) ->
    <<"image/vnd.fpx">>;
from_extension(<<"frame">>) ->
    <<"application/vnd.framemaker">>;
from_extension(<<"fsc">>) ->
    <<"application/vnd.fsc.weblaunch">>;
from_extension(<<"fst">>) ->
    <<"image/vnd.fst">>;
from_extension(<<"ftc">>) ->
    <<"application/vnd.fluxtime.clip">>;
from_extension(<<"fti">>) ->
    <<"application/vnd.anser-web-funds-transfer-initiation">>;
from_extension(<<"fvt">>) ->
    <<"video/vnd.fvt">>;
from_extension(<<"fxp">>) ->
    <<"application/vnd.adobe.fxp">>;
from_extension(<<"fxpl">>) ->
    <<"application/vnd.adobe.fxp">>;
from_extension(<<"fzs">>) ->
    <<"application/vnd.fuzzysheet">>;
from_extension(<<"g2w">>) ->
    <<"application/vnd.geoplan">>;
from_extension(<<"g3">>) ->
    <<"image/g3fax">>;
from_extension(<<"g3w">>) ->
    <<"application/vnd.geospace">>;
from_extension(<<"gac">>) ->
    <<"application/vnd.groove-account">>;
from_extension(<<"gam">>) ->
    <<"application/x-tads">>;
from_extension(<<"gbr">>) ->
    <<"application/rpki-ghostbusters">>;
from_extension(<<"gca">>) ->
    <<"application/x-gca-compressed">>;
from_extension(<<"gdl">>) ->
    <<"model/vnd.gdl">>;
from_extension(<<"geo">>) ->
    <<"application/vnd.dynageo">>;
from_extension(<<"gex">>) ->
    <<"application/vnd.geometry-explorer">>;
from_extension(<<"ggb">>) ->
    <<"application/vnd.geogebra.file">>;
from_extension(<<"ggs">>) ->
    <<"application/vnd.geogebra.slides">>;
from_extension(<<"ggt">>) ->
    <<"application/vnd.geogebra.tool">>;
from_extension(<<"ghf">>) ->
    <<"application/vnd.groove-help">>;
from_extension(<<"gif">>) ->
    <<"image/gif">>;
from_extension(<<"gim">>) ->
    <<"application/vnd.groove-identity-message">>;
from_extension(<<"gml">>) ->
    <<"application/gml+xml">>;
from_extension(<<"gmx">>) ->
    <<"application/vnd.gmx">>;
from_extension(<<"gnumeric">>) ->
    <<"application/x-gnumeric">>;
from_extension(<<"gph">>) ->
    <<"application/vnd.flographit">>;
from_extension(<<"gpx">>) ->
    <<"application/gpx+xml">>;
from_extension(<<"gqf">>) ->
    <<"application/vnd.grafeq">>;
from_extension(<<"gqs">>) ->
    <<"application/vnd.grafeq">>;
from_extension(<<"gram">>) ->
    <<"application/srgs">>;
from_extension(<<"gramps">>) ->
    <<"application/x-gramps-xml">>;
from_extension(<<"gre">>) ->
    <<"application/vnd.geometry-explorer">>;
from_extension(<<"grv">>) ->
    <<"application/vnd.groove-injector">>;
from_extension(<<"grxml">>) ->
    <<"application/srgs+xml">>;
from_extension(<<"gsf">>) ->
    <<"application/x-font-ghostscript">>;
from_extension(<<"gtar">>) ->
    <<"application/x-gtar">>;
from_extension(<<"gtm">>) ->
    <<"application/vnd.groove-tool-message">>;
from_extension(<<"gtw">>) ->
    <<"model/vnd.gtw">>;
from_extension(<<"gv">>) ->
    <<"text/vnd.graphviz">>;
from_extension(<<"gxf">>) ->
    <<"application/gxf">>;
from_extension(<<"gxt">>) ->
    <<"application/vnd.geonext">>;
from_extension(<<"h">>) ->
    <<"text/x-c">>;
from_extension(<<"h261">>) ->
    <<"video/h261">>;
from_extension(<<"h263">>) ->
    <<"video/h263">>;
from_extension(<<"h264">>) ->
    <<"video/h264">>;
from_extension(<<"hal">>) ->
    <<"application/vnd.hal+xml">>;
from_extension(<<"hbci">>) ->
    <<"application/vnd.hbci">>;
from_extension(<<"hdf">>) ->
    <<"application/x-hdf">>;
from_extension(<<"hh">>) ->
    <<"text/x-c">>;
from_extension(<<"hlp">>) ->
    <<"application/winhlp">>;
from_extension(<<"hpgl">>) ->
    <<"application/vnd.hp-hpgl">>;
from_extension(<<"hpid">>) ->
    <<"application/vnd.hp-hpid">>;
from_extension(<<"hps">>) ->
    <<"application/vnd.hp-hps">>;
from_extension(<<"hqx">>) ->
    <<"application/mac-binhex40">>;
from_extension(<<"htke">>) ->
    <<"application/vnd.kenameaapp">>;
from_extension(<<"htm">>) ->
    <<"text/html">>;
from_extension(<<"html">>) ->
    <<"text/html">>;
from_extension(<<"hvd">>) ->
    <<"application/vnd.yamaha.hv-dic">>;
from_extension(<<"hvp">>) ->
    <<"application/vnd.yamaha.hv-voice">>;
from_extension(<<"hvs">>) ->
    <<"application/vnd.yamaha.hv-script">>;
from_extension(<<"i2g">>) ->
    <<"application/vnd.intergeo">>;
from_extension(<<"icc">>) ->
    <<"application/vnd.iccprofile">>;
from_extension(<<"ice">>) ->
    <<"x-conference/x-cooltalk">>;
from_extension(<<"icm">>) ->
    <<"application/vnd.iccprofile">>;
from_extension(<<"ico">>) ->
    <<"image/x-icon">>;
from_extension(<<"ics">>) ->
    <<"text/calendar">>;
from_extension(<<"ief">>) ->
    <<"image/ief">>;
from_extension(<<"ifb">>) ->
    <<"text/calendar">>;
from_extension(<<"ifm">>) ->
    <<"application/vnd.shana.informed.formdata">>;
from_extension(<<"iges">>) ->
    <<"model/iges">>;
from_extension(<<"igl">>) ->
    <<"application/vnd.igloader">>;
from_extension(<<"igm">>) ->
    <<"application/vnd.insors.igm">>;
from_extension(<<"igs">>) ->
    <<"model/iges">>;
from_extension(<<"igx">>) ->
    <<"application/vnd.micrografx.igx">>;
from_extension(<<"iif">>) ->
    <<"application/vnd.shana.informed.interchange">>;
from_extension(<<"imp">>) ->
    <<"application/vnd.accpac.simply.imp">>;
from_extension(<<"ims">>) ->
    <<"application/vnd.ms-ims">>;
from_extension(<<"in">>) ->
    <<"text/plain">>;
from_extension(<<"ink">>) ->
    <<"application/inkml+xml">>;
from_extension(<<"inkml">>) ->
    <<"application/inkml+xml">>;
from_extension(<<"install">>) ->
    <<"application/x-install-instructions">>;
from_extension(<<"iota">>) ->
    <<"application/vnd.astraea-software.iota">>;
from_extension(<<"ipfix">>) ->
    <<"application/ipfix">>;
from_extension(<<"ipk">>) ->
    <<"application/vnd.shana.informed.package">>;
from_extension(<<"irm">>) ->
    <<"application/vnd.ibm.rights-management">>;
from_extension(<<"irp">>) ->
    <<"application/vnd.irepository.package+xml">>;
from_extension(<<"iso">>) ->
    <<"application/x-iso9660-image">>;
from_extension(<<"itp">>) ->
    <<"application/vnd.shana.informed.formtemplate">>;
from_extension(<<"ivp">>) ->
    <<"application/vnd.immervision-ivp">>;
from_extension(<<"ivu">>) ->
    <<"application/vnd.immervision-ivu">>;
from_extension(<<"jad">>) ->
    <<"text/vnd.sun.j2me.app-descriptor">>;
from_extension(<<"jam">>) ->
    <<"application/vnd.jam">>;
from_extension(<<"jar">>) ->
    <<"application/java-archive">>;
from_extension(<<"java">>) ->
    <<"text/x-java-source">>;
from_extension(<<"jisp">>) ->
    <<"application/vnd.jisp">>;
from_extension(<<"jlt">>) ->
    <<"application/vnd.hp-jlyt">>;
from_extension(<<"jnlp">>) ->
    <<"application/x-java-jnlp-file">>;
from_extension(<<"joda">>) ->
    <<"application/vnd.joost.joda-archive">>;
from_extension(<<"jpe">>) ->
    <<"image/jpeg">>;
from_extension(<<"jpeg">>) ->
    <<"image/jpeg">>;
from_extension(<<"jpg">>) ->
    <<"image/jpeg">>;
from_extension(<<"jpgm">>) ->
    <<"video/jpm">>;
from_extension(<<"jpgv">>) ->
    <<"video/jpeg">>;
from_extension(<<"jpm">>) ->
    <<"video/jpm">>;
from_extension(<<"js">>) ->
    <<"text/javascript">>;
from_extension(<<"json">>) ->
    <<"application/json">>;
from_extension(<<"jsonml">>) ->
    <<"application/jsonml+json">>;
from_extension(<<"kar">>) ->
    <<"audio/midi">>;
from_extension(<<"karbon">>) ->
    <<"application/vnd.kde.karbon">>;
from_extension(<<"kfo">>) ->
    <<"application/vnd.kde.kformula">>;
from_extension(<<"kia">>) ->
    <<"application/vnd.kidspiration">>;
from_extension(<<"kml">>) ->
    <<"application/vnd.google-earth.kml+xml">>;
from_extension(<<"kmz">>) ->
    <<"application/vnd.google-earth.kmz">>;
from_extension(<<"kne">>) ->
    <<"application/vnd.kinar">>;
from_extension(<<"knp">>) ->
    <<"application/vnd.kinar">>;
from_extension(<<"kon">>) ->
    <<"application/vnd.kde.kontour">>;
from_extension(<<"kpr">>) ->
    <<"application/vnd.kde.kpresenter">>;
from_extension(<<"kpt">>) ->
    <<"application/vnd.kde.kpresenter">>;
from_extension(<<"kpxx">>) ->
    <<"application/vnd.ds-keypoint">>;
from_extension(<<"ksp">>) ->
    <<"application/vnd.kde.kspread">>;
from_extension(<<"ktr">>) ->
    <<"application/vnd.kahootz">>;
from_extension(<<"ktx">>) ->
    <<"image/ktx">>;
from_extension(<<"ktz">>) ->
    <<"application/vnd.kahootz">>;
from_extension(<<"kwd">>) ->
    <<"application/vnd.kde.kword">>;
from_extension(<<"kwt">>) ->
    <<"application/vnd.kde.kword">>;
from_extension(<<"lasxml">>) ->
    <<"application/vnd.las.las+xml">>;
from_extension(<<"latex">>) ->
    <<"application/x-latex">>;
from_extension(<<"lbd">>) ->
    <<"application/vnd.llamagraphics.life-balance.desktop">>;
from_extension(<<"lbe">>) ->
    <<"application/vnd.llamagraphics.life-balance.exchange+xml">>;
from_extension(<<"les">>) ->
    <<"application/vnd.hhe.lesson-player">>;
from_extension(<<"lha">>) ->
    <<"application/x-lzh-compressed">>;
from_extension(<<"link66">>) ->
    <<"application/vnd.route66.link66+xml">>;
from_extension(<<"list">>) ->
    <<"text/plain">>;
from_extension(<<"list3820">>) ->
    <<"application/vnd.ibm.modcap">>;
from_extension(<<"listafp">>) ->
    <<"application/vnd.ibm.modcap">>;
from_extension(<<"lnk">>) ->
    <<"application/x-ms-shortcut">>;
from_extension(<<"log">>) ->
    <<"text/plain">>;
from_extension(<<"lostxml">>) ->
    <<"application/lost+xml">>;
from_extension(<<"lrf">>) ->
    <<"application/octet-stream">>;
from_extension(<<"lrm">>) ->
    <<"application/vnd.ms-lrm">>;
from_extension(<<"ltf">>) ->
    <<"application/vnd.frogans.ltf">>;
from_extension(<<"lvp">>) ->
    <<"audio/vnd.lucent.voice">>;
from_extension(<<"lwp">>) ->
    <<"application/vnd.lotus-wordpro">>;
from_extension(<<"lzh">>) ->
    <<"application/x-lzh-compressed">>;
from_extension(<<"m13">>) ->
    <<"application/x-msmediaview">>;
from_extension(<<"m14">>) ->
    <<"application/x-msmediaview">>;
from_extension(<<"m1v">>) ->
    <<"video/mpeg">>;
from_extension(<<"m21">>) ->
    <<"application/mp21">>;
from_extension(<<"m2a">>) ->
    <<"audio/mpeg">>;
from_extension(<<"m2t">>) ->
    <<"video/mp2t">>;
from_extension(<<"m2ts">>) ->
    <<"video/mp2t">>;
from_extension(<<"m2v">>) ->
    <<"video/mpeg">>;
from_extension(<<"m3a">>) ->
    <<"audio/mpeg">>;
from_extension(<<"m3u">>) ->
    <<"audio/x-mpegurl">>;
from_extension(<<"m3u8">>) ->
    <<"application/vnd.apple.mpegurl">>;
from_extension(<<"m4a">>) ->
    <<"audio/mp4">>;
from_extension(<<"m4u">>) ->
    <<"video/vnd.mpegurl">>;
from_extension(<<"m4v">>) ->
    <<"video/x-m4v">>;
from_extension(<<"ma">>) ->
    <<"application/mathematica">>;
from_extension(<<"mads">>) ->
    <<"application/mads+xml">>;
from_extension(<<"mag">>) ->
    <<"application/vnd.ecowin.chart">>;
from_extension(<<"maker">>) ->
    <<"application/vnd.framemaker">>;
from_extension(<<"man">>) ->
    <<"text/troff">>;
from_extension(<<"mar">>) ->
    <<"application/octet-stream">>;
from_extension(<<"mathml">>) ->
    <<"application/mathml+xml">>;
from_extension(<<"mb">>) ->
    <<"application/mathematica">>;
from_extension(<<"mbk">>) ->
    <<"application/vnd.mobius.mbk">>;
from_extension(<<"mbox">>) ->
    <<"application/mbox">>;
from_extension(<<"mc1">>) ->
    <<"application/vnd.medcalcdata">>;
from_extension(<<"mcd">>) ->
    <<"application/vnd.mcd">>;
from_extension(<<"mcurl">>) ->
    <<"text/vnd.curl.mcurl">>;
from_extension(<<"mdb">>) ->
    <<"application/x-msaccess">>;
from_extension(<<"mdi">>) ->
    <<"image/vnd.ms-modi">>;
from_extension(<<"me">>) ->
    <<"text/troff">>;
from_extension(<<"mesh">>) ->
    <<"model/mesh">>;
from_extension(<<"meta4">>) ->
    <<"application/metalink4+xml">>;
from_extension(<<"metalink">>) ->
    <<"application/metalink+xml">>;
from_extension(<<"mets">>) ->
    <<"application/mets+xml">>;
from_extension(<<"mfm">>) ->
    <<"application/vnd.mfmp">>;
from_extension(<<"mft">>) ->
    <<"application/rpki-manifest">>;
from_extension(<<"mgp">>) ->
    <<"application/vnd.osgeo.mapguide.package">>;
from_extension(<<"mgz">>) ->
    <<"application/vnd.proteus.magazine">>;
from_extension(<<"mid">>) ->
    <<"audio/midi">>;
from_extension(<<"midi">>) ->
    <<"audio/midi">>;
from_extension(<<"mie">>) ->
    <<"application/x-mie">>;
from_extension(<<"mif">>) ->
    <<"application/vnd.mif">>;
from_extension(<<"mime">>) ->
    <<"message/rfc822">>;
from_extension(<<"mj2">>) ->
    <<"video/mj2">>;
from_extension(<<"mjp2">>) ->
    <<"video/mj2">>;
from_extension(<<"mjs">>) ->
    <<"text/javascript">>;
from_extension(<<"mk3d">>) ->
    <<"video/x-matroska">>;
from_extension(<<"mka">>) ->
    <<"audio/x-matroska">>;
from_extension(<<"mks">>) ->
    <<"video/x-matroska">>;
from_extension(<<"mkv">>) ->
    <<"video/x-matroska">>;
from_extension(<<"mlp">>) ->
    <<"application/vnd.dolby.mlp">>;
from_extension(<<"mmd">>) ->
    <<"application/vnd.chipnuts.karaoke-mmd">>;
from_extension(<<"mmf">>) ->
    <<"application/vnd.smaf">>;
from_extension(<<"mmr">>) ->
    <<"image/vnd.fujixerox.edmics-mmr">>;
from_extension(<<"mng">>) ->
    <<"video/x-mng">>;
from_extension(<<"mny">>) ->
    <<"application/x-msmoney">>;
from_extension(<<"mobi">>) ->
    <<"application/x-mobipocket-ebook">>;
from_extension(<<"mods">>) ->
    <<"application/mods+xml">>;
from_extension(<<"mov">>) ->
    <<"video/quicktime">>;
from_extension(<<"movie">>) ->
    <<"video/x-sgi-movie">>;
from_extension(<<"mp2">>) ->
    <<"audio/mpeg">>;
from_extension(<<"mp21">>) ->
    <<"application/mp21">>;
from_extension(<<"mp2a">>) ->
    <<"audio/mpeg">>;
from_extension(<<"mp3">>) ->
    <<"audio/mpeg">>;
from_extension(<<"mp4">>) ->
    <<"video/mp4">>;
from_extension(<<"mp4a">>) ->
    <<"audio/mp4">>;
from_extension(<<"mp4s">>) ->
    <<"application/mp4">>;
from_extension(<<"mp4v">>) ->
    <<"video/mp4">>;
from_extension(<<"mpc">>) ->
    <<"application/vnd.mophun.certificate">>;
from_extension(<<"mpe">>) ->
    <<"video/mpeg">>;
from_extension(<<"mpeg">>) ->
    <<"video/mpeg">>;
from_extension(<<"mpg">>) ->
    <<"video/mpeg">>;
from_extension(<<"mpg4">>) ->
    <<"video/mp4">>;
from_extension(<<"mpga">>) ->
    <<"audio/mpeg">>;
from_extension(<<"mpkg">>) ->
    <<"application/vnd.apple.installer+xml">>;
from_extension(<<"mpm">>) ->
    <<"application/vnd.blueice.multipass">>;
from_extension(<<"mpn">>) ->
    <<"application/vnd.mophun.application">>;
from_extension(<<"mpp">>) ->
    <<"application/vnd.ms-project">>;
from_extension(<<"mpt">>) ->
    <<"application/vnd.ms-project">>;
from_extension(<<"mpy">>) ->
    <<"application/vnd.ibm.minipay">>;
from_extension(<<"mqy">>) ->
    <<"application/vnd.mobius.mqy">>;
from_extension(<<"mrc">>) ->
    <<"application/marc">>;
from_extension(<<"mrcx">>) ->
    <<"application/marcxml+xml">>;
from_extension(<<"ms">>) ->
    <<"text/troff">>;
from_extension(<<"mscml">>) ->
    <<"application/mediaservercontrol+xml">>;
from_extension(<<"mseed">>) ->
    <<"application/vnd.fdsn.mseed">>;
from_extension(<<"mseq">>) ->
    <<"application/vnd.mseq">>;
from_extension(<<"msf">>) ->
    <<"application/vnd.epson.msf">>;
from_extension(<<"msh">>) ->
    <<"model/mesh">>;
from_extension(<<"msi">>) ->
    <<"application/x-msdownload">>;
from_extension(<<"msl">>) ->
    <<"application/vnd.mobius.msl">>;
from_extension(<<"msty">>) ->
    <<"application/vnd.muvee.style">>;
from_extension(<<"mts">>) ->
    <<"video/mp2t">>;
from_extension(<<"mus">>) ->
    <<"application/vnd.musician">>;
from_extension(<<"musicxml">>) ->
    <<"application/vnd.recordare.musicxml+xml">>;
from_extension(<<"mvb">>) ->
    <<"application/x-msmediaview">>;
from_extension(<<"mwf">>) ->
    <<"application/vnd.mfer">>;
from_extension(<<"mxf">>) ->
    <<"application/mxf">>;
from_extension(<<"mxl">>) ->
    <<"application/vnd.recordare.musicxml">>;
from_extension(<<"mxml">>) ->
    <<"application/xv+xml">>;
from_extension(<<"mxs">>) ->
    <<"application/vnd.triscape.mxs">>;
from_extension(<<"mxu">>) ->
    <<"video/vnd.mpegurl">>;
from_extension(<<"n3">>) ->
    <<"text/n3">>;
from_extension(<<"nb">>) ->
    <<"application/mathematica">>;
from_extension(<<"nbp">>) ->
    <<"application/vnd.wolfram.player">>;
from_extension(<<"nc">>) ->
    <<"application/x-netcdf">>;
from_extension(<<"ncx">>) ->
    <<"application/x-dtbncx+xml">>;
from_extension(<<"nfo">>) ->
    <<"text/x-nfo">>;
from_extension(<<"n-gage">>) ->
    <<"application/vnd.nokia.n-gage.symbian.install">>;
from_extension(<<"ngdat">>) ->
    <<"application/vnd.nokia.n-gage.data">>;
from_extension(<<"nitf">>) ->
    <<"application/vnd.nitf">>;
from_extension(<<"nlu">>) ->
    <<"application/vnd.neurolanguage.nlu">>;
from_extension(<<"nml">>) ->
    <<"application/vnd.enliven">>;
from_extension(<<"nnd">>) ->
    <<"application/vnd.noblenet-directory">>;
from_extension(<<"nns">>) ->
    <<"application/vnd.noblenet-sealer">>;
from_extension(<<"nnw">>) ->
    <<"application/vnd.noblenet-web">>;
from_extension(<<"npx">>) ->
    <<"image/vnd.net-fpx">>;
from_extension(<<"nsc">>) ->
    <<"application/x-conference">>;
from_extension(<<"nsf">>) ->
    <<"application/vnd.lotus-notes">>;
from_extension(<<"ntf">>) ->
    <<"application/vnd.nitf">>;
from_extension(<<"nzb">>) ->
    <<"application/x-nzb">>;
from_extension(<<"oa2">>) ->
    <<"application/vnd.fujitsu.oasys2">>;
from_extension(<<"oa3">>) ->
    <<"application/vnd.fujitsu.oasys3">>;
from_extension(<<"oas">>) ->
    <<"application/vnd.fujitsu.oasys">>;
from_extension(<<"obd">>) ->
    <<"application/x-msbinder">>;
from_extension(<<"obj">>) ->
    <<"application/x-tgif">>;
from_extension(<<"oda">>) ->
    <<"application/oda">>;
from_extension(<<"odb">>) ->
    <<"application/vnd.oasis.opendocument.database">>;
from_extension(<<"odc">>) ->
    <<"application/vnd.oasis.opendocument.chart">>;
from_extension(<<"odf">>) ->
    <<"application/vnd.oasis.opendocument.formula">>;
from_extension(<<"odft">>) ->
    <<"application/vnd.oasis.opendocument.formula-template">>;
from_extension(<<"odg">>) ->
    <<"application/vnd.oasis.opendocument.graphics">>;
from_extension(<<"odi">>) ->
    <<"application/vnd.oasis.opendocument.image">>;
from_extension(<<"odm">>) ->
    <<"application/vnd.oasis.opendocument.text-master">>;
from_extension(<<"odp">>) ->
    <<"application/vnd.oasis.opendocument.presentation">>;
from_extension(<<"ods">>) ->
    <<"application/vnd.oasis.opendocument.spreadsheet">>;
from_extension(<<"odt">>) ->
    <<"application/vnd.oasis.opendocument.text">>;
from_extension(<<"oga">>) ->
    <<"audio/ogg">>;
from_extension(<<"ogg">>) ->
    <<"audio/ogg">>;
from_extension(<<"ogv">>) ->
    <<"video/ogg">>;
from_extension(<<"ogx">>) ->
    <<"application/ogg">>;
from_extension(<<"omdoc">>) ->
    <<"application/omdoc+xml">>;
from_extension(<<"onepkg">>) ->
    <<"application/onenote">>;
from_extension(<<"onetmp">>) ->
    <<"application/onenote">>;
from_extension(<<"onetoc">>) ->
    <<"application/onenote">>;
from_extension(<<"onetoc2">>) ->
    <<"application/onenote">>;
from_extension(<<"opf">>) ->
    <<"application/oebps-package+xml">>;
from_extension(<<"opml">>) ->
    <<"text/x-opml">>;
from_extension(<<"oprc">>) ->
    <<"application/vnd.palm">>;
from_extension(<<"opus">>) ->
    <<"audio/ogg">>;
from_extension(<<"org">>) ->
    <<"application/vnd.lotus-organizer">>;
from_extension(<<"osf">>) ->
    <<"application/vnd.yamaha.openscoreformat">>;
from_extension(<<"osfpvg">>) ->
    <<"application/vnd.yamaha.openscoreformat.osfpvg+xml">>;
from_extension(<<"otc">>) ->
    <<"application/vnd.oasis.opendocument.chart-template">>;
from_extension(<<"otf">>) ->
    <<"font/otf">>;
from_extension(<<"otg">>) ->
    <<"application/vnd.oasis.opendocument.graphics-template">>;
from_extension(<<"oth">>) ->
    <<"application/vnd.oasis.opendocument.text-web">>;
from_extension(<<"oti">>) ->
    <<"application/vnd.oasis.opendocument.image-template">>;
from_extension(<<"otp">>) ->
    <<"application/vnd.oasis.opendocument.presentation-template">>;
from_extension(<<"ots">>) ->
    <<"application/vnd.oasis.opendocument.spreadsheet-template">>;
from_extension(<<"ott">>) ->
    <<"application/vnd.oasis.opendocument.text-template">>;
from_extension(<<"oxps">>) ->
    <<"application/oxps">>;
from_extension(<<"oxt">>) ->
    <<"application/vnd.openofficeorg.extension">>;
from_extension(<<"p">>) ->
    <<"text/x-pascal">>;
from_extension(<<"p10">>) ->
    <<"application/pkcs10">>;
from_extension(<<"p12">>) ->
    <<"application/x-pkcs12">>;
from_extension(<<"p7b">>) ->
    <<"application/x-pkcs7-certificates">>;
from_extension(<<"p7c">>) ->
    <<"application/pkcs7-mime">>;
from_extension(<<"p7m">>) ->
    <<"application/pkcs7-mime">>;
from_extension(<<"p7r">>) ->
    <<"application/x-pkcs7-certreqresp">>;
from_extension(<<"p7s">>) ->
    <<"application/pkcs7-signature">>;
from_extension(<<"p8">>) ->
    <<"application/pkcs8">>;
from_extension(<<"pas">>) ->
    <<"text/x-pascal">>;
from_extension(<<"paw">>) ->
    <<"application/vnd.pawaafile">>;
from_extension(<<"pbd">>) ->
    <<"application/vnd.powerbuilder6">>;
from_extension(<<"pbm">>) ->
    <<"image/x-portable-bitmap">>;
from_extension(<<"pcap">>) ->
    <<"application/vnd.tcpdump.pcap">>;
from_extension(<<"pcf">>) ->
    <<"application/x-font-pcf">>;
from_extension(<<"pcl">>) ->
    <<"application/vnd.hp-pcl">>;
from_extension(<<"pclxl">>) ->
    <<"application/vnd.hp-pclxl">>;
from_extension(<<"pct">>) ->
    <<"image/x-pict">>;
from_extension(<<"pcurl">>) ->
    <<"application/vnd.curl.pcurl">>;
from_extension(<<"pcx">>) ->
    <<"image/x-pcx">>;
from_extension(<<"pdb">>) ->
    <<"application/vnd.palm">>;
from_extension(<<"pdf">>) ->
    <<"application/pdf">>;
from_extension(<<"pfa">>) ->
    <<"application/x-font-type1">>;
from_extension(<<"pfb">>) ->
    <<"application/x-font-type1">>;
from_extension(<<"pfm">>) ->
    <<"application/x-font-type1">>;
from_extension(<<"pfr">>) ->
    <<"application/font-tdpfr">>;
from_extension(<<"pfx">>) ->
    <<"application/x-pkcs12">>;
from_extension(<<"pgm">>) ->
    <<"image/x-portable-graymap">>;
from_extension(<<"pgn">>) ->
    <<"application/x-chess-pgn">>;
from_extension(<<"pgp">>) ->
    <<"application/pgp-encrypted">>;
from_extension(<<"pic">>) ->
    <<"image/x-pict">>;
from_extension(<<"pkg">>) ->
    <<"application/octet-stream">>;
from_extension(<<"pki">>) ->
    <<"application/pkixcmp">>;
from_extension(<<"pkipath">>) ->
    <<"application/pkix-pkipath">>;
from_extension(<<"plb">>) ->
    <<"application/vnd.3gpp.pic-bw-large">>;
from_extension(<<"plc">>) ->
    <<"application/vnd.mobius.plc">>;
from_extension(<<"plf">>) ->
    <<"application/vnd.pocketlearn">>;
from_extension(<<"pls">>) ->
    <<"application/pls+xml">>;
from_extension(<<"pml">>) ->
    <<"application/vnd.ctc-posml">>;
from_extension(<<"png">>) ->
    <<"image/png">>;
from_extension(<<"pnm">>) ->
    <<"image/x-portable-anymap">>;
from_extension(<<"portpkg">>) ->
    <<"application/vnd.macports.portpkg">>;
from_extension(<<"pot">>) ->
    <<"application/vnd.ms-powerpoint">>;
from_extension(<<"potm">>) ->
    <<"application/vnd.ms-powerpoint.template.macroenabled.12">>;
from_extension(<<"potx">>) ->
    <<"application/vnd.openxmlformats-officedocument.presentationml.template">>;
from_extension(<<"ppam">>) ->
    <<"application/vnd.ms-powerpoint.addin.macroenabled.12">>;
from_extension(<<"ppd">>) ->
    <<"application/vnd.cups-ppd">>;
from_extension(<<"ppm">>) ->
    <<"image/x-portable-pixmap">>;
from_extension(<<"pps">>) ->
    <<"application/vnd.ms-powerpoint">>;
from_extension(<<"ppsm">>) ->
    <<"application/vnd.ms-powerpoint.slideshow.macroenabled.12">>;
from_extension(<<"ppsx">>) ->
    <<"application/vnd.openxmlformats-officedocument.presentationml.slideshow">>;
from_extension(<<"ppt">>) ->
    <<"application/vnd.ms-powerpoint">>;
from_extension(<<"pptm">>) ->
    <<"application/vnd.ms-powerpoint.presentation.macroenabled.12">>;
from_extension(<<"pptx">>) ->
    <<"application/vnd.openxmlformats-officedocument.presentationml.presentation">>;
from_extension(<<"pqa">>) ->
    <<"application/vnd.palm">>;
from_extension(<<"prc">>) ->
    <<"application/x-mobipocket-ebook">>;
from_extension(<<"pre">>) ->
    <<"application/vnd.lotus-freelance">>;
from_extension(<<"prf">>) ->
    <<"application/pics-rules">>;
from_extension(<<"ps">>) ->
    <<"application/postscript">>;
from_extension(<<"psb">>) ->
    <<"application/vnd.3gpp.pic-bw-small">>;
from_extension(<<"psd">>) ->
    <<"image/vnd.adobe.photoshop">>;
from_extension(<<"psf">>) ->
    <<"application/x-font-linux-psf">>;
from_extension(<<"pskcxml">>) ->
    <<"application/pskc+xml">>;
from_extension(<<"ptid">>) ->
    <<"application/vnd.pvi.ptid1">>;
from_extension(<<"pub">>) ->
    <<"application/x-mspublisher">>;
from_extension(<<"pvb">>) ->
    <<"application/vnd.3gpp.pic-bw-var">>;
from_extension(<<"pwn">>) ->
    <<"application/vnd.3m.post-it-notes">>;
from_extension(<<"pya">>) ->
    <<"audio/vnd.ms-playready.media.pya">>;
from_extension(<<"pyv">>) ->
    <<"video/vnd.ms-playready.media.pyv">>;
from_extension(<<"qam">>) ->
    <<"application/vnd.epson.quickanime">>;
from_extension(<<"qbo">>) ->
    <<"application/vnd.intu.qbo">>;
from_extension(<<"qfx">>) ->
    <<"application/vnd.intu.qfx">>;
from_extension(<<"qps">>) ->
    <<"application/vnd.publishare-delta-tree">>;
from_extension(<<"qt">>) ->
    <<"video/quicktime">>;
from_extension(<<"qwd">>) ->
    <<"application/vnd.quark.quarkxpress">>;
from_extension(<<"qwt">>) ->
    <<"application/vnd.quark.quarkxpress">>;
from_extension(<<"qxb">>) ->
    <<"application/vnd.quark.quarkxpress">>;
from_extension(<<"qxd">>) ->
    <<"application/vnd.quark.quarkxpress">>;
from_extension(<<"qxl">>) ->
    <<"application/vnd.quark.quarkxpress">>;
from_extension(<<"qxt">>) ->
    <<"application/vnd.quark.quarkxpress">>;
from_extension(<<"ra">>) ->
    <<"audio/x-pn-realaudio">>;
from_extension(<<"ram">>) ->
    <<"audio/x-pn-realaudio">>;
from_extension(<<"rar">>) ->
    <<"application/x-rar-compressed">>;
from_extension(<<"ras">>) ->
    <<"image/x-cmu-raster">>;
from_extension(<<"rcprofile">>) ->
    <<"application/vnd.ipunplugged.rcprofile">>;
from_extension(<<"rdf">>) ->
    <<"application/rdf+xml">>;
from_extension(<<"rdz">>) ->
    <<"application/vnd.data-vision.rdz">>;
from_extension(<<"rep">>) ->
    <<"application/vnd.businessobjects">>;
from_extension(<<"res">>) ->
    <<"application/x-dtbresource+xml">>;
from_extension(<<"rgb">>) ->
    <<"image/x-rgb">>;
from_extension(<<"rif">>) ->
    <<"application/reginfo+xml">>;
from_extension(<<"rip">>) ->
    <<"audio/vnd.rip">>;
from_extension(<<"ris">>) ->
    <<"application/x-research-info-systems">>;
from_extension(<<"rl">>) ->
    <<"application/resource-lists+xml">>;
from_extension(<<"rlc">>) ->
    <<"image/vnd.fujixerox.edmics-rlc">>;
from_extension(<<"rld">>) ->
    <<"application/resource-lists-diff+xml">>;
from_extension(<<"rm">>) ->
    <<"application/vnd.rn-realmedia">>;
from_extension(<<"rmi">>) ->
    <<"audio/midi">>;
from_extension(<<"rmp">>) ->
    <<"audio/x-pn-realaudio-plugin">>;
from_extension(<<"rms">>) ->
    <<"application/vnd.jcp.javame.midlet-rms">>;
from_extension(<<"rmvb">>) ->
    <<"application/vnd.rn-realmedia-vbr">>;
from_extension(<<"rnc">>) ->
    <<"application/relax-ng-compact-syntax">>;
from_extension(<<"roa">>) ->
    <<"application/rpki-roa">>;
from_extension(<<"roff">>) ->
    <<"text/troff">>;
from_extension(<<"rp9">>) ->
    <<"application/vnd.cloanto.rp9">>;
from_extension(<<"rpss">>) ->
    <<"application/vnd.nokia.radio-presets">>;
from_extension(<<"rpst">>) ->
    <<"application/vnd.nokia.radio-preset">>;
from_extension(<<"rq">>) ->
    <<"application/sparql-query">>;
from_extension(<<"rs">>) ->
    <<"application/rls-services+xml">>;
from_extension(<<"rsd">>) ->
    <<"application/rsd+xml">>;
from_extension(<<"rss">>) ->
    <<"application/rss+xml">>;
from_extension(<<"rtf">>) ->
    <<"application/rtf">>;
from_extension(<<"rtx">>) ->
    <<"text/richtext">>;
from_extension(<<"s">>) ->
    <<"text/x-asm">>;
from_extension(<<"s3m">>) ->
    <<"audio/s3m">>;
from_extension(<<"saf">>) ->
    <<"application/vnd.yamaha.smaf-audio">>;
from_extension(<<"sbml">>) ->
    <<"application/sbml+xml">>;
from_extension(<<"sc">>) ->
    <<"application/vnd.ibm.secure-container">>;
from_extension(<<"scd">>) ->
    <<"application/x-msschedule">>;
from_extension(<<"scm">>) ->
    <<"application/vnd.lotus-screencam">>;
from_extension(<<"scq">>) ->
    <<"application/scvp-cv-request">>;
from_extension(<<"scs">>) ->
    <<"application/scvp-cv-response">>;
from_extension(<<"scurl">>) ->
    <<"text/vnd.curl.scurl">>;
from_extension(<<"sda">>) ->
    <<"application/vnd.stardivision.draw">>;
from_extension(<<"sdc">>) ->
    <<"application/vnd.stardivision.calc">>;
from_extension(<<"sdd">>) ->
    <<"application/vnd.stardivision.impress">>;
from_extension(<<"sdkd">>) ->
    <<"application/vnd.solent.sdkm+xml">>;
from_extension(<<"sdkm">>) ->
    <<"application/vnd.solent.sdkm+xml">>;
from_extension(<<"sdp">>) ->
    <<"application/sdp">>;
from_extension(<<"sdw">>) ->
    <<"application/vnd.stardivision.writer">>;
from_extension(<<"see">>) ->
    <<"application/vnd.seemail">>;
from_extension(<<"seed">>) ->
    <<"application/vnd.fdsn.seed">>;
from_extension(<<"sema">>) ->
    <<"application/vnd.sema">>;
from_extension(<<"semd">>) ->
    <<"application/vnd.semd">>;
from_extension(<<"semf">>) ->
    <<"application/vnd.semf">>;
from_extension(<<"ser">>) ->
    <<"application/java-serialized-object">>;
from_extension(<<"setpay">>) ->
    <<"application/set-payment-initiation">>;
from_extension(<<"setreg">>) ->
    <<"application/set-registration-initiation">>;
from_extension(<<"sfd-hdstx">>) ->
    <<"application/vnd.hydrostatix.sof-data">>;
from_extension(<<"sfs">>) ->
    <<"application/vnd.spotfire.sfs">>;
from_extension(<<"sfv">>) ->
    <<"text/x-sfv">>;
from_extension(<<"sgi">>) ->
    <<"image/sgi">>;
from_extension(<<"sgl">>) ->
    <<"application/vnd.stardivision.writer-global">>;
from_extension(<<"sgm">>) ->
    <<"text/sgml">>;
from_extension(<<"sgml">>) ->
    <<"text/sgml">>;
from_extension(<<"sh">>) ->
    <<"application/x-sh">>;
from_extension(<<"shar">>) ->
    <<"application/x-shar">>;
from_extension(<<"shf">>) ->
    <<"application/shf+xml">>;
from_extension(<<"sid">>) ->
    <<"image/x-mrsid-image">>;
from_extension(<<"sig">>) ->
    <<"application/pgp-signature">>;
from_extension(<<"sil">>) ->
    <<"audio/silk">>;
from_extension(<<"silo">>) ->
    <<"model/mesh">>;
from_extension(<<"sis">>) ->
    <<"application/vnd.symbian.install">>;
from_extension(<<"sisx">>) ->
    <<"application/vnd.symbian.install">>;
from_extension(<<"sit">>) ->
    <<"application/x-stuffit">>;
from_extension(<<"sitx">>) ->
    <<"application/x-stuffitx">>;
from_extension(<<"skd">>) ->
    <<"application/vnd.koan">>;
from_extension(<<"skm">>) ->
    <<"application/vnd.koan">>;
from_extension(<<"skp">>) ->
    <<"application/vnd.koan">>;
from_extension(<<"skt">>) ->
    <<"application/vnd.koan">>;
from_extension(<<"sldm">>) ->
    <<"application/vnd.ms-powerpoint.slide.macroenabled.12">>;
from_extension(<<"sldx">>) ->
    <<"application/vnd.openxmlformats-officedocument.presentationml.slide">>;
from_extension(<<"slt">>) ->
    <<"application/vnd.epson.salt">>;
from_extension(<<"sm">>) ->
    <<"application/vnd.stepmania.stepchart">>;
from_extension(<<"smf">>) ->
    <<"application/vnd.stardivision.math">>;
from_extension(<<"smi">>) ->
    <<"application/smil+xml">>;
from_extension(<<"smil">>) ->
    <<"application/smil+xml">>;
from_extension(<<"smv">>) ->
    <<"video/x-smv">>;
from_extension(<<"smzip">>) ->
    <<"application/vnd.stepmania.package">>;
from_extension(<<"snd">>) ->
    <<"audio/basic">>;
from_extension(<<"snf">>) ->
    <<"application/x-font-snf">>;
from_extension(<<"so">>) ->
    <<"application/octet-stream">>;
from_extension(<<"spc">>) ->
    <<"application/x-pkcs7-certificates">>;
from_extension(<<"spf">>) ->
    <<"application/vnd.yamaha.smaf-phrase">>;
from_extension(<<"spl">>) ->
    <<"application/x-futuresplash">>;
from_extension(<<"spot">>) ->
    <<"text/vnd.in3d.spot">>;
from_extension(<<"spp">>) ->
    <<"application/scvp-vp-response">>;
from_extension(<<"spq">>) ->
    <<"application/scvp-vp-request">>;
from_extension(<<"spx">>) ->
    <<"audio/ogg">>;
from_extension(<<"sql">>) ->
    <<"application/x-sql">>;
from_extension(<<"src">>) ->
    <<"application/x-wais-source">>;
from_extension(<<"srt">>) ->
    <<"application/x-subrip">>;
from_extension(<<"sru">>) ->
    <<"application/sru+xml">>;
from_extension(<<"srx">>) ->
    <<"application/sparql-results+xml">>;
from_extension(<<"ssdl">>) ->
    <<"application/ssdl+xml">>;
from_extension(<<"sse">>) ->
    <<"application/vnd.kodak-descriptor">>;
from_extension(<<"ssf">>) ->
    <<"application/vnd.epson.ssf">>;
from_extension(<<"ssml">>) ->
    <<"application/ssml+xml">>;
from_extension(<<"st">>) ->
    <<"application/vnd.sailingtracker.track">>;
from_extension(<<"stc">>) ->
    <<"application/vnd.sun.xml.calc.template">>;
from_extension(<<"std">>) ->
    <<"application/vnd.sun.xml.draw.template">>;
from_extension(<<"stf">>) ->
    <<"application/vnd.wt.stf">>;
from_extension(<<"sti">>) ->
    <<"application/vnd.sun.xml.impress.template">>;
from_extension(<<"stk">>) ->
    <<"application/hyperstudio">>;
from_extension(<<"stl">>) ->
    <<"application/vnd.ms-pki.stl">>;
from_extension(<<"str">>) ->
    <<"application/vnd.pg.format">>;
from_extension(<<"stw">>) ->
    <<"application/vnd.sun.xml.writer.template">>;
from_extension(<<"sub">>) ->
    <<"image/vnd.dvb.subtitle">>;
from_extension(<<"sus">>) ->
    <<"application/vnd.sus-calendar">>;
from_extension(<<"susp">>) ->
    <<"application/vnd.sus-calendar">>;
from_extension(<<"sv4cpio">>) ->
    <<"application/x-sv4cpio">>;
from_extension(<<"sv4crc">>) ->
    <<"application/x-sv4crc">>;
from_extension(<<"svc">>) ->
    <<"application/vnd.dvb.service">>;
from_extension(<<"svd">>) ->
    <<"application/vnd.svd">>;
from_extension(<<"svg">>) ->
    <<"image/svg+xml">>;
from_extension(<<"svgz">>) ->
    <<"image/svg+xml">>;
from_extension(<<"swa">>) ->
    <<"application/x-director">>;
from_extension(<<"swf">>) ->
    <<"application/x-shockwave-flash">>;
from_extension(<<"swi">>) ->
    <<"application/vnd.aristanetworks.swi">>;
from_extension(<<"sxc">>) ->
    <<"application/vnd.sun.xml.calc">>;
from_extension(<<"sxd">>) ->
    <<"application/vnd.sun.xml.draw">>;
from_extension(<<"sxg">>) ->
    <<"application/vnd.sun.xml.writer.global">>;
from_extension(<<"sxi">>) ->
    <<"application/vnd.sun.xml.impress">>;
from_extension(<<"sxm">>) ->
    <<"application/vnd.sun.xml.math">>;
from_extension(<<"sxw">>) ->
    <<"application/vnd.sun.xml.writer">>;
from_extension(<<"t">>) ->
    <<"text/troff">>;
from_extension(<<"t3">>) ->
    <<"application/x-t3vm-image">>;
from_extension(<<"taglet">>) ->
    <<"application/vnd.mynfc">>;
from_extension(<<"tao">>) ->
    <<"application/vnd.tao.intent-module-archive">>;
from_extension(<<"tar">>) ->
    <<"application/x-tar">>;
from_extension(<<"tcap">>) ->
    <<"application/vnd.3gpp2.tcap">>;
from_extension(<<"tcl">>) ->
    <<"application/x-tcl">>;
from_extension(<<"teacher">>) ->
    <<"application/vnd.smart.teacher">>;
from_extension(<<"tei">>) ->
    <<"application/tei+xml">>;
from_extension(<<"teicorpus">>) ->
    <<"application/tei+xml">>;
from_extension(<<"tex">>) ->
    <<"application/x-tex">>;
from_extension(<<"texi">>) ->
    <<"application/x-texinfo">>;
from_extension(<<"texinfo">>) ->
    <<"application/x-texinfo">>;
from_extension(<<"text">>) ->
    <<"text/plain">>;
from_extension(<<"tfi">>) ->
    <<"application/thraud+xml">>;
from_extension(<<"tfm">>) ->
    <<"application/x-tex-tfm">>;
from_extension(<<"tga">>) ->
    <<"image/x-tga">>;
from_extension(<<"thmx">>) ->
    <<"application/vnd.ms-officetheme">>;
from_extension(<<"tif">>) ->
    <<"image/tiff">>;
from_extension(<<"tiff">>) ->
    <<"image/tiff">>;
from_extension(<<"tmo">>) ->
    <<"application/vnd.tmobile-livetv">>;
from_extension(<<"torrent">>) ->
    <<"application/x-bittorrent">>;
from_extension(<<"tpl">>) ->
    <<"application/vnd.groove-tool-template">>;
from_extension(<<"tpt">>) ->
    <<"application/vnd.trid.tpt">>;
from_extension(<<"tr">>) ->
    <<"text/troff">>;
from_extension(<<"tra">>) ->
    <<"application/vnd.trueapp">>;
from_extension(<<"trm">>) ->
    <<"application/x-msterminal">>;
from_extension(<<"ts">>) ->
    <<"video/mp2t">>;
from_extension(<<"tsd">>) ->
    <<"application/timestamped-data">>;
from_extension(<<"tsv">>) ->
    <<"text/tab-separated-values">>;
from_extension(<<"ttc">>) ->
    <<"font/collection">>;
from_extension(<<"ttf">>) ->
    <<"font/ttf">>;
from_extension(<<"ttl">>) ->
    <<"text/turtle">>;
from_extension(<<"twd">>) ->
    <<"application/vnd.simtech-mindmapper">>;
from_extension(<<"twds">>) ->
    <<"application/vnd.simtech-mindmapper">>;
from_extension(<<"txd">>) ->
    <<"application/vnd.genomatix.tuxedo">>;
from_extension(<<"txf">>) ->
    <<"application/vnd.mobius.txf">>;
from_extension(<<"txt">>) ->
    <<"text/plain">>;
from_extension(<<"u32">>) ->
    <<"application/x-authorware-bin">>;
from_extension(<<"udeb">>) ->
    <<"application/x-debian-package">>;
from_extension(<<"ufd">>) ->
    <<"application/vnd.ufdl">>;
from_extension(<<"ufdl">>) ->
    <<"application/vnd.ufdl">>;
from_extension(<<"ulx">>) ->
    <<"application/x-glulx">>;
from_extension(<<"umj">>) ->
    <<"application/vnd.umajin">>;
from_extension(<<"unityweb">>) ->
    <<"application/vnd.unity">>;
from_extension(<<"uoml">>) ->
    <<"application/vnd.uoml+xml">>;
from_extension(<<"uri">>) ->
    <<"text/uri-list">>;
from_extension(<<"uris">>) ->
    <<"text/uri-list">>;
from_extension(<<"urls">>) ->
    <<"text/uri-list">>;
from_extension(<<"ustar">>) ->
    <<"application/x-ustar">>;
from_extension(<<"utz">>) ->
    <<"application/vnd.uiq.theme">>;
from_extension(<<"uu">>) ->
    <<"text/x-uuencode">>;
from_extension(<<"uva">>) ->
    <<"audio/vnd.dece.audio">>;
from_extension(<<"uvd">>) ->
    <<"application/vnd.dece.data">>;
from_extension(<<"uvf">>) ->
    <<"application/vnd.dece.data">>;
from_extension(<<"uvg">>) ->
    <<"image/vnd.dece.graphic">>;
from_extension(<<"uvh">>) ->
    <<"video/vnd.dece.hd">>;
from_extension(<<"uvi">>) ->
    <<"image/vnd.dece.graphic">>;
from_extension(<<"uvm">>) ->
    <<"video/vnd.dece.mobile">>;
from_extension(<<"uvp">>) ->
    <<"video/vnd.dece.pd">>;
from_extension(<<"uvs">>) ->
    <<"video/vnd.dece.sd">>;
from_extension(<<"uvt">>) ->
    <<"application/vnd.dece.ttml+xml">>;
from_extension(<<"uvu">>) ->
    <<"video/vnd.uvvu.mp4">>;
from_extension(<<"uvv">>) ->
    <<"video/vnd.dece.video">>;
from_extension(<<"uvva">>) ->
    <<"audio/vnd.dece.audio">>;
from_extension(<<"uvvd">>) ->
    <<"application/vnd.dece.data">>;
from_extension(<<"uvvf">>) ->
    <<"application/vnd.dece.data">>;
from_extension(<<"uvvg">>) ->
    <<"image/vnd.dece.graphic">>;
from_extension(<<"uvvh">>) ->
    <<"video/vnd.dece.hd">>;
from_extension(<<"uvvi">>) ->
    <<"image/vnd.dece.graphic">>;
from_extension(<<"uvvm">>) ->
    <<"video/vnd.dece.mobile">>;
from_extension(<<"uvvp">>) ->
    <<"video/vnd.dece.pd">>;
from_extension(<<"uvvs">>) ->
    <<"video/vnd.dece.sd">>;
from_extension(<<"uvvt">>) ->
    <<"application/vnd.dece.ttml+xml">>;
from_extension(<<"uvvu">>) ->
    <<"video/vnd.uvvu.mp4">>;
from_extension(<<"uvvv">>) ->
    <<"video/vnd.dece.video">>;
from_extension(<<"uvvx">>) ->
    <<"application/vnd.dece.unspecified">>;
from_extension(<<"uvvz">>) ->
    <<"application/vnd.dece.zip">>;
from_extension(<<"uvx">>) ->
    <<"application/vnd.dece.unspecified">>;
from_extension(<<"uvz">>) ->
    <<"application/vnd.dece.zip">>;
from_extension(<<"vcard">>) ->
    <<"text/vcard">>;
from_extension(<<"vcd">>) ->
    <<"application/x-cdlink">>;
from_extension(<<"vcf">>) ->
    <<"text/x-vcard">>;
from_extension(<<"vcg">>) ->
    <<"application/vnd.groove-vcard">>;
from_extension(<<"vcs">>) ->
    <<"text/x-vcalendar">>;
from_extension(<<"vcx">>) ->
    <<"application/vnd.vcx">>;
from_extension(<<"vis">>) ->
    <<"application/vnd.visionary">>;
from_extension(<<"viv">>) ->
    <<"video/vnd.vivo">>;
from_extension(<<"vob">>) ->
    <<"video/x-ms-vob">>;
from_extension(<<"vor">>) ->
    <<"application/vnd.stardivision.writer">>;
from_extension(<<"vox">>) ->
    <<"application/x-authorware-bin">>;
from_extension(<<"vrml">>) ->
    <<"model/vrml">>;
from_extension(<<"vsd">>) ->
    <<"application/vnd.visio">>;
from_extension(<<"vsf">>) ->
    <<"application/vnd.vsf">>;
from_extension(<<"vss">>) ->
    <<"application/vnd.visio">>;
from_extension(<<"vst">>) ->
    <<"application/vnd.visio">>;
from_extension(<<"vsw">>) ->
    <<"application/vnd.visio">>;
from_extension(<<"vtu">>) ->
    <<"model/vnd.vtu">>;
from_extension(<<"vxml">>) ->
    <<"application/voicexml+xml">>;
from_extension(<<"w3d">>) ->
    <<"application/x-director">>;
from_extension(<<"wad">>) ->
    <<"application/x-doom">>;
from_extension(<<"wasm">>) ->
    <<"application/wasm">>;
from_extension(<<"wax">>) ->
    <<"audio/x-ms-wax">>;
from_extension(<<"wbmp">>) ->
    <<"image/vnd.wap.wbmp">>;
from_extension(<<"wbs">>) ->
    <<"application/vnd.criticaltools.wbs+xml">>;
from_extension(<<"wbxml">>) ->
    <<"application/vnd.wap.wbxml">>;
from_extension(<<"wcm">>) ->
    <<"application/vnd.ms-works">>;
from_extension(<<"wdb">>) ->
    <<"application/vnd.ms-works">>;
from_extension(<<"wdp">>) ->
    <<"image/vnd.ms-photo">>;
from_extension(<<"weba">>) ->
    <<"audio/webm">>;
from_extension(<<"webm">>) ->
    <<"video/webm">>;
from_extension(<<"webp">>) ->
    <<"image/webp">>;
from_extension(<<"wg">>) ->
    <<"application/vnd.pmi.widget">>;
from_extension(<<"wgt">>) ->
    <<"application/widget">>;
from_extension(<<"wks">>) ->
    <<"application/vnd.ms-works">>;
from_extension(<<"wm">>) ->
    <<"video/x-ms-wm">>;
from_extension(<<"wma">>) ->
    <<"audio/x-ms-wma">>;
from_extension(<<"wmd">>) ->
    <<"application/x-ms-wmd">>;
from_extension(<<"wmf">>) ->
    <<"application/x-msmetafile">>;
from_extension(<<"wml">>) ->
    <<"text/vnd.wap.wml">>;
from_extension(<<"wmlc">>) ->
    <<"application/vnd.wap.wmlc">>;
from_extension(<<"wmls">>) ->
    <<"text/vnd.wap.wmlscript">>;
from_extension(<<"wmlsc">>) ->
    <<"application/vnd.wap.wmlscriptc">>;
from_extension(<<"wmv">>) ->
    <<"video/x-ms-wmv">>;
from_extension(<<"wmx">>) ->
    <<"video/x-ms-wmx">>;
from_extension(<<"wmz">>) ->
    <<"application/x-ms-wmz">>;
from_extension(<<"woff">>) ->
    <<"font/woff">>;
from_extension(<<"woff2">>) ->
    <<"font/woff2">>;
from_extension(<<"wpd">>) ->
    <<"application/vnd.wordperfect">>;
from_extension(<<"wpl">>) ->
    <<"application/vnd.ms-wpl">>;
from_extension(<<"wps">>) ->
    <<"application/vnd.ms-works">>;
from_extension(<<"wqd">>) ->
    <<"application/vnd.wqd">>;
from_extension(<<"wri">>) ->
    <<"application/x-mswrite">>;
from_extension(<<"wrl">>) ->
    <<"model/vrml">>;
from_extension(<<"wsdl">>) ->
    <<"application/wsdl+xml">>;
from_extension(<<"wspolicy">>) ->
    <<"application/wspolicy+xml">>;
from_extension(<<"wtb">>) ->
    <<"application/vnd.webturbo">>;
from_extension(<<"wvx">>) ->
    <<"video/x-ms-wvx">>;
from_extension(<<"x32">>) ->
    <<"application/x-authorware-bin">>;
from_extension(<<"x3d">>) ->
    <<"model/x3d+xml">>;
from_extension(<<"x3db">>) ->
    <<"model/x3d+binary">>;
from_extension(<<"x3dbz">>) ->
    <<"model/x3d+binary">>;
from_extension(<<"x3dv">>) ->
    <<"model/x3d+vrml">>;
from_extension(<<"x3dvz">>) ->
    <<"model/x3d+vrml">>;
from_extension(<<"x3dz">>) ->
    <<"model/x3d+xml">>;
from_extension(<<"xaml">>) ->
    <<"application/xaml+xml">>;
from_extension(<<"xap">>) ->
    <<"application/x-silverlight-app">>;
from_extension(<<"xar">>) ->
    <<"application/vnd.xara">>;
from_extension(<<"xbap">>) ->
    <<"application/x-ms-xbap">>;
from_extension(<<"xbd">>) ->
    <<"application/vnd.fujixerox.docuworks.binder">>;
from_extension(<<"xbm">>) ->
    <<"image/x-xbitmap">>;
from_extension(<<"xdf">>) ->
    <<"application/xcap-diff+xml">>;
from_extension(<<"xdm">>) ->
    <<"application/vnd.syncml.dm+xml">>;
from_extension(<<"xdp">>) ->
    <<"application/vnd.adobe.xdp+xml">>;
from_extension(<<"xdssc">>) ->
    <<"application/dssc+xml">>;
from_extension(<<"xdw">>) ->
    <<"application/vnd.fujixerox.docuworks">>;
from_extension(<<"xenc">>) ->
    <<"application/xenc+xml">>;
from_extension(<<"xer">>) ->
    <<"application/patch-ops-error+xml">>;
from_extension(<<"xfdf">>) ->
    <<"application/vnd.adobe.xfdf">>;
from_extension(<<"xfdl">>) ->
    <<"application/vnd.xfdl">>;
from_extension(<<"xht">>) ->
    <<"application/xhtml+xml">>;
from_extension(<<"xhtml">>) ->
    <<"application/xhtml+xml">>;
from_extension(<<"xhvml">>) ->
    <<"application/xv+xml">>;
from_extension(<<"xif">>) ->
    <<"image/vnd.xiff">>;
from_extension(<<"xla">>) ->
    <<"application/vnd.ms-excel">>;
from_extension(<<"xlam">>) ->
    <<"application/vnd.ms-excel.addin.macroenabled.12">>;
from_extension(<<"xlc">>) ->
    <<"application/vnd.ms-excel">>;
from_extension(<<"xlf">>) ->
    <<"application/x-xliff+xml">>;
from_extension(<<"xlm">>) ->
    <<"application/vnd.ms-excel">>;
from_extension(<<"xls">>) ->
    <<"application/vnd.ms-excel">>;
from_extension(<<"xlsb">>) ->
    <<"application/vnd.ms-excel.sheet.binary.macroenabled.12">>;
from_extension(<<"xlsm">>) ->
    <<"application/vnd.ms-excel.sheet.macroenabled.12">>;
from_extension(<<"xlsx">>) ->
    <<"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">>;
from_extension(<<"xlt">>) ->
    <<"application/vnd.ms-excel">>;
from_extension(<<"xltm">>) ->
    <<"application/vnd.ms-excel.template.macroenabled.12">>;
from_extension(<<"xltx">>) ->
    <<"application/vnd.openxmlformats-officedocument.spreadsheetml.template">>;
from_extension(<<"xlw">>) ->
    <<"application/vnd.ms-excel">>;
from_extension(<<"xm">>) ->
    <<"audio/xm">>;
from_extension(<<"xml">>) ->
    <<"application/xml">>;
from_extension(<<"xo">>) ->
    <<"application/vnd.olpc-sugar">>;
from_extension(<<"xop">>) ->
    <<"application/xop+xml">>;
from_extension(<<"xpi">>) ->
    <<"application/x-xpinstall">>;
from_extension(<<"xpl">>) ->
    <<"application/xproc+xml">>;
from_extension(<<"xpm">>) ->
    <<"image/x-xpixmap">>;
from_extension(<<"xpr">>) ->
    <<"application/vnd.is-xpr">>;
from_extension(<<"xps">>) ->
    <<"application/vnd.ms-xpsdocument">>;
from_extension(<<"xpw">>) ->
    <<"application/vnd.intercon.formnet">>;
from_extension(<<"xpx">>) ->
    <<"application/vnd.intercon.formnet">>;
from_extension(<<"xsl">>) ->
    <<"application/xml">>;
from_extension(<<"xslt">>) ->
    <<"application/xslt+xml">>;
from_extension(<<"xsm">>) ->
    <<"application/vnd.syncml+xml">>;
from_extension(<<"xspf">>) ->
    <<"application/xspf+xml">>;
from_extension(<<"xul">>) ->
    <<"application/vnd.mozilla.xul+xml">>;
from_extension(<<"xvm">>) ->
    <<"application/xv+xml">>;
from_extension(<<"xvml">>) ->
    <<"application/xv+xml">>;
from_extension(<<"xwd">>) ->
    <<"image/x-xwindowdump">>;
from_extension(<<"xyz">>) ->
    <<"chemical/x-xyz">>;
from_extension(<<"xz">>) ->
    <<"application/x-xz">>;
from_extension(<<"yang">>) ->
    <<"application/yang">>;
from_extension(<<"yin">>) ->
    <<"application/yin+xml">>;
from_extension(<<"z1">>) ->
    <<"application/x-zmachine">>;
from_extension(<<"z2">>) ->
    <<"application/x-zmachine">>;
from_extension(<<"z3">>) ->
    <<"application/x-zmachine">>;
from_extension(<<"z4">>) ->
    <<"application/x-zmachine">>;
from_extension(<<"z5">>) ->
    <<"application/x-zmachine">>;
from_extension(<<"z6">>) ->
    <<"application/x-zmachine">>;
from_extension(<<"z7">>) ->
    <<"application/x-zmachine">>;
from_extension(<<"z8">>) ->
    <<"application/x-zmachine">>;
from_extension(<<"zaz">>) ->
    <<"application/vnd.zzazz.deck+xml">>;
from_extension(<<"zip">>) ->
    <<"application/zip">>;
from_extension(<<"zir">>) ->
    <<"application/vnd.zul">>;
from_extension(<<"zirz">>) ->
    <<"application/vnd.zul">>;
from_extension(<<"zmm">>) ->
    <<"application/vnd.handheld-entertainment+xml">>;
from_extension(<<"pem">>) ->
    <<"application/x-pem-file">>;
from_extension(<<"wav">>) ->
    <<"audio/wav">>;
from_extension(_) ->
    <<"application/octet-stream">>.

-spec to_extensions(binary()) -> [binary()].
to_extensions(<<"audio/mp3">>) ->
    [<<"mp3">>];
to_extensions(<<"audio/wav">>) ->
    [<<"wav">>];
to_extensions(<<"audio/x-wave">>) ->
    [<<"wav">>];
to_extensions(<<"application/x-pem-file">>) ->
    [<<"pem">>];
to_extensions(<<"application/andrew-inset">>) ->
    [<<"ez">>];
to_extensions(<<"application/applixware">>) ->
    [<<"aw">>];
to_extensions(<<"application/atomcat+xml">>) ->
    [<<"atomcat">>];
to_extensions(<<"application/atomsvc+xml">>) ->
    [<<"atomsvc">>];
to_extensions(<<"application/atom+xml">>) ->
    [<<"atom">>];
to_extensions(<<"application/ccxml+xml">>) ->
    [<<"ccxml">>];
to_extensions(<<"application/cdmi-capability">>) ->
    [<<"cdmia">>];
to_extensions(<<"application/cdmi-container">>) ->
    [<<"cdmic">>];
to_extensions(<<"application/cdmi-domain">>) ->
    [<<"cdmid">>];
to_extensions(<<"application/cdmi-object">>) ->
    [<<"cdmio">>];
to_extensions(<<"application/cdmi-queue">>) ->
    [<<"cdmiq">>];
to_extensions(<<"application/cu-seeme">>) ->
    [<<"cu">>];
to_extensions(<<"application/davmount+xml">>) ->
    [<<"davmount">>];
to_extensions(<<"application/docbook+xml">>) ->
    [<<"dbk">>];
to_extensions(<<"application/dssc+der">>) ->
    [<<"dssc">>];
to_extensions(<<"application/dssc+xml">>) ->
    [<<"xdssc">>];
to_extensions(<<"application/ecmascript">>) ->
    [<<"ecma">>];
to_extensions(<<"application/emma+xml">>) ->
    [<<"emma">>];
to_extensions(<<"application/epub+zip">>) ->
    [<<"epub">>];
to_extensions(<<"application/exi">>) ->
    [<<"exi">>];
to_extensions(<<"application/font-tdpfr">>) ->
    [<<"pfr">>];
to_extensions(<<"application/gml+xml">>) ->
    [<<"gml">>];
to_extensions(<<"application/gpx+xml">>) ->
    [<<"gpx">>];
to_extensions(<<"application/gxf">>) ->
    [<<"gxf">>];
to_extensions(<<"application/hyperstudio">>) ->
    [<<"stk">>];
to_extensions(<<"application/inkml+xml">>) ->
    [<<"ink">>, <<"inkml">>];
to_extensions(<<"application/ipfix">>) ->
    [<<"ipfix">>];
to_extensions(<<"application/java-archive">>) ->
    [<<"jar">>];
to_extensions(<<"application/java-serialized-object">>) ->
    [<<"ser">>];
to_extensions(<<"application/java-vm">>) ->
    [<<"class">>];
to_extensions(<<"application/json">>) ->
    [<<"json">>];
to_extensions(<<"application/jsonml+json">>) ->
    [<<"jsonml">>];
to_extensions(<<"application/lost+xml">>) ->
    [<<"lostxml">>];
to_extensions(<<"application/mac-binhex40">>) ->
    [<<"hqx">>];
to_extensions(<<"application/mac-compactpro">>) ->
    [<<"cpt">>];
to_extensions(<<"application/mads+xml">>) ->
    [<<"mads">>];
to_extensions(<<"application/marc">>) ->
    [<<"mrc">>];
to_extensions(<<"application/marcxml+xml">>) ->
    [<<"mrcx">>];
to_extensions(<<"application/mathematica">>) ->
    [<<"ma">>, <<"nb">>, <<"mb">>];
to_extensions(<<"application/mathml+xml">>) ->
    [<<"mathml">>];
to_extensions(<<"application/mbox">>) ->
    [<<"mbox">>];
to_extensions(<<"application/mediaservercontrol+xml">>) ->
    [<<"mscml">>];
to_extensions(<<"application/metalink4+xml">>) ->
    [<<"meta4">>];
to_extensions(<<"application/metalink+xml">>) ->
    [<<"metalink">>];
to_extensions(<<"application/mets+xml">>) ->
    [<<"mets">>];
to_extensions(<<"application/mods+xml">>) ->
    [<<"mods">>];
to_extensions(<<"application/mp21">>) ->
    [<<"m21">>, <<"mp21">>];
to_extensions(<<"application/mp4">>) ->
    [<<"mp4s">>];
to_extensions(<<"application/msword">>) ->
    [<<"doc">>, <<"dot">>];
to_extensions(<<"application/mxf">>) ->
    [<<"mxf">>];
to_extensions(<<"application/octet-stream">>) ->
    [
        <<"bin">>,
        <<"dms">>,
        <<"lrf">>,
        <<"mar">>,
        <<"so">>,
        <<"dist">>,
        <<"distz">>,
        <<"pkg">>,
        <<"bpk">>,
        <<"dump">>,
        <<"elc">>,
        <<"deploy">>
    ];
to_extensions(<<"application/oda">>) ->
    [<<"oda">>];
to_extensions(<<"application/oebps-package+xml">>) ->
    [<<"opf">>];
to_extensions(<<"application/ogg">>) ->
    [<<"ogx">>];
to_extensions(<<"application/omdoc+xml">>) ->
    [<<"omdoc">>];
to_extensions(<<"application/onenote">>) ->
    [<<"onetoc">>, <<"onetoc2">>, <<"onetmp">>, <<"onepkg">>];
to_extensions(<<"application/oxps">>) ->
    [<<"oxps">>];
to_extensions(<<"application/patch-ops-error+xml">>) ->
    [<<"xer">>];
to_extensions(<<"application/pdf">>) ->
    [<<"pdf">>];
to_extensions(<<"application/pgp-encrypted">>) ->
    [<<"pgp">>];
to_extensions(<<"application/pgp-signature">>) ->
    [<<"asc">>, <<"sig">>];
to_extensions(<<"application/pics-rules">>) ->
    [<<"prf">>];
to_extensions(<<"application/pkcs10">>) ->
    [<<"p10">>];
to_extensions(<<"application/pkcs7-mime">>) ->
    [<<"p7m">>, <<"p7c">>];
to_extensions(<<"application/pkcs7-signature">>) ->
    [<<"p7s">>];
to_extensions(<<"application/pkcs8">>) ->
    [<<"p8">>];
to_extensions(<<"application/pkix-attr-cert">>) ->
    [<<"ac">>];
to_extensions(<<"application/pkix-cert">>) ->
    [<<"cer">>];
to_extensions(<<"application/pkixcmp">>) ->
    [<<"pki">>];
to_extensions(<<"application/pkix-crl">>) ->
    [<<"crl">>];
to_extensions(<<"application/pkix-pkipath">>) ->
    [<<"pkipath">>];
to_extensions(<<"application/pls+xml">>) ->
    [<<"pls">>];
to_extensions(<<"application/postscript">>) ->
    [<<"ai">>, <<"eps">>, <<"ps">>];
to_extensions(<<"application/prs.cww">>) ->
    [<<"cww">>];
to_extensions(<<"application/pskc+xml">>) ->
    [<<"pskcxml">>];
to_extensions(<<"application/rdf+xml">>) ->
    [<<"rdf">>];
to_extensions(<<"application/reginfo+xml">>) ->
    [<<"rif">>];
to_extensions(<<"application/relax-ng-compact-syntax">>) ->
    [<<"rnc">>];
to_extensions(<<"application/resource-lists-diff+xml">>) ->
    [<<"rld">>];
to_extensions(<<"application/resource-lists+xml">>) ->
    [<<"rl">>];
to_extensions(<<"application/rls-services+xml">>) ->
    [<<"rs">>];
to_extensions(<<"application/rpki-ghostbusters">>) ->
    [<<"gbr">>];
to_extensions(<<"application/rpki-manifest">>) ->
    [<<"mft">>];
to_extensions(<<"application/rpki-roa">>) ->
    [<<"roa">>];
to_extensions(<<"application/rsd+xml">>) ->
    [<<"rsd">>];
to_extensions(<<"application/rss+xml">>) ->
    [<<"rss">>];
to_extensions(<<"application/rtf">>) ->
    [<<"rtf">>];
to_extensions(<<"application/sbml+xml">>) ->
    [<<"sbml">>];
to_extensions(<<"application/scvp-cv-request">>) ->
    [<<"scq">>];
to_extensions(<<"application/scvp-cv-response">>) ->
    [<<"scs">>];
to_extensions(<<"application/scvp-vp-request">>) ->
    [<<"spq">>];
to_extensions(<<"application/scvp-vp-response">>) ->
    [<<"spp">>];
to_extensions(<<"application/sdp">>) ->
    [<<"sdp">>];
to_extensions(<<"application/set-payment-initiation">>) ->
    [<<"setpay">>];
to_extensions(<<"application/set-registration-initiation">>) ->
    [<<"setreg">>];
to_extensions(<<"application/shf+xml">>) ->
    [<<"shf">>];
to_extensions(<<"application/smil+xml">>) ->
    [<<"smi">>, <<"smil">>];
to_extensions(<<"application/sparql-query">>) ->
    [<<"rq">>];
to_extensions(<<"application/sparql-results+xml">>) ->
    [<<"srx">>];
to_extensions(<<"application/srgs">>) ->
    [<<"gram">>];
to_extensions(<<"application/srgs+xml">>) ->
    [<<"grxml">>];
to_extensions(<<"application/sru+xml">>) ->
    [<<"sru">>];
to_extensions(<<"application/ssdl+xml">>) ->
    [<<"ssdl">>];
to_extensions(<<"application/ssml+xml">>) ->
    [<<"ssml">>];
to_extensions(<<"application/tei+xml">>) ->
    [<<"tei">>, <<"teicorpus">>];
to_extensions(<<"application/thraud+xml">>) ->
    [<<"tfi">>];
to_extensions(<<"application/timestamped-data">>) ->
    [<<"tsd">>];
to_extensions(<<"application/vnd.3gpp2.tcap">>) ->
    [<<"tcap">>];
to_extensions(<<"application/vnd.3gpp.pic-bw-large">>) ->
    [<<"plb">>];
to_extensions(<<"application/vnd.3gpp.pic-bw-small">>) ->
    [<<"psb">>];
to_extensions(<<"application/vnd.3gpp.pic-bw-var">>) ->
    [<<"pvb">>];
to_extensions(<<"application/vnd.3m.post-it-notes">>) ->
    [<<"pwn">>];
to_extensions(<<"application/vnd.accpac.simply.aso">>) ->
    [<<"aso">>];
to_extensions(<<"application/vnd.accpac.simply.imp">>) ->
    [<<"imp">>];
to_extensions(<<"application/vnd.acucobol">>) ->
    [<<"acu">>];
to_extensions(<<"application/vnd.acucorp">>) ->
    [<<"atc">>, <<"acutc">>];
to_extensions(<<"application/vnd.adobe.air-application-installer-package+zip">>) ->
    [<<"air">>];
to_extensions(<<"application/vnd.adobe.formscentral.fcdt">>) ->
    [<<"fcdt">>];
to_extensions(<<"application/vnd.adobe.fxp">>) ->
    [<<"fxp">>, <<"fxpl">>];
to_extensions(<<"application/vnd.adobe.xdp+xml">>) ->
    [<<"xdp">>];
to_extensions(<<"application/vnd.adobe.xfdf">>) ->
    [<<"xfdf">>];
to_extensions(<<"application/vnd.ahead.space">>) ->
    [<<"ahead">>];
to_extensions(<<"application/vnd.airzip.filesecure.azf">>) ->
    [<<"azf">>];
to_extensions(<<"application/vnd.airzip.filesecure.azs">>) ->
    [<<"azs">>];
to_extensions(<<"application/vnd.amazon.ebook">>) ->
    [<<"azw">>];
to_extensions(<<"application/vnd.americandynamics.acc">>) ->
    [<<"acc">>];
to_extensions(<<"application/vnd.amiga.ami">>) ->
    [<<"ami">>];
to_extensions(<<"application/vnd.android.package-archive">>) ->
    [<<"apk">>];
to_extensions(<<"application/vnd.anser-web-certificate-issue-initiation">>) ->
    [<<"cii">>];
to_extensions(<<"application/vnd.anser-web-funds-transfer-initiation">>) ->
    [<<"fti">>];
to_extensions(<<"application/vnd.antix.game-component">>) ->
    [<<"atx">>];
to_extensions(<<"application/vnd.apple.installer+xml">>) ->
    [<<"mpkg">>];
to_extensions(<<"application/vnd.apple.mpegurl">>) ->
    [<<"m3u8">>];
to_extensions(<<"application/vnd.aristanetworks.swi">>) ->
    [<<"swi">>];
to_extensions(<<"application/vnd.astraea-software.iota">>) ->
    [<<"iota">>];
to_extensions(<<"application/vnd.audiograph">>) ->
    [<<"aep">>];
to_extensions(<<"application/vnd.blueice.multipass">>) ->
    [<<"mpm">>];
to_extensions(<<"application/vnd.bmi">>) ->
    [<<"bmi">>];
to_extensions(<<"application/vnd.businessobjects">>) ->
    [<<"rep">>];
to_extensions(<<"application/vnd.chemdraw+xml">>) ->
    [<<"cdxml">>];
to_extensions(<<"application/vnd.chipnuts.karaoke-mmd">>) ->
    [<<"mmd">>];
to_extensions(<<"application/vnd.cinderella">>) ->
    [<<"cdy">>];
to_extensions(<<"application/vnd.claymore">>) ->
    [<<"cla">>];
to_extensions(<<"application/vnd.cloanto.rp9">>) ->
    [<<"rp9">>];
to_extensions(<<"application/vnd.clonk.c4group">>) ->
    [<<"c4g">>, <<"c4d">>, <<"c4f">>, <<"c4p">>, <<"c4u">>];
to_extensions(<<"application/vnd.cluetrust.cartomobile-config">>) ->
    [<<"c11amc">>];
to_extensions(<<"application/vnd.cluetrust.cartomobile-config-pkg">>) ->
    [<<"c11amz">>];
to_extensions(<<"application/vnd.commonspace">>) ->
    [<<"csp">>];
to_extensions(<<"application/vnd.contact.cmsg">>) ->
    [<<"cdbcmsg">>];
to_extensions(<<"application/vnd.cosmocaller">>) ->
    [<<"cmc">>];
to_extensions(<<"application/vnd.crick.clicker">>) ->
    [<<"clkx">>];
to_extensions(<<"application/vnd.crick.clicker.keyboard">>) ->
    [<<"clkk">>];
to_extensions(<<"application/vnd.crick.clicker.palette">>) ->
    [<<"clkp">>];
to_extensions(<<"application/vnd.crick.clicker.template">>) ->
    [<<"clkt">>];
to_extensions(<<"application/vnd.crick.clicker.wordbank">>) ->
    [<<"clkw">>];
to_extensions(<<"application/vnd.criticaltools.wbs+xml">>) ->
    [<<"wbs">>];
to_extensions(<<"application/vnd.ctc-posml">>) ->
    [<<"pml">>];
to_extensions(<<"application/vnd.cups-ppd">>) ->
    [<<"ppd">>];
to_extensions(<<"application/vnd.curl.car">>) ->
    [<<"car">>];
to_extensions(<<"application/vnd.curl.pcurl">>) ->
    [<<"pcurl">>];
to_extensions(<<"application/vnd.dart">>) ->
    [<<"dart">>];
to_extensions(<<"application/vnd.data-vision.rdz">>) ->
    [<<"rdz">>];
to_extensions(<<"application/vnd.dece.data">>) ->
    [<<"uvf">>, <<"uvvf">>, <<"uvd">>, <<"uvvd">>];
to_extensions(<<"application/vnd.dece.ttml+xml">>) ->
    [<<"uvt">>, <<"uvvt">>];
to_extensions(<<"application/vnd.dece.unspecified">>) ->
    [<<"uvx">>, <<"uvvx">>];
to_extensions(<<"application/vnd.dece.zip">>) ->
    [<<"uvz">>, <<"uvvz">>];
to_extensions(<<"application/vnd.denovo.fcselayout-link">>) ->
    [<<"fe_launch">>];
to_extensions(<<"application/vnd.dna">>) ->
    [<<"dna">>];
to_extensions(<<"application/vnd.dolby.mlp">>) ->
    [<<"mlp">>];
to_extensions(<<"application/vnd.dpgraph">>) ->
    [<<"dpg">>];
to_extensions(<<"application/vnd.dreamfactory">>) ->
    [<<"dfac">>];
to_extensions(<<"application/vnd.ds-keypoint">>) ->
    [<<"kpxx">>];
to_extensions(<<"application/vnd.dvb.ait">>) ->
    [<<"ait">>];
to_extensions(<<"application/vnd.dvb.service">>) ->
    [<<"svc">>];
to_extensions(<<"application/vnd.dynageo">>) ->
    [<<"geo">>];
to_extensions(<<"application/vnd.ecowin.chart">>) ->
    [<<"mag">>];
to_extensions(<<"application/vnd.enliven">>) ->
    [<<"nml">>];
to_extensions(<<"application/vnd.epson.esf">>) ->
    [<<"esf">>];
to_extensions(<<"application/vnd.epson.msf">>) ->
    [<<"msf">>];
to_extensions(<<"application/vnd.epson.quickanime">>) ->
    [<<"qam">>];
to_extensions(<<"application/vnd.epson.salt">>) ->
    [<<"slt">>];
to_extensions(<<"application/vnd.epson.ssf">>) ->
    [<<"ssf">>];
to_extensions(<<"application/vnd.eszigno3+xml">>) ->
    [<<"es3">>, <<"et3">>];
to_extensions(<<"application/vnd.ezpix-album">>) ->
    [<<"ez2">>];
to_extensions(<<"application/vnd.ezpix-package">>) ->
    [<<"ez3">>];
to_extensions(<<"application/vnd.fdf">>) ->
    [<<"fdf">>];
to_extensions(<<"application/vnd.fdsn.mseed">>) ->
    [<<"mseed">>];
to_extensions(<<"application/vnd.fdsn.seed">>) ->
    [<<"seed">>, <<"dataless">>];
to_extensions(<<"application/vnd.flographit">>) ->
    [<<"gph">>];
to_extensions(<<"application/vnd.fluxtime.clip">>) ->
    [<<"ftc">>];
to_extensions(<<"application/vnd.framemaker">>) ->
    [<<"fm">>, <<"frame">>, <<"maker">>, <<"book">>];
to_extensions(<<"application/vnd.frogans.fnc">>) ->
    [<<"fnc">>];
to_extensions(<<"application/vnd.frogans.ltf">>) ->
    [<<"ltf">>];
to_extensions(<<"application/vnd.fsc.weblaunch">>) ->
    [<<"fsc">>];
to_extensions(<<"application/vnd.fujitsu.oasys2">>) ->
    [<<"oa2">>];
to_extensions(<<"application/vnd.fujitsu.oasys3">>) ->
    [<<"oa3">>];
to_extensions(<<"application/vnd.fujitsu.oasysgp">>) ->
    [<<"fg5">>];
to_extensions(<<"application/vnd.fujitsu.oasys">>) ->
    [<<"oas">>];
to_extensions(<<"application/vnd.fujitsu.oasysprs">>) ->
    [<<"bh2">>];
to_extensions(<<"application/vnd.fujixerox.ddd">>) ->
    [<<"ddd">>];
to_extensions(<<"application/vnd.fujixerox.docuworks.binder">>) ->
    [<<"xbd">>];
to_extensions(<<"application/vnd.fujixerox.docuworks">>) ->
    [<<"xdw">>];
to_extensions(<<"application/vnd.fuzzysheet">>) ->
    [<<"fzs">>];
to_extensions(<<"application/vnd.genomatix.tuxedo">>) ->
    [<<"txd">>];
to_extensions(<<"application/vnd.geogebra.file">>) ->
    [<<"ggb">>];
to_extensions(<<"application/vnd.geogebra.slides">>) ->
    [<<"ggs">>];
to_extensions(<<"application/vnd.geogebra.tool">>) ->
    [<<"ggt">>];
to_extensions(<<"application/vnd.geometry-explorer">>) ->
    [<<"gex">>, <<"gre">>];
to_extensions(<<"application/vnd.geonext">>) ->
    [<<"gxt">>];
to_extensions(<<"application/vnd.geoplan">>) ->
    [<<"g2w">>];
to_extensions(<<"application/vnd.geospace">>) ->
    [<<"g3w">>];
to_extensions(<<"application/vnd.gmx">>) ->
    [<<"gmx">>];
to_extensions(<<"application/vnd.google-earth.kml+xml">>) ->
    [<<"kml">>];
to_extensions(<<"application/vnd.google-earth.kmz">>) ->
    [<<"kmz">>];
to_extensions(<<"application/vnd.grafeq">>) ->
    [<<"gqf">>, <<"gqs">>];
to_extensions(<<"application/vnd.groove-account">>) ->
    [<<"gac">>];
to_extensions(<<"application/vnd.groove-help">>) ->
    [<<"ghf">>];
to_extensions(<<"application/vnd.groove-identity-message">>) ->
    [<<"gim">>];
to_extensions(<<"application/vnd.groove-injector">>) ->
    [<<"grv">>];
to_extensions(<<"application/vnd.groove-tool-message">>) ->
    [<<"gtm">>];
to_extensions(<<"application/vnd.groove-tool-template">>) ->
    [<<"tpl">>];
to_extensions(<<"application/vnd.groove-vcard">>) ->
    [<<"vcg">>];
to_extensions(<<"application/vnd.hal+xml">>) ->
    [<<"hal">>];
to_extensions(<<"application/vnd.handheld-entertainment+xml">>) ->
    [<<"zmm">>];
to_extensions(<<"application/vnd.hbci">>) ->
    [<<"hbci">>];
to_extensions(<<"application/vnd.hhe.lesson-player">>) ->
    [<<"les">>];
to_extensions(<<"application/vnd.hp-hpgl">>) ->
    [<<"hpgl">>];
to_extensions(<<"application/vnd.hp-hpid">>) ->
    [<<"hpid">>];
to_extensions(<<"application/vnd.hp-hps">>) ->
    [<<"hps">>];
to_extensions(<<"application/vnd.hp-jlyt">>) ->
    [<<"jlt">>];
to_extensions(<<"application/vnd.hp-pcl">>) ->
    [<<"pcl">>];
to_extensions(<<"application/vnd.hp-pclxl">>) ->
    [<<"pclxl">>];
to_extensions(<<"application/vnd.hydrostatix.sof-data">>) ->
    [<<"sfd-hdstx">>];
to_extensions(<<"application/vnd.ibm.minipay">>) ->
    [<<"mpy">>];
to_extensions(<<"application/vnd.ibm.modcap">>) ->
    [<<"afp">>, <<"listafp">>, <<"list3820">>];
to_extensions(<<"application/vnd.ibm.rights-management">>) ->
    [<<"irm">>];
to_extensions(<<"application/vnd.ibm.secure-container">>) ->
    [<<"sc">>];
to_extensions(<<"application/vnd.iccprofile">>) ->
    [<<"icc">>, <<"icm">>];
to_extensions(<<"application/vnd.igloader">>) ->
    [<<"igl">>];
to_extensions(<<"application/vnd.immervision-ivp">>) ->
    [<<"ivp">>];
to_extensions(<<"application/vnd.immervision-ivu">>) ->
    [<<"ivu">>];
to_extensions(<<"application/vnd.insors.igm">>) ->
    [<<"igm">>];
to_extensions(<<"application/vnd.intercon.formnet">>) ->
    [<<"xpw">>, <<"xpx">>];
to_extensions(<<"application/vnd.intergeo">>) ->
    [<<"i2g">>];
to_extensions(<<"application/vnd.intu.qbo">>) ->
    [<<"qbo">>];
to_extensions(<<"application/vnd.intu.qfx">>) ->
    [<<"qfx">>];
to_extensions(<<"application/vnd.ipunplugged.rcprofile">>) ->
    [<<"rcprofile">>];
to_extensions(<<"application/vnd.irepository.package+xml">>) ->
    [<<"irp">>];
to_extensions(<<"application/vnd.isac.fcs">>) ->
    [<<"fcs">>];
to_extensions(<<"application/vnd.is-xpr">>) ->
    [<<"xpr">>];
to_extensions(<<"application/vnd.jam">>) ->
    [<<"jam">>];
to_extensions(<<"application/vnd.jcp.javame.midlet-rms">>) ->
    [<<"rms">>];
to_extensions(<<"application/vnd.jisp">>) ->
    [<<"jisp">>];
to_extensions(<<"application/vnd.joost.joda-archive">>) ->
    [<<"joda">>];
to_extensions(<<"application/vnd.kahootz">>) ->
    [<<"ktz">>, <<"ktr">>];
to_extensions(<<"application/vnd.kde.karbon">>) ->
    [<<"karbon">>];
to_extensions(<<"application/vnd.kde.kchart">>) ->
    [<<"chrt">>];
to_extensions(<<"application/vnd.kde.kformula">>) ->
    [<<"kfo">>];
to_extensions(<<"application/vnd.kde.kivio">>) ->
    [<<"flw">>];
to_extensions(<<"application/vnd.kde.kontour">>) ->
    [<<"kon">>];
to_extensions(<<"application/vnd.kde.kpresenter">>) ->
    [<<"kpr">>, <<"kpt">>];
to_extensions(<<"application/vnd.kde.kspread">>) ->
    [<<"ksp">>];
to_extensions(<<"application/vnd.kde.kword">>) ->
    [<<"kwd">>, <<"kwt">>];
to_extensions(<<"application/vnd.kenameaapp">>) ->
    [<<"htke">>];
to_extensions(<<"application/vnd.kidspiration">>) ->
    [<<"kia">>];
to_extensions(<<"application/vnd.kinar">>) ->
    [<<"kne">>, <<"knp">>];
to_extensions(<<"application/vnd.koan">>) ->
    [<<"skp">>, <<"skd">>, <<"skt">>, <<"skm">>];
to_extensions(<<"application/vnd.kodak-descriptor">>) ->
    [<<"sse">>];
to_extensions(<<"application/vnd.las.las+xml">>) ->
    [<<"lasxml">>];
to_extensions(<<"application/vnd.llamagraphics.life-balance.desktop">>) ->
    [<<"lbd">>];
to_extensions(<<"application/vnd.llamagraphics.life-balance.exchange+xml">>) ->
    [<<"lbe">>];
to_extensions(<<"application/vnd.lotus-1-2-3">>) ->
    [<<"123">>];
to_extensions(<<"application/vnd.lotus-approach">>) ->
    [<<"apr">>];
to_extensions(<<"application/vnd.lotus-freelance">>) ->
    [<<"pre">>];
to_extensions(<<"application/vnd.lotus-notes">>) ->
    [<<"nsf">>];
to_extensions(<<"application/vnd.lotus-organizer">>) ->
    [<<"org">>];
to_extensions(<<"application/vnd.lotus-screencam">>) ->
    [<<"scm">>];
to_extensions(<<"application/vnd.lotus-wordpro">>) ->
    [<<"lwp">>];
to_extensions(<<"application/vnd.macports.portpkg">>) ->
    [<<"portpkg">>];
to_extensions(<<"application/vnd.mcd">>) ->
    [<<"mcd">>];
to_extensions(<<"application/vnd.medcalcdata">>) ->
    [<<"mc1">>];
to_extensions(<<"application/vnd.mediastation.cdkey">>) ->
    [<<"cdkey">>];
to_extensions(<<"application/vnd.mfer">>) ->
    [<<"mwf">>];
to_extensions(<<"application/vnd.mfmp">>) ->
    [<<"mfm">>];
to_extensions(<<"application/vnd.micrografx.flo">>) ->
    [<<"flo">>];
to_extensions(<<"application/vnd.micrografx.igx">>) ->
    [<<"igx">>];
to_extensions(<<"application/vnd.mif">>) ->
    [<<"mif">>];
to_extensions(<<"application/vnd.mobius.daf">>) ->
    [<<"daf">>];
to_extensions(<<"application/vnd.mobius.dis">>) ->
    [<<"dis">>];
to_extensions(<<"application/vnd.mobius.mbk">>) ->
    [<<"mbk">>];
to_extensions(<<"application/vnd.mobius.mqy">>) ->
    [<<"mqy">>];
to_extensions(<<"application/vnd.mobius.msl">>) ->
    [<<"msl">>];
to_extensions(<<"application/vnd.mobius.plc">>) ->
    [<<"plc">>];
to_extensions(<<"application/vnd.mobius.txf">>) ->
    [<<"txf">>];
to_extensions(<<"application/vnd.mophun.application">>) ->
    [<<"mpn">>];
to_extensions(<<"application/vnd.mophun.certificate">>) ->
    [<<"mpc">>];
to_extensions(<<"application/vnd.mozilla.xul+xml">>) ->
    [<<"xul">>];
to_extensions(<<"application/vnd.ms-artgalry">>) ->
    [<<"cil">>];
to_extensions(<<"application/vnd.ms-cab-compressed">>) ->
    [<<"cab">>];
to_extensions(<<"application/vnd.mseq">>) ->
    [<<"mseq">>];
to_extensions(<<"application/vnd.ms-excel.addin.macroenabled.12">>) ->
    [<<"xlam">>];
to_extensions(<<"application/vnd.ms-excel.sheet.binary.macroenabled.12">>) ->
    [<<"xlsb">>];
to_extensions(<<"application/vnd.ms-excel.sheet.macroenabled.12">>) ->
    [<<"xlsm">>];
to_extensions(<<"application/vnd.ms-excel.template.macroenabled.12">>) ->
    [<<"xltm">>];
to_extensions(<<"application/vnd.ms-excel">>) ->
    [<<"xls">>, <<"xlm">>, <<"xla">>, <<"xlc">>, <<"xlt">>, <<"xlw">>];
to_extensions(<<"application/vnd.ms-fontobject">>) ->
    [<<"eot">>];
to_extensions(<<"application/vnd.ms-htmlhelp">>) ->
    [<<"chm">>];
to_extensions(<<"application/vnd.ms-ims">>) ->
    [<<"ims">>];
to_extensions(<<"application/vnd.ms-lrm">>) ->
    [<<"lrm">>];
to_extensions(<<"application/vnd.ms-officetheme">>) ->
    [<<"thmx">>];
to_extensions(<<"application/vnd.ms-pki.seccat">>) ->
    [<<"cat">>];
to_extensions(<<"application/vnd.ms-pki.stl">>) ->
    [<<"stl">>];
to_extensions(<<"application/vnd.ms-powerpoint.addin.macroenabled.12">>) ->
    [<<"ppam">>];
to_extensions(<<"application/vnd.ms-powerpoint">>) ->
    [<<"ppt">>, <<"pps">>, <<"pot">>];
to_extensions(<<"application/vnd.ms-powerpoint.presentation.macroenabled.12">>) ->
    [<<"pptm">>];
to_extensions(<<"application/vnd.ms-powerpoint.slide.macroenabled.12">>) ->
    [<<"sldm">>];
to_extensions(<<"application/vnd.ms-powerpoint.slideshow.macroenabled.12">>) ->
    [<<"ppsm">>];
to_extensions(<<"application/vnd.ms-powerpoint.template.macroenabled.12">>) ->
    [<<"potm">>];
to_extensions(<<"application/vnd.ms-project">>) ->
    [<<"mpp">>, <<"mpt">>];
to_extensions(<<"application/vnd.ms-word.document.macroenabled.12">>) ->
    [<<"docm">>];
to_extensions(<<"application/vnd.ms-word.template.macroenabled.12">>) ->
    [<<"dotm">>];
to_extensions(<<"application/vnd.ms-works">>) ->
    [<<"wps">>, <<"wks">>, <<"wcm">>, <<"wdb">>];
to_extensions(<<"application/vnd.ms-wpl">>) ->
    [<<"wpl">>];
to_extensions(<<"application/vnd.ms-xpsdocument">>) ->
    [<<"xps">>];
to_extensions(<<"application/vnd.musician">>) ->
    [<<"mus">>];
to_extensions(<<"application/vnd.muvee.style">>) ->
    [<<"msty">>];
to_extensions(<<"application/vnd.mynfc">>) ->
    [<<"taglet">>];
to_extensions(<<"application/vnd.neurolanguage.nlu">>) ->
    [<<"nlu">>];
to_extensions(<<"application/vnd.nitf">>) ->
    [<<"ntf">>, <<"nitf">>];
to_extensions(<<"application/vnd.noblenet-directory">>) ->
    [<<"nnd">>];
to_extensions(<<"application/vnd.noblenet-sealer">>) ->
    [<<"nns">>];
to_extensions(<<"application/vnd.noblenet-web">>) ->
    [<<"nnw">>];
to_extensions(<<"application/vnd.nokia.n-gage.data">>) ->
    [<<"ngdat">>];
to_extensions(<<"application/vnd.nokia.n-gage.symbian.install">>) ->
    [<<"n-gage">>];
to_extensions(<<"application/vnd.nokia.radio-preset">>) ->
    [<<"rpst">>];
to_extensions(<<"application/vnd.nokia.radio-presets">>) ->
    [<<"rpss">>];
to_extensions(<<"application/vnd.novadigm.edm">>) ->
    [<<"edm">>];
to_extensions(<<"application/vnd.novadigm.edx">>) ->
    [<<"edx">>];
to_extensions(<<"application/vnd.novadigm.ext">>) ->
    [<<"ext">>];
to_extensions(<<"application/vnd.oasis.opendocument.chart">>) ->
    [<<"odc">>];
to_extensions(<<"application/vnd.oasis.opendocument.chart-template">>) ->
    [<<"otc">>];
to_extensions(<<"application/vnd.oasis.opendocument.database">>) ->
    [<<"odb">>];
to_extensions(<<"application/vnd.oasis.opendocument.formula">>) ->
    [<<"odf">>];
to_extensions(<<"application/vnd.oasis.opendocument.formula-template">>) ->
    [<<"odft">>];
to_extensions(<<"application/vnd.oasis.opendocument.graphics">>) ->
    [<<"odg">>];
to_extensions(<<"application/vnd.oasis.opendocument.graphics-template">>) ->
    [<<"otg">>];
to_extensions(<<"application/vnd.oasis.opendocument.image">>) ->
    [<<"odi">>];
to_extensions(<<"application/vnd.oasis.opendocument.image-template">>) ->
    [<<"oti">>];
to_extensions(<<"application/vnd.oasis.opendocument.presentation">>) ->
    [<<"odp">>];
to_extensions(<<"application/vnd.oasis.opendocument.presentation-template">>) ->
    [<<"otp">>];
to_extensions(<<"application/vnd.oasis.opendocument.spreadsheet">>) ->
    [<<"ods">>];
to_extensions(<<"application/vnd.oasis.opendocument.spreadsheet-template">>) ->
    [<<"ots">>];
to_extensions(<<"application/vnd.oasis.opendocument.text-master">>) ->
    [<<"odm">>];
to_extensions(<<"application/vnd.oasis.opendocument.text">>) ->
    [<<"odt">>];
to_extensions(<<"application/vnd.oasis.opendocument.text-template">>) ->
    [<<"ott">>];
to_extensions(<<"application/vnd.oasis.opendocument.text-web">>) ->
    [<<"oth">>];
to_extensions(<<"application/vnd.olpc-sugar">>) ->
    [<<"xo">>];
to_extensions(<<"application/vnd.oma.dd2+xml">>) ->
    [<<"dd2">>];
to_extensions(<<"application/vnd.openofficeorg.extension">>) ->
    [<<"oxt">>];
to_extensions(<<"application/vnd.openxmlformats-officedocument.presentationml.presentation">>) ->
    [<<"pptx">>];
to_extensions(<<"application/vnd.openxmlformats-officedocument.presentationml.slideshow">>) ->
    [<<"ppsx">>];
to_extensions(<<"application/vnd.openxmlformats-officedocument.presentationml.slide">>) ->
    [<<"sldx">>];
to_extensions(<<"application/vnd.openxmlformats-officedocument.presentationml.template">>) ->
    [<<"potx">>];
to_extensions(<<"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">>) ->
    [<<"xlsx">>];
to_extensions(<<"application/vnd.openxmlformats-officedocument.spreadsheetml.template">>) ->
    [<<"xltx">>];
to_extensions(<<"application/vnd.openxmlformats-officedocument.wordprocessingml.document">>) ->
    [<<"docx">>];
to_extensions(<<"application/vnd.openxmlformats-officedocument.wordprocessingml.template">>) ->
    [<<"dotx">>];
to_extensions(<<"application/vnd.osgeo.mapguide.package">>) ->
    [<<"mgp">>];
to_extensions(<<"application/vnd.osgi.dp">>) ->
    [<<"dp">>];
to_extensions(<<"application/vnd.osgi.subsystem">>) ->
    [<<"esa">>];
to_extensions(<<"application/vnd.palm">>) ->
    [<<"pdb">>, <<"pqa">>, <<"oprc">>];
to_extensions(<<"application/vnd.pawaafile">>) ->
    [<<"paw">>];
to_extensions(<<"application/vnd.pg.format">>) ->
    [<<"str">>];
to_extensions(<<"application/vnd.pg.osasli">>) ->
    [<<"ei6">>];
to_extensions(<<"application/vnd.picsel">>) ->
    [<<"efif">>];
to_extensions(<<"application/vnd.pmi.widget">>) ->
    [<<"wg">>];
to_extensions(<<"application/vnd.pocketlearn">>) ->
    [<<"plf">>];
to_extensions(<<"application/vnd.powerbuilder6">>) ->
    [<<"pbd">>];
to_extensions(<<"application/vnd.previewsystems.box">>) ->
    [<<"box">>];
to_extensions(<<"application/vnd.proteus.magazine">>) ->
    [<<"mgz">>];
to_extensions(<<"application/vnd.publishare-delta-tree">>) ->
    [<<"qps">>];
to_extensions(<<"application/vnd.pvi.ptid1">>) ->
    [<<"ptid">>];
to_extensions(<<"application/vnd.quark.quarkxpress">>) ->
    [<<"qxd">>, <<"qxt">>, <<"qwd">>, <<"qwt">>, <<"qxl">>, <<"qxb">>];
to_extensions(<<"application/vnd.realvnc.bed">>) ->
    [<<"bed">>];
to_extensions(<<"application/vnd.recordare.musicxml">>) ->
    [<<"mxl">>];
to_extensions(<<"application/vnd.recordare.musicxml+xml">>) ->
    [<<"musicxml">>];
to_extensions(<<"application/vnd.rig.cryptonote">>) ->
    [<<"cryptonote">>];
to_extensions(<<"application/vnd.rim.cod">>) ->
    [<<"cod">>];
to_extensions(<<"application/vnd.rn-realmedia">>) ->
    [<<"rm">>];
to_extensions(<<"application/vnd.rn-realmedia-vbr">>) ->
    [<<"rmvb">>];
to_extensions(<<"application/vnd.route66.link66+xml">>) ->
    [<<"link66">>];
to_extensions(<<"application/vnd.sailingtracker.track">>) ->
    [<<"st">>];
to_extensions(<<"application/vnd.seemail">>) ->
    [<<"see">>];
to_extensions(<<"application/vnd.sema">>) ->
    [<<"sema">>];
to_extensions(<<"application/vnd.semd">>) ->
    [<<"semd">>];
to_extensions(<<"application/vnd.semf">>) ->
    [<<"semf">>];
to_extensions(<<"application/vnd.shana.informed.formdata">>) ->
    [<<"ifm">>];
to_extensions(<<"application/vnd.shana.informed.formtemplate">>) ->
    [<<"itp">>];
to_extensions(<<"application/vnd.shana.informed.interchange">>) ->
    [<<"iif">>];
to_extensions(<<"application/vnd.shana.informed.package">>) ->
    [<<"ipk">>];
to_extensions(<<"application/vnd.simtech-mindmapper">>) ->
    [<<"twd">>, <<"twds">>];
to_extensions(<<"application/vnd.smaf">>) ->
    [<<"mmf">>];
to_extensions(<<"application/vnd.smart.teacher">>) ->
    [<<"teacher">>];
to_extensions(<<"application/vnd.solent.sdkm+xml">>) ->
    [<<"sdkm">>, <<"sdkd">>];
to_extensions(<<"application/vnd.spotfire.dxp">>) ->
    [<<"dxp">>];
to_extensions(<<"application/vnd.spotfire.sfs">>) ->
    [<<"sfs">>];
to_extensions(<<"application/vnd.stardivision.calc">>) ->
    [<<"sdc">>];
to_extensions(<<"application/vnd.stardivision.draw">>) ->
    [<<"sda">>];
to_extensions(<<"application/vnd.stardivision.impress">>) ->
    [<<"sdd">>];
to_extensions(<<"application/vnd.stardivision.math">>) ->
    [<<"smf">>];
to_extensions(<<"application/vnd.stardivision.writer-global">>) ->
    [<<"sgl">>];
to_extensions(<<"application/vnd.stardivision.writer">>) ->
    [<<"sdw">>, <<"vor">>];
to_extensions(<<"application/vnd.stepmania.package">>) ->
    [<<"smzip">>];
to_extensions(<<"application/vnd.stepmania.stepchart">>) ->
    [<<"sm">>];
to_extensions(<<"application/vnd.sun.xml.calc">>) ->
    [<<"sxc">>];
to_extensions(<<"application/vnd.sun.xml.calc.template">>) ->
    [<<"stc">>];
to_extensions(<<"application/vnd.sun.xml.draw">>) ->
    [<<"sxd">>];
to_extensions(<<"application/vnd.sun.xml.draw.template">>) ->
    [<<"std">>];
to_extensions(<<"application/vnd.sun.xml.impress">>) ->
    [<<"sxi">>];
to_extensions(<<"application/vnd.sun.xml.impress.template">>) ->
    [<<"sti">>];
to_extensions(<<"application/vnd.sun.xml.math">>) ->
    [<<"sxm">>];
to_extensions(<<"application/vnd.sun.xml.writer.global">>) ->
    [<<"sxg">>];
to_extensions(<<"application/vnd.sun.xml.writer">>) ->
    [<<"sxw">>];
to_extensions(<<"application/vnd.sun.xml.writer.template">>) ->
    [<<"stw">>];
to_extensions(<<"application/vnd.sus-calendar">>) ->
    [<<"sus">>, <<"susp">>];
to_extensions(<<"application/vnd.svd">>) ->
    [<<"svd">>];
to_extensions(<<"application/vnd.symbian.install">>) ->
    [<<"sis">>, <<"sisx">>];
to_extensions(<<"application/vnd.syncml.dm+wbxml">>) ->
    [<<"bdm">>];
to_extensions(<<"application/vnd.syncml.dm+xml">>) ->
    [<<"xdm">>];
to_extensions(<<"application/vnd.syncml+xml">>) ->
    [<<"xsm">>];
to_extensions(<<"application/vnd.tao.intent-module-archive">>) ->
    [<<"tao">>];
to_extensions(<<"application/vnd.tcpdump.pcap">>) ->
    [<<"pcap">>, <<"cap">>, <<"dmp">>];
to_extensions(<<"application/vnd.tmobile-livetv">>) ->
    [<<"tmo">>];
to_extensions(<<"application/vnd.trid.tpt">>) ->
    [<<"tpt">>];
to_extensions(<<"application/vnd.triscape.mxs">>) ->
    [<<"mxs">>];
to_extensions(<<"application/vnd.trueapp">>) ->
    [<<"tra">>];
to_extensions(<<"application/vnd.ufdl">>) ->
    [<<"ufd">>, <<"ufdl">>];
to_extensions(<<"application/vnd.uiq.theme">>) ->
    [<<"utz">>];
to_extensions(<<"application/vnd.umajin">>) ->
    [<<"umj">>];
to_extensions(<<"application/vnd.unity">>) ->
    [<<"unityweb">>];
to_extensions(<<"application/vnd.uoml+xml">>) ->
    [<<"uoml">>];
to_extensions(<<"application/vnd.vcx">>) ->
    [<<"vcx">>];
to_extensions(<<"application/vnd.visionary">>) ->
    [<<"vis">>];
to_extensions(<<"application/vnd.visio">>) ->
    [<<"vsd">>, <<"vst">>, <<"vss">>, <<"vsw">>];
to_extensions(<<"application/vnd.vsf">>) ->
    [<<"vsf">>];
to_extensions(<<"application/vnd.wap.wbxml">>) ->
    [<<"wbxml">>];
to_extensions(<<"application/vnd.wap.wmlc">>) ->
    [<<"wmlc">>];
to_extensions(<<"application/vnd.wap.wmlscriptc">>) ->
    [<<"wmlsc">>];
to_extensions(<<"application/vnd.webturbo">>) ->
    [<<"wtb">>];
to_extensions(<<"application/vnd.wolfram.player">>) ->
    [<<"nbp">>];
to_extensions(<<"application/vnd.wordperfect">>) ->
    [<<"wpd">>];
to_extensions(<<"application/vnd.wqd">>) ->
    [<<"wqd">>];
to_extensions(<<"application/vnd.wt.stf">>) ->
    [<<"stf">>];
to_extensions(<<"application/vnd.xara">>) ->
    [<<"xar">>];
to_extensions(<<"application/vnd.xfdl">>) ->
    [<<"xfdl">>];
to_extensions(<<"application/vnd.yamaha.hv-dic">>) ->
    [<<"hvd">>];
to_extensions(<<"application/vnd.yamaha.hv-script">>) ->
    [<<"hvs">>];
to_extensions(<<"application/vnd.yamaha.hv-voice">>) ->
    [<<"hvp">>];
to_extensions(<<"application/vnd.yamaha.openscoreformat">>) ->
    [<<"osf">>];
to_extensions(<<"application/vnd.yamaha.openscoreformat.osfpvg+xml">>) ->
    [<<"osfpvg">>];
to_extensions(<<"application/vnd.yamaha.smaf-audio">>) ->
    [<<"saf">>];
to_extensions(<<"application/vnd.yamaha.smaf-phrase">>) ->
    [<<"spf">>];
to_extensions(<<"application/vnd.yellowriver-custom-menu">>) ->
    [<<"cmp">>];
to_extensions(<<"application/vnd.zul">>) ->
    [<<"zir">>, <<"zirz">>];
to_extensions(<<"application/vnd.zzazz.deck+xml">>) ->
    [<<"zaz">>];
to_extensions(<<"application/voicexml+xml">>) ->
    [<<"vxml">>];
to_extensions(<<"application/wasm">>) ->
    [<<"wasm">>];
to_extensions(<<"application/widget">>) ->
    [<<"wgt">>];
to_extensions(<<"application/winhlp">>) ->
    [<<"hlp">>];
to_extensions(<<"application/wsdl+xml">>) ->
    [<<"wsdl">>];
to_extensions(<<"application/wspolicy+xml">>) ->
    [<<"wspolicy">>];
to_extensions(<<"application/x-7z-compressed">>) ->
    [<<"7z">>];
to_extensions(<<"application/x-abiword">>) ->
    [<<"abw">>];
to_extensions(<<"application/x-ace-compressed">>) ->
    [<<"ace">>];
to_extensions(<<"application/xaml+xml">>) ->
    [<<"xaml">>];
to_extensions(<<"application/x-apple-diskimage">>) ->
    [<<"dmg">>];
to_extensions(<<"application/x-authorware-bin">>) ->
    [<<"aab">>, <<"x32">>, <<"u32">>, <<"vox">>];
to_extensions(<<"application/x-authorware-map">>) ->
    [<<"aam">>];
to_extensions(<<"application/x-authorware-seg">>) ->
    [<<"aas">>];
to_extensions(<<"application/x-bcpio">>) ->
    [<<"bcpio">>];
to_extensions(<<"application/x-bittorrent">>) ->
    [<<"torrent">>];
to_extensions(<<"application/x-blorb">>) ->
    [<<"blb">>, <<"blorb">>];
to_extensions(<<"application/x-bzip2">>) ->
    [<<"bz2">>, <<"boz">>];
to_extensions(<<"application/x-bzip">>) ->
    [<<"bz">>];
to_extensions(<<"application/xcap-diff+xml">>) ->
    [<<"xdf">>];
to_extensions(<<"application/x-cbr">>) ->
    [<<"cbr">>, <<"cba">>, <<"cbt">>, <<"cbz">>, <<"cb7">>];
to_extensions(<<"application/x-cdlink">>) ->
    [<<"vcd">>];
to_extensions(<<"application/x-cfs-compressed">>) ->
    [<<"cfs">>];
to_extensions(<<"application/x-chat">>) ->
    [<<"chat">>];
to_extensions(<<"application/x-chess-pgn">>) ->
    [<<"pgn">>];
to_extensions(<<"application/x-conference">>) ->
    [<<"nsc">>];
to_extensions(<<"application/x-cpio">>) ->
    [<<"cpio">>];
to_extensions(<<"application/x-csh">>) ->
    [<<"csh">>];
to_extensions(<<"application/x-debian-package">>) ->
    [<<"deb">>, <<"udeb">>];
to_extensions(<<"application/x-dgc-compressed">>) ->
    [<<"dgc">>];
to_extensions(<<"application/x-director">>) ->
    [
        <<"dir">>,
        <<"dcr">>,
        <<"dxr">>,
        <<"cst">>,
        <<"cct">>,
        <<"cxt">>,
        <<"w3d">>,
        <<"fgd">>,
        <<"swa">>
    ];
to_extensions(<<"application/x-doom">>) ->
    [<<"wad">>];
to_extensions(<<"application/x-dtbncx+xml">>) ->
    [<<"ncx">>];
to_extensions(<<"application/x-dtbook+xml">>) ->
    [<<"dtb">>];
to_extensions(<<"application/x-dtbresource+xml">>) ->
    [<<"res">>];
to_extensions(<<"application/x-dvi">>) ->
    [<<"dvi">>];
to_extensions(<<"application/xenc+xml">>) ->
    [<<"xenc">>];
to_extensions(<<"application/x-envoy">>) ->
    [<<"evy">>];
to_extensions(<<"application/x-eva">>) ->
    [<<"eva">>];
to_extensions(<<"application/x-font-bdf">>) ->
    [<<"bdf">>];
to_extensions(<<"application/x-font-ghostscript">>) ->
    [<<"gsf">>];
to_extensions(<<"application/x-font-linux-psf">>) ->
    [<<"psf">>];
to_extensions(<<"application/x-font-pcf">>) ->
    [<<"pcf">>];
to_extensions(<<"application/x-font-snf">>) ->
    [<<"snf">>];
to_extensions(<<"application/x-font-type1">>) ->
    [<<"pfa">>, <<"pfb">>, <<"pfm">>, <<"afm">>];
to_extensions(<<"application/x-freearc">>) ->
    [<<"arc">>];
to_extensions(<<"application/x-futuresplash">>) ->
    [<<"spl">>];
to_extensions(<<"application/x-gca-compressed">>) ->
    [<<"gca">>];
to_extensions(<<"application/x-glulx">>) ->
    [<<"ulx">>];
to_extensions(<<"application/x-gnumeric">>) ->
    [<<"gnumeric">>];
to_extensions(<<"application/x-gramps-xml">>) ->
    [<<"gramps">>];
to_extensions(<<"application/x-gtar">>) ->
    [<<"gtar">>];
to_extensions(<<"application/x-hdf">>) ->
    [<<"hdf">>];
to_extensions(<<"application/xhtml+xml">>) ->
    [<<"xhtml">>, <<"xht">>];
to_extensions(<<"application/x-install-instructions">>) ->
    [<<"install">>];
to_extensions(<<"application/x-iso9660-image">>) ->
    [<<"iso">>];
to_extensions(<<"application/x-java-jnlp-file">>) ->
    [<<"jnlp">>];
to_extensions(<<"application/x-latex">>) ->
    [<<"latex">>];
to_extensions(<<"application/x-lzh-compressed">>) ->
    [<<"lzh">>, <<"lha">>];
to_extensions(<<"application/x-mie">>) ->
    [<<"mie">>];
to_extensions(<<"application/xml-dtd">>) ->
    [<<"dtd">>];
to_extensions(<<"application/xml">>) ->
    [<<"xml">>, <<"xsl">>];
to_extensions(<<"application/x-mobipocket-ebook">>) ->
    [<<"prc">>, <<"mobi">>];
to_extensions(<<"application/x-msaccess">>) ->
    [<<"mdb">>];
to_extensions(<<"application/x-ms-application">>) ->
    [<<"application">>];
to_extensions(<<"application/x-msbinder">>) ->
    [<<"obd">>];
to_extensions(<<"application/x-mscardfile">>) ->
    [<<"crd">>];
to_extensions(<<"application/x-msclip">>) ->
    [<<"clp">>];
to_extensions(<<"application/x-msdownload">>) ->
    [<<"exe">>, <<"dll">>, <<"com">>, <<"bat">>, <<"msi">>];
to_extensions(<<"application/x-msmediaview">>) ->
    [<<"mvb">>, <<"m13">>, <<"m14">>];
to_extensions(<<"application/x-msmetafile">>) ->
    [<<"wmf">>, <<"wmz">>, <<"emf">>, <<"emz">>];
to_extensions(<<"application/x-msmoney">>) ->
    [<<"mny">>];
to_extensions(<<"application/x-mspublisher">>) ->
    [<<"pub">>];
to_extensions(<<"application/x-msschedule">>) ->
    [<<"scd">>];
to_extensions(<<"application/x-ms-shortcut">>) ->
    [<<"lnk">>];
to_extensions(<<"application/x-msterminal">>) ->
    [<<"trm">>];
to_extensions(<<"application/x-ms-wmd">>) ->
    [<<"wmd">>];
to_extensions(<<"application/x-ms-wmz">>) ->
    [<<"wmz">>];
to_extensions(<<"application/x-mswrite">>) ->
    [<<"wri">>];
to_extensions(<<"application/x-ms-xbap">>) ->
    [<<"xbap">>];
to_extensions(<<"application/x-netcdf">>) ->
    [<<"nc">>, <<"cdf">>];
to_extensions(<<"application/x-nzb">>) ->
    [<<"nzb">>];
to_extensions(<<"application/xop+xml">>) ->
    [<<"xop">>];
to_extensions(<<"application/x-pkcs12">>) ->
    [<<"p12">>, <<"pfx">>];
to_extensions(<<"application/x-pkcs7-certificates">>) ->
    [<<"p7b">>, <<"spc">>];
to_extensions(<<"application/x-pkcs7-certreqresp">>) ->
    [<<"p7r">>];
to_extensions(<<"application/xproc+xml">>) ->
    [<<"xpl">>];
to_extensions(<<"application/x-rar-compressed">>) ->
    [<<"rar">>];
to_extensions(<<"application/x-research-info-systems">>) ->
    [<<"ris">>];
to_extensions(<<"application/x-shar">>) ->
    [<<"shar">>];
to_extensions(<<"application/x-shockwave-flash">>) ->
    [<<"swf">>];
to_extensions(<<"application/x-sh">>) ->
    [<<"sh">>];
to_extensions(<<"application/x-silverlight-app">>) ->
    [<<"xap">>];
to_extensions(<<"application/xslt+xml">>) ->
    [<<"xslt">>];
to_extensions(<<"application/xspf+xml">>) ->
    [<<"xspf">>];
to_extensions(<<"application/x-sql">>) ->
    [<<"sql">>];
to_extensions(<<"application/x-stuffit">>) ->
    [<<"sit">>];
to_extensions(<<"application/x-stuffitx">>) ->
    [<<"sitx">>];
to_extensions(<<"application/x-subrip">>) ->
    [<<"srt">>];
to_extensions(<<"application/x-sv4cpio">>) ->
    [<<"sv4cpio">>];
to_extensions(<<"application/x-sv4crc">>) ->
    [<<"sv4crc">>];
to_extensions(<<"application/x-t3vm-image">>) ->
    [<<"t3">>];
to_extensions(<<"application/x-tads">>) ->
    [<<"gam">>];
to_extensions(<<"application/x-tar">>) ->
    [<<"tar">>];
to_extensions(<<"application/x-tcl">>) ->
    [<<"tcl">>];
to_extensions(<<"application/x-texinfo">>) ->
    [<<"texinfo">>, <<"texi">>];
to_extensions(<<"application/x-tex">>) ->
    [<<"tex">>];
to_extensions(<<"application/x-tex-tfm">>) ->
    [<<"tfm">>];
to_extensions(<<"application/x-tgif">>) ->
    [<<"obj">>];
to_extensions(<<"application/x-ustar">>) ->
    [<<"ustar">>];
to_extensions(<<"application/xv+xml">>) ->
    [<<"mxml">>, <<"xhvml">>, <<"xvml">>, <<"xvm">>];
to_extensions(<<"application/x-wais-source">>) ->
    [<<"src">>];
to_extensions(<<"application/x-x509-ca-cert">>) ->
    [<<"der">>, <<"crt">>];
to_extensions(<<"application/x-xfig">>) ->
    [<<"fig">>];
to_extensions(<<"application/x-xliff+xml">>) ->
    [<<"xlf">>];
to_extensions(<<"application/x-xpinstall">>) ->
    [<<"xpi">>];
to_extensions(<<"application/x-xz">>) ->
    [<<"xz">>];
to_extensions(<<"application/x-zmachine">>) ->
    [<<"z1">>, <<"z2">>, <<"z3">>, <<"z4">>, <<"z5">>, <<"z6">>, <<"z7">>, <<"z8">>];
to_extensions(<<"application/yang">>) ->
    [<<"yang">>];
to_extensions(<<"application/yin+xml">>) ->
    [<<"yin">>];
to_extensions(<<"application/zip">>) ->
    [<<"zip">>];
to_extensions(<<"audio/adpcm">>) ->
    [<<"adp">>];
to_extensions(<<"audio/basic">>) ->
    [<<"au">>, <<"snd">>];
to_extensions(<<"audio/midi">>) ->
    [<<"mid">>, <<"midi">>, <<"kar">>, <<"rmi">>];
to_extensions(<<"audio/mp4">>) ->
    [<<"m4a">>, <<"mp4a">>];
to_extensions(<<"audio/mpeg">>) ->
    [<<"mp3">>, <<"mpga">>, <<"mp2">>, <<"mp2a">>, <<"m2a">>, <<"m3a">>];
to_extensions(<<"audio/ogg">>) ->
    [<<"oga">>, <<"ogg">>, <<"spx">>, <<"opus">>];
to_extensions(<<"audio/s3m">>) ->
    [<<"s3m">>];
to_extensions(<<"audio/silk">>) ->
    [<<"sil">>];
to_extensions(<<"audio/vnd.dece.audio">>) ->
    [<<"uva">>, <<"uvva">>];
to_extensions(<<"audio/vnd.digital-winds">>) ->
    [<<"eol">>];
to_extensions(<<"audio/vnd.dra">>) ->
    [<<"dra">>];
to_extensions(<<"audio/vnd.dts">>) ->
    [<<"dts">>];
to_extensions(<<"audio/vnd.dts.hd">>) ->
    [<<"dtshd">>];
to_extensions(<<"audio/vnd.lucent.voice">>) ->
    [<<"lvp">>];
to_extensions(<<"audio/vnd.ms-playready.media.pya">>) ->
    [<<"pya">>];
to_extensions(<<"audio/vnd.nuera.ecelp4800">>) ->
    [<<"ecelp4800">>];
to_extensions(<<"audio/vnd.nuera.ecelp7470">>) ->
    [<<"ecelp7470">>];
to_extensions(<<"audio/vnd.nuera.ecelp9600">>) ->
    [<<"ecelp9600">>];
to_extensions(<<"audio/vnd.rip">>) ->
    [<<"rip">>];
to_extensions(<<"audio/webm">>) ->
    [<<"weba">>];
to_extensions(<<"audio/x-aac">>) ->
    [<<"aac">>];
to_extensions(<<"audio/x-aiff">>) ->
    [<<"aif">>, <<"aiff">>, <<"aifc">>];
to_extensions(<<"audio/x-caf">>) ->
    [<<"caf">>];
to_extensions(<<"audio/x-flac">>) ->
    [<<"flac">>];
to_extensions(<<"audio/x-matroska">>) ->
    [<<"mka">>];
to_extensions(<<"audio/x-mpegurl">>) ->
    [<<"m3u">>];
to_extensions(<<"audio/x-ms-wax">>) ->
    [<<"wax">>];
to_extensions(<<"audio/x-ms-wma">>) ->
    [<<"wma">>];
to_extensions(<<"audio/xm">>) ->
    [<<"xm">>];
to_extensions(<<"audio/x-pn-realaudio-plugin">>) ->
    [<<"rmp">>];
to_extensions(<<"audio/x-pn-realaudio">>) ->
    [<<"ram">>, <<"ra">>];
to_extensions(<<"audio/x-wav">>) ->
    [<<"wav">>];
to_extensions(<<"chemical/x-cdx">>) ->
    [<<"cdx">>];
to_extensions(<<"chemical/x-cif">>) ->
    [<<"cif">>];
to_extensions(<<"chemical/x-cmdf">>) ->
    [<<"cmdf">>];
to_extensions(<<"chemical/x-cml">>) ->
    [<<"cml">>];
to_extensions(<<"chemical/x-csml">>) ->
    [<<"csml">>];
to_extensions(<<"chemical/x-xyz">>) ->
    [<<"xyz">>];
to_extensions(<<"font/collection">>) ->
    [<<"ttc">>];
to_extensions(<<"font/otf">>) ->
    [<<"otf">>];
to_extensions(<<"font/ttf">>) ->
    [<<"ttf">>];
to_extensions(<<"font/woff2">>) ->
    [<<"woff2">>];
to_extensions(<<"font/woff">>) ->
    [<<"woff">>];
to_extensions(<<"image/avif">>) ->
    [<<"avif">>];
to_extensions(<<"image/bmp">>) ->
    [<<"bmp">>];
to_extensions(<<"image/cgm">>) ->
    [<<"cgm">>];
to_extensions(<<"image/g3fax">>) ->
    [<<"g3">>];
to_extensions(<<"image/gif">>) ->
    [<<"gif">>];
to_extensions(<<"image/ief">>) ->
    [<<"ief">>];
to_extensions(<<"image/jpeg">>) ->
    [<<"jpeg">>, <<"jpg">>, <<"jpe">>];
to_extensions(<<"image/ktx">>) ->
    [<<"ktx">>];
to_extensions(<<"image/png">>) ->
    [<<"png">>];
to_extensions(<<"image/prs.btif">>) ->
    [<<"btif">>];
to_extensions(<<"image/sgi">>) ->
    [<<"sgi">>];
to_extensions(<<"image/svg+xml">>) ->
    [<<"svg">>, <<"svgz">>];
to_extensions(<<"image/tiff">>) ->
    [<<"tiff">>, <<"tif">>];
to_extensions(<<"image/vnd.adobe.photoshop">>) ->
    [<<"psd">>];
to_extensions(<<"image/vnd.dece.graphic">>) ->
    [<<"uvi">>, <<"uvvi">>, <<"uvg">>, <<"uvvg">>];
to_extensions(<<"image/vnd.djvu">>) ->
    [<<"djvu">>, <<"djv">>];
to_extensions(<<"image/vnd.dvb.subtitle">>) ->
    [<<"sub">>];
to_extensions(<<"image/vnd.dwg">>) ->
    [<<"dwg">>];
to_extensions(<<"image/vnd.dxf">>) ->
    [<<"dxf">>];
to_extensions(<<"image/vnd.fastbidsheet">>) ->
    [<<"fbs">>];
to_extensions(<<"image/vnd.fpx">>) ->
    [<<"fpx">>];
to_extensions(<<"image/vnd.fst">>) ->
    [<<"fst">>];
to_extensions(<<"image/vnd.fujixerox.edmics-mmr">>) ->
    [<<"mmr">>];
to_extensions(<<"image/vnd.fujixerox.edmics-rlc">>) ->
    [<<"rlc">>];
to_extensions(<<"image/vnd.ms-modi">>) ->
    [<<"mdi">>];
to_extensions(<<"image/vnd.ms-photo">>) ->
    [<<"wdp">>];
to_extensions(<<"image/vnd.net-fpx">>) ->
    [<<"npx">>];
to_extensions(<<"image/vnd.wap.wbmp">>) ->
    [<<"wbmp">>];
to_extensions(<<"image/vnd.xiff">>) ->
    [<<"xif">>];
to_extensions(<<"image/webp">>) ->
    [<<"webp">>];
to_extensions(<<"image/x-3ds">>) ->
    [<<"3ds">>];
to_extensions(<<"image/x-cmu-raster">>) ->
    [<<"ras">>];
to_extensions(<<"image/x-cmx">>) ->
    [<<"cmx">>];
to_extensions(<<"image/x-freehand">>) ->
    [<<"fh">>, <<"fhc">>, <<"fh4">>, <<"fh5">>, <<"fh7">>];
to_extensions(<<"image/x-icon">>) ->
    [<<"ico">>];
to_extensions(<<"image/x-mrsid-image">>) ->
    [<<"sid">>];
to_extensions(<<"image/x-pcx">>) ->
    [<<"pcx">>];
to_extensions(<<"image/x-pict">>) ->
    [<<"pic">>, <<"pct">>];
to_extensions(<<"image/x-portable-anymap">>) ->
    [<<"pnm">>];
to_extensions(<<"image/x-portable-bitmap">>) ->
    [<<"pbm">>];
to_extensions(<<"image/x-portable-graymap">>) ->
    [<<"pgm">>];
to_extensions(<<"image/x-portable-pixmap">>) ->
    [<<"ppm">>];
to_extensions(<<"image/x-rgb">>) ->
    [<<"rgb">>];
to_extensions(<<"image/x-tga">>) ->
    [<<"tga">>];
to_extensions(<<"image/x-xbitmap">>) ->
    [<<"xbm">>];
to_extensions(<<"image/x-xpixmap">>) ->
    [<<"xpm">>];
to_extensions(<<"image/x-xwindowdump">>) ->
    [<<"xwd">>];
to_extensions(<<"message/rfc822">>) ->
    [<<"eml">>, <<"mime">>];
to_extensions(<<"model/iges">>) ->
    [<<"igs">>, <<"iges">>];
to_extensions(<<"model/mesh">>) ->
    [<<"msh">>, <<"mesh">>, <<"silo">>];
to_extensions(<<"model/vnd.collada+xml">>) ->
    [<<"dae">>];
to_extensions(<<"model/vnd.dwf">>) ->
    [<<"dwf">>];
to_extensions(<<"model/vnd.gdl">>) ->
    [<<"gdl">>];
to_extensions(<<"model/vnd.gtw">>) ->
    [<<"gtw">>];
to_extensions(<<"model/vnd.vtu">>) ->
    [<<"vtu">>];
to_extensions(<<"model/vrml">>) ->
    [<<"wrl">>, <<"vrml">>];
to_extensions(<<"model/x3d+binary">>) ->
    [<<"x3db">>, <<"x3dbz">>];
to_extensions(<<"model/x3d+vrml">>) ->
    [<<"x3dv">>, <<"x3dvz">>];
to_extensions(<<"model/x3d+xml">>) ->
    [<<"x3d">>, <<"x3dz">>];
to_extensions(<<"text/cache-manifest">>) ->
    [<<"appcache">>];
to_extensions(<<"text/calendar">>) ->
    [<<"ics">>, <<"ifb">>];
to_extensions(<<"text/css">>) ->
    [<<"css">>];
to_extensions(<<"text/csv">>) ->
    [<<"csv">>];
to_extensions(<<"text/html">>) ->
    [<<"html">>, <<"htm">>];
to_extensions(<<"text/javascript">>) ->
    [<<"js">>, <<"mjs">>];
to_extensions(<<"text/n3">>) ->
    [<<"n3">>];
to_extensions(<<"text/plain">>) ->
    [<<"txt">>, <<"text">>, <<"conf">>, <<"def">>, <<"list">>, <<"log">>, <<"in">>];
to_extensions(<<"text/prs.lines.tag">>) ->
    [<<"dsc">>];
to_extensions(<<"text/richtext">>) ->
    [<<"rtx">>];
to_extensions(<<"text/sgml">>) ->
    [<<"sgml">>, <<"sgm">>];
to_extensions(<<"text/tab-separated-values">>) ->
    [<<"tsv">>];
to_extensions(<<"text/troff">>) ->
    [<<"t">>, <<"tr">>, <<"roff">>, <<"man">>, <<"me">>, <<"ms">>];
to_extensions(<<"text/turtle">>) ->
    [<<"ttl">>];
to_extensions(<<"text/uri-list">>) ->
    [<<"uri">>, <<"uris">>, <<"urls">>];
to_extensions(<<"text/vcard">>) ->
    [<<"vcard">>];
to_extensions(<<"text/vnd.curl">>) ->
    [<<"curl">>];
to_extensions(<<"text/vnd.curl.dcurl">>) ->
    [<<"dcurl">>];
to_extensions(<<"text/vnd.curl.mcurl">>) ->
    [<<"mcurl">>];
to_extensions(<<"text/vnd.curl.scurl">>) ->
    [<<"scurl">>];
to_extensions(<<"text/vnd.dvb.subtitle">>) ->
    [<<"sub">>];
to_extensions(<<"text/vnd.fly">>) ->
    [<<"fly">>];
to_extensions(<<"text/vnd.fmi.flexstor">>) ->
    [<<"flx">>];
to_extensions(<<"text/vnd.graphviz">>) ->
    [<<"gv">>];
to_extensions(<<"text/vnd.in3d.3dml">>) ->
    [<<"3dml">>];
to_extensions(<<"text/vnd.in3d.spot">>) ->
    [<<"spot">>];
to_extensions(<<"text/vnd.sun.j2me.app-descriptor">>) ->
    [<<"jad">>];
to_extensions(<<"text/vnd.wap.wmlscript">>) ->
    [<<"wmls">>];
to_extensions(<<"text/vnd.wap.wml">>) ->
    [<<"wml">>];
to_extensions(<<"text/x-asm">>) ->
    [<<"s">>, <<"asm">>];
to_extensions(<<"text/x-c">>) ->
    [<<"c">>, <<"cc">>, <<"cxx">>, <<"cpp">>, <<"h">>, <<"hh">>, <<"dic">>];
to_extensions(<<"text/x-fortran">>) ->
    [<<"f">>, <<"for">>, <<"f77">>, <<"f90">>];
to_extensions(<<"text/x-java-source">>) ->
    [<<"java">>];
to_extensions(<<"text/x-nfo">>) ->
    [<<"nfo">>];
to_extensions(<<"text/x-opml">>) ->
    [<<"opml">>];
to_extensions(<<"text/x-pascal">>) ->
    [<<"p">>, <<"pas">>];
to_extensions(<<"text/x-setext">>) ->
    [<<"etx">>];
to_extensions(<<"text/x-sfv">>) ->
    [<<"sfv">>];
to_extensions(<<"text/x-uuencode">>) ->
    [<<"uu">>];
to_extensions(<<"text/x-vcalendar">>) ->
    [<<"vcs">>];
to_extensions(<<"text/x-vcard">>) ->
    [<<"vcf">>];
to_extensions(<<"video/3gpp2">>) ->
    [<<"3g2">>];
to_extensions(<<"video/3gpp">>) ->
    [<<"3gp">>];
to_extensions(<<"video/h261">>) ->
    [<<"h261">>];
to_extensions(<<"video/h263">>) ->
    [<<"h263">>];
to_extensions(<<"video/h264">>) ->
    [<<"h264">>];
to_extensions(<<"video/jpeg">>) ->
    [<<"jpgv">>];
to_extensions(<<"video/jpm">>) ->
    [<<"jpm">>, <<"jpgm">>];
to_extensions(<<"video/mj2">>) ->
    [<<"mj2">>, <<"mjp2">>];
to_extensions(<<"video/mp2t">>) ->
    [<<"ts">>, <<"m2t">>, <<"m2ts">>, <<"mts">>];
to_extensions(<<"video/mp4">>) ->
    [<<"mp4">>, <<"mp4v">>, <<"mpg4">>];
to_extensions(<<"video/mpeg">>) ->
    [<<"mpeg">>, <<"mpg">>, <<"mpe">>, <<"m1v">>, <<"m2v">>];
to_extensions(<<"video/ogg">>) ->
    [<<"ogv">>];
to_extensions(<<"video/quicktime">>) ->
    [<<"qt">>, <<"mov">>];
to_extensions(<<"video/vnd.dece.hd">>) ->
    [<<"uvh">>, <<"uvvh">>];
to_extensions(<<"video/vnd.dece.mobile">>) ->
    [<<"uvm">>, <<"uvvm">>];
to_extensions(<<"video/vnd.dece.pd">>) ->
    [<<"uvp">>, <<"uvvp">>];
to_extensions(<<"video/vnd.dece.sd">>) ->
    [<<"uvs">>, <<"uvvs">>];
to_extensions(<<"video/vnd.dece.video">>) ->
    [<<"uvv">>, <<"uvvv">>];
to_extensions(<<"video/vnd.dvb.file">>) ->
    [<<"dvb">>];
to_extensions(<<"video/vnd.fvt">>) ->
    [<<"fvt">>];
to_extensions(<<"video/vnd.mpegurl">>) ->
    [<<"mxu">>, <<"m4u">>];
to_extensions(<<"video/vnd.ms-playready.media.pyv">>) ->
    [<<"pyv">>];
to_extensions(<<"video/vnd.uvvu.mp4">>) ->
    [<<"uvu">>, <<"uvvu">>];
to_extensions(<<"video/vnd.vivo">>) ->
    [<<"viv">>];
to_extensions(<<"video/webm">>) ->
    [<<"webm">>];
to_extensions(<<"video/x-f4v">>) ->
    [<<"f4v">>];
to_extensions(<<"video/x-fli">>) ->
    [<<"fli">>];
to_extensions(<<"video/x-flv">>) ->
    [<<"flv">>];
to_extensions(<<"video/x-m4v">>) ->
    [<<"m4v">>];
to_extensions(<<"video/x-matroska">>) ->
    [<<"mkv">>, <<"mk3d">>, <<"mks">>];
to_extensions(<<"video/x-mng">>) ->
    [<<"mng">>];
to_extensions(<<"video/x-ms-asf">>) ->
    [<<"asf">>, <<"asx">>];
to_extensions(<<"video/x-msvideo">>) ->
    [<<"avi">>];
to_extensions(<<"video/x-ms-vob">>) ->
    [<<"vob">>];
to_extensions(<<"video/x-ms-wmv">>) ->
    [<<"wmv">>];
to_extensions(<<"video/x-ms-wm">>) ->
    [<<"wm">>];
to_extensions(<<"video/x-ms-wmx">>) ->
    [<<"wmx">>];
to_extensions(<<"video/x-ms-wvx">>) ->
    [<<"wvx">>];
to_extensions(<<"video/x-sgi-movie">>) ->
    [<<"movie">>];
to_extensions(<<"video/x-smv">>) ->
    [<<"smv">>];
to_extensions(<<"x-conference/x-cooltalk">>) ->
    [<<"ice">>];
to_extensions(_) ->
    [<<>>].
%% GENERATED
