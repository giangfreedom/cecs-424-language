% Problem #1, "It's a tie", Dell Logic Puzzles, October 1999
% Each man (mr so-and-so) got a tie from a relative.
sawitem(balloon).
sawitem(clothesline).
sawitem(frisbee).
sawitem(water_tower).

ms(barrada).
ms(gort).
mr(klatu).
mr(nikto).

day(tuesday).
day(wednesday).
day(thursday).
day(friday).

solve :-
    sawitem(BarradaSaw), sawitem(GortSaw), sawitem(KlatuSaw), sawitem(NiktoSaw),
    all_different([BarradaSaw, GortSaw, KlatuSaw, NiktoSaw]),

    day(BarradaDay), day(GortDay),
    day(KlatuDay), day(NiktoDay),
    all_different([BarradaDay, GortDay, KlatuDay, NiktoDay]),

    Triples = [ [barrada, BarradaSaw, BarradaDay],
                [gort, GortSaw, GortDay],
                [klatu, KlatuSaw, KlatuDay],
                [nikto, NiktoSaw, NiktoDay] ],

   % klatu did not see frisbee, klatu did not see balloon
   % gort did not see Frisbee
   \+ member([klatu, frisbee, _], Triples),
   \+ member([klatu, balloon, _], Triples),
   \+ member([gort, frisbee, _], Triples),


   %friday's sighting was made by either Ms. Barrada or
   % the one who saw a clothesline (or both)
   (member([barrada, _, friday], Triples);
    member([_, clothesline, friday], Triples)),

   %Mr.Nikto did not make his sighting on Tuesday
   \+ member([nikto, _, tuesday], Triples),

   %Mr.Klatu object is not water tower
   \+ member([klatu, water_tower, _], Triples),
   % klatu see item on thursday
   member([klatu, _, thursday], Triples),

    telll(barrada, BarradaSaw, BarradaDay),
    telll(gort, GortSaw, GortDay),
    tell(klatu, KlatuSaw, KlatuDay),
    tell(nikto, NiktoSaw, NiktoDay).

% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(X, Y, Z) :-
    write('Mr. '), write(X), write(' see the '), write(Y),
    write(' on '), write(Z), write('.'), nl.
telll(X, Y, Z) :-
    write('Ms. '), write(X), write(' see the '), write(Y),
    write(' on '), write(Z), write('.'), nl.
