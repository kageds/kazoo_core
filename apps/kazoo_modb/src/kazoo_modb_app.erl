-module(kazoo_modb_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    application:ensure_all_started(pgapp),
    {ok, self()}.

stop(_State) ->
    ok.

