-module(erlang_background_code1).
-export([start/0]).

start() -> 
    Pid = spawn(fun() -> loop() end),
    MsgData = [1, 'test1', true],
    Pid ! {type_of_msg1, self(), MsgData},
    receive
        Result -> 
            io:format("~p~n", [Result])
    end.
    
loop() -> 
    receive
        {type_of_msg1, PidS, [1, 'test1', true]} ->
            PidS ! true;
        {msg, PidS, Data} ->
            PidS ! false
    end,
    loop().