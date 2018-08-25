%% erlang part 1 and 2
%% creator : Giang Truong
%% date completed : 3/21/2016
%% erlang project for assignment 3 CECS 424
-module(easy).


-export([add/2, newturn/1, game_m/4, game_start/5, func_one/1, func_two/2, func_three/1, func_four/1]).
%%start of part 1
add(X, Y) ->
	if
		((X div 2 + Y div 2) rem 2) =:= 0 -> 
			trunc(X div 2 + Y div 2);
	    true -> 
			trunc(X div 2 + Y div 2 + 1)
	end.
	
newturn(Turn) ->
	Turn - 1.
%% recursive call
game_start(_,_,_,Turn,_) when Turn =:= 0 -> true;
game_start(A,B,C,_,_) when A =:= B, B =:= C -> true;
game_start(A,B,C,Turn,MyCons) ->
	io:format(" turn ~w A has ~w candy B has ~w candy C has ~w candy ~n",[1+MyCons-Turn,add(A, C),add(B, A),add(C, B)]),
	game_start(add(A, C),add(B, A),add(C, B),newturn(Turn),MyCons).

%% main
game_m(A,B,C,Turn) -> 
	MyCons = Turn,
	game_start(A,B,C,Turn,MyCons).

%% end of part 1


%% start of part 2
func_one(Filename) ->
	{ok, S} = file:open(Filename, read),
	L1 = io:get_line(S, ''),
	L2 = string:to_lower(L1),
	L3 = string:tokens(L2, " "),
	L3.

func_two(StringWord, ListofTuple) -> 
	Temptuple = lists:keyfind(StringWord, 1, ListofTuple),
	if
		%% we don't find any %%
		Temptuple =:= false -> 
			lists:append([ListofTuple, [{StringWord, 1}]]);
			%ListofTuple:append(StringWord, 1);
		%% we found it %%
		true ->
			lists:keyreplace(StringWord, 1, ListofTuple, {StringWord,element(2,Temptuple)+1})
	end.

func_three(ListofWord) ->
	ListofTuple = lists:foldl(fun(X, Sum)->func_two(X, Sum)end, [], ListofWord),
	ListofTuple.

%% file name is "C:\\Users\\SuperAdmin\\Desktop\\erproject\\assign3-part2.txt"%%
func_four(Filename) ->
	List1 = func_three(func_one(Filename)),
	SortedList = lists:sort(List1),
	SortedList.
	
%% end of part 2			
	

	