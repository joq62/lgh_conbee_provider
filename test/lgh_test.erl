%%% -------------------------------------------------------------------
%%% @author  : Joq Erlang
%%% @doc: : 
%%% Created :
%%% Node end point  
%%% Creates and deletes Pods
%%% 
%%% API-kube: Interface 
%%% Pod consits beams from all services, app and app and sup erl.
%%% The setup of envs is
%%% -------------------------------------------------------------------
-module(lgh_test).       
 
-export([start/0]).
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

-define(TestHost,"c202").
-define(Cookie,a).
-define(HwConbee,a@c201).
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
start()->
   
    ok=setup(),
    ok=start_hw_conbee(),
    ok=test_1(),
   
    io:format("Test OK !!! ~p~n",[?MODULE]),
    timer:sleep(2000),
    init:stop(),
    ok.

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------
test_1()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME,?LINE}]),

    %% check if reachable
    true=rpc:call(?HwConbee,hw_conbee,get,["lamp_1",is_reachable,[]],5000),   
    true=rpc:call(?HwConbee,hw_conbee,get,["weather_1",is_reachable,[]],5000),
    true=rpc:call(?HwConbee,hw_conbee,get,["outlet_1",is_reachable,[]],5000),
    true=rpc:call(?HwConbee,hw_conbee,get,["tradfri_motion_1",is_reachable,[]],5000),
    true=rpc:call(?HwConbee,hw_conbee,get,["lumi_motion_1",is_reachable,[]],5000),
    true=rpc:call(?HwConbee,hw_conbee,get,["lumi_magnet_1",is_reachable,[]],5000),
    true=rpc:call(?HwConbee,hw_conbee,get,["lumi_motion_1",is_reachable,[]],5000),
  %  true=rpc:call(?HwConbee,hw_conbee,get,["switch_1",is_reachable,[]],5000),
 

    %% lamp_1
    rpc:call(?HwConbee,hw_conbee,set,["lamp_1",turn_on,[]],5000),
    true=rpc:call(?HwConbee,hw_conbee,get,["lamp_1",is_on,[]],5000),
    rpc:call(?HwConbee,hw_conbee,set,["lamp_1",turn_off,[]],5000),
    false=rpc:call(?HwConbee,hw_conbee,get,["lamp_1",is_on,[]],5000),
   
    %% 
    rpc:call(?HwConbee,hw_conbee,set,["outlet_1",turn_on,[]],5000),
    true=rpc:call(?HwConbee,hw_conbee,get,["outlet_1",is_on,[]],5000),
    timer:sleep(2000),
    rpc:call(?HwConbee,hw_conbee,set,["outlet_1",turn_off,[]],5000),
    false=rpc:call(?HwConbee,hw_conbee,get,["outlet_1",is_on,[]],5000),

    %%
    Temp=rpc:call(?HwConbee,hw_conbee,get,["weather_1",temperature,[]],5000),
    io:format("Temp ~p~n",[{Temp,?MODULE,?LINE}]),
    Hum=rpc:call(?HwConbee,hw_conbee,get,["weather_1",humidity,[]],5000),
    io:format("Hum ~p~n",[{Hum,?MODULE,?LINE}]),
    Press=rpc:call(?HwConbee,hw_conbee,get,["weather_1",pressure,[]],5000),
    io:format("Press ~p~n",[{Press,?MODULE,?LINE}]),


    ok.



%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
start_hw_conbee()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME,?LINE}]),
    
    StartResult=rpc:call(?HwConbee,application,start,[lgh_conbee_provider],2*5000),
    io:format("StartResult ~p~n",[{StartResult,?MODULE,?LINE}]),
    pong=rpc:call(?HwConbee,hw_conbee,ping,[],5000),
    ok.
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------


setup()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),

    %% connect to nod
%    true=erlang:set_cookie(?Cookie),
    pong=net_adm:ping(?HwConbee),
    
   

    ok.
