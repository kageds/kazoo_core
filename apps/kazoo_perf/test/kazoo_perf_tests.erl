-module(kazoo_perf_tests).

-include_lib("eunit/include/eunit.hrl").

metrics_test_() ->
    ?_test_begin(30000),
    {A, C, Z} = {<<"my_account">>, <<"my_cluster">>, <<"my_zone">>},
    %% We only care about if this crashes
    [
        ?_assertEqual(no_return, kazoo_perf_maintenance:graphite_metrics(A, C, Z)),
        ?_assertEqual(no_return, kazoo_perf_maintenance:json_metrics())
    ].
