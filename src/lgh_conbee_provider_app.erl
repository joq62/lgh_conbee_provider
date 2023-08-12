%%%-------------------------------------------------------------------
%% @doc lgh_conbee_provider public API
%% @end
%%%-------------------------------------------------------------------

-module(lgh_conbee_provider_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    lgh_conbee_provider_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
