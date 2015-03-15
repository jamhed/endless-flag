-module(db).
-behaviour(application).
-behaviour(supervisor).

-export([start/0, stop/0, squery/1, equery/2]).
-export([start/2, stop/1]).
-export([init/1]).

start() ->
    application:start(?MODULE).

stop() ->
    application:stop(?MODULE).

start(_Type, _Args) ->
    supervisor:start_link({local, db_sup}, ?MODULE, []).

stop(_State) ->
    ok.

init([]) ->
    {ok, Pools} = application:get_env(db, pools),
    PoolSpecs = lists:map(
      fun({Name, SizeArgs, WorkerArgs}) ->
         PoolArgs = [{name, {local, Name}}, {worker_module, db_worker}] ++ SizeArgs,
         poolboy:child_spec(Name, PoolArgs, WorkerArgs)
      end, Pools),
    {ok, {{one_for_one, 10, 10}, PoolSpecs}}.

squery(Sql) ->
    poolboy:transaction(pool1, fun(Worker) ->
        gen_server:call(Worker, {squery, Sql})
    end).

equery(Stmt, Params) ->
    poolboy:transaction(pool1, fun(Worker) ->
        gen_server:call(Worker, {equery, Stmt, Params})
    end).
