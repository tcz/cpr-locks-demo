-module(lock).

-export([connect/1, acquire/0]).

connect([PeerNode|Rest]) ->
  net_kernel:connect_node(PeerNode),
  connect(Rest);

connect([]) ->
  ok.

acquire() ->
  timer:sleep(200),
  reserve_id(1).

reserve_id(DesiredNextId) ->
  ResourceId = {test_lock_id, DesiredNextId},
  LockRequesterId = node(),
  LockAcquired = global:set_lock({ResourceId, LockRequesterId}, [node()|nodes()], 0),
  if LockAcquired ->
    io:format("Acquired lock ~p~n", [{ResourceId, LockRequesterId}]),
    erlang:spawn(fun() ->
      timer:sleep(30000),
      io:format("Releasing lock ~p~n", [{ResourceId, LockRequesterId}]),
      global:del_lock({ResourceId, LockRequesterId}, [node()|nodes()])
                 end),
    DesiredNextId;
    true ->
      io:format("Failed to acquire lock ~p~n", [{ResourceId, LockRequesterId}]),
      reserve_id(DesiredNextId + 1)
  end.