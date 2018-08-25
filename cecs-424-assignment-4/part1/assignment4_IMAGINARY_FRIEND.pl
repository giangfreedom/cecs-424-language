% Problem #2, "imaginary friend", Dell Logic Puzzles, October 1999
% Each children travel to a diff place with an imaginary friends.
story(circus).
story(rock_band).
story(spaceship).
story(train).

little(joanne).
little(lou).
little(ralph).
little(winnie).

animal(grizzly_bear).
animal(moose).
animal(seal).
animal(zebra).

solve :-
    story(Joannestory), story(Loustory), story(Ralphstory), story(Winniestory),
    all_different([Joannestory, Loustory, Ralphstory, Winniestory]),

    animal(JoanneAnimal), animal(LouAnimal),
    animal(RalphAnimal), animal(WinnieAnimal),
    all_different([JoanneAnimal, LouAnimal, RalphAnimal, WinnieAnimal]),

    Triples = [ [joanne, Joannestory, JoanneAnimal],
                [lou, Loustory, LouAnimal],
                [ralph, Ralphstory, RalphAnimal],
                [winnie, Winniestory, WinnieAnimal] ],

    % 1. The seal is not Joanne and Lou creation animal.
    \+ member([joanne, _, seal], Triples),
    \+ member([lou, _, seal], Triples),

    % 2. The seal did not go to moon in a spaceship or took trip around the world
    % using magic train.
    \+ member([_, spaceship, seal], Triples),
    \+ member([_, train, seal], Triples),

    % 3. Grizzly bear is not Joanne imagine friend.
    \+ member([joanne, _, grizzly_bear], Triples),

    % 4. Joanne went to circus.
    member([joanne, circus, _], Triples),

    % 5. winnie animal is zebra.
    member([winnie, _, zebra], Triples),

    % 6. Grizzly bear did not use spaceship to moon.
    \+ member([_, spaceship, grizzly_bear], Triples),

    tell(joanne, Joannestory, JoanneAnimal),
    tell(lou, Loustory, LouAnimal),
    tell(ralph, Ralphstory, RalphAnimal),
    tell(winnie, Winniestory, WinnieAnimal).

% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(X, Y, Z) :-
    write('Little. '), write(X), write(' travel to '), write(Y),
    write(' with '), write(Z), write('.'), nl.
