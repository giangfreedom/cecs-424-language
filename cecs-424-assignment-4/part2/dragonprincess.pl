:- dynamic at/2, i_am_at/1, alive/1.   /* Needed by SWI-Prolog. */
:- retractall(at(_, _)), retractall(i_am_at(_)), retractall(alive(_)).

/* This defines my current location. */
i_am_at(hero_summon_house).

/* these fact describe how the rooms are connected */

path(dragon, d, palace).

path(palace, u, dragon).
path(palace, w, palace_entrance).

path(palace_entrance, e, palace).
path(palace_entrance, s, herotown).

path(herotown, n, palace_entrance).

path(herotown, s, hero_summon_house).

path(hero_summon_house, n, herotown).

path(hero_summon_house, w, forge) :- at(key, in_hand).
path(hero_summon_house, w, forge) :-
	write('you need key to open the forge.'), nl,
	fail.

path(forge, e, hero_summon_house).

path(hero_summon_house, s, hydra_den).
path(hydra_den, n, hero_summon_house).

path(hydra, d, hydra_den).
path(hydra_den, u, hydra).

path(herotown, w, temple).
path(temple, e, herotown).

/* These facts tell where the various objects in the game
   are located. */

at(princess, dragon).
at(key, hero_summon_house).
at(sword, forge).
at(armor, temple).
at(shield, hydra_den).

/* This fact specifies that the dragon is alive. */

alive(dragon).
alive(hydra).


/* These rules describe how to pick up an object. */

take(X) :-
        at(X, in_hand),
        write('You''re already holding it!'),
        nl, !.

take(X) :-
        i_am_at(Place),
        at(X, Place),
        retract(at(X, Place)),
        assert(at(X, in_hand)),
        write('OK.'),
        nl, !.

take(_) :-
        write('I don''t see it here.'),
        nl.


/* These rules describe how to put down an object. */

drop(X) :-
        at(X, in_hand),
        i_am_at(Place),
        retract(at(X, in_hand)),
        assert(at(X, Place)),
        write('OK.'),
        nl, !.

drop(_) :-
        write('You aren''t holding it!'),
        nl.

/*inventory */

i :-	at(key, in_hand),
	write('you have key.'), nl,
	write('checking for sword.'), nl,
	at(sword, in_hand),
	write('you have sword.'), nl,
	write('checking for armor.'), nl,
	at(armor, in_hand),
	write('you have armor.'), nl,
	write('checking for shield.'), nl,
	at(shield, in_hand),
	write('you have shield.'), nl.



/* These rules define the six direction letters as calls to go/1. */

n :- go(n).

s :- go(s).

e :- go(e).

w :- go(w).

u :- go(u).

d :- go(d).


/* This rule tells how to move in a given direction. */

go(Direction) :-
        i_am_at(Here),
        path(Here, Direction, There),
        retract(i_am_at(Here)),
        assert(i_am_at(There)),
        look, !.

go(_) :-
        write('You can''t go that way.').


/* This rule tells how to look about you. */

look :-
        i_am_at(Place),
        describe(Place),
        nl,
        notice_objects_at(Place),
        nl.


/* These rules set up a loop to mention all the objects
   in your vicinity. */

notice_objects_at(Place) :-
        at(X, Place),
        write('There is a '), write(X), write(' here.'), nl,
        fail.

notice_objects_at(_).


/* These rules tell how to kill the dragon. */

kill :-
        i_am_at(hydra_den),
        write('This isn''t working.  get on top of hydra using u command'), nl,
        write('and slay the hydra head.').

kill :-
        i_am_at(hydra),
        at(sword, in_hand),
        retract(alive(hydra)),
        write('You slash your mighty sword at its head'), nl,
        write('the sword cut the hydra head and you win'), nl,!.


kill :-
        i_am_at(palace),
        write('This isn''t working.  get on top of dragon using u command'), nl,
        write('and slay the dragon head.').

kill :-
        i_am_at(dragon),
        at(sword, in_hand),
	at(armor, in_hand),
	at(shield, in_hand),
        retract(alive(dragon)),
        write('You slash your mighty sword at its head'), nl,
        write('the sword cut the dragon head but you also get burn'), nl,
        write('your mighty armor blocked the dragon breath '), nl,
	write('you raise your shield to block the dragon sharp claw strike'), nl,
	write('mighty hero you have success in slaying the dragon'), nl, !.

kill :-
        i_am_at(dragon),
        write('you need a sword + shield + armor to fight'), nl,
        write('your 2 fist cant slay the dragon'), nl.

kill :-
        write('I see nothing inimical here.'), nl.


/* This rule tells how to die. */

die :-
        !, finish.

/* Under UNIX, the "halt." command quits Prolog but does not
   remove the output window. On a PC, however, the window
   disappears before the final output can be seen. Hence this
   routine requests the user to perform the final "halt." */

finish :-
        nl,
        write('The game is over. Please enter the   halt.   command.'),
        nl, !.



/* This rule just writes out game instructions. */

instructions :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('start.                   -- to start the game.'), nl,
        write('n.  s.  e.  w.  u.  d.   -- to go in that direction.'), nl,
        write('take(Object).            -- to pick up an object.'), nl,
        write('drop(Object).            -- to put down an object.'), nl,
        write('kill.                    -- to attack an enemy.'), nl,
        write('look.                    -- to look around you again.'), nl,
        write('instructions.            -- to see this message again.'), nl,
        write('halt.                    -- to end the game and quit.'), nl,
	write('i.			-- to check inventory.'), nl,
        nl.


/* This rule prints out instructions and tells where you are. */

start :-
        instructions,
        look.


/* These rules describe the various rooms.  Depending on
   circumstances, a room may have more than one description. */

describe(herotown) :-
        at(princess, in_hand),
        write('Congratulations!!  You have ruecued the princess'), nl,
        write('and won the game.'), nl,
        finish, !.

describe(palace_entrance) :-
        write('to the east of this entrance is the palace.'), nl,
        write('to the south is the herotown'), nl.

describe(herotown) :-
        write('You are in a hero town.  To the north is the palace_entrance'), nl,
        write('to the south is the hero_summon_house, to the west is temple'), nl.

describe(temple) :-
        write('You are in a holy temple.  To the east is the hero town'), nl.


describe(hero_summon_house) :-
        write('You are in a place where legend are born.To the north is the herotown'), nl,
        write('to the west is the forge, to the south is hydra_den'), nl.

describe(forge) :-
        write('You are in a place where legendary weapon and armor are make'), nl.

describe(hydra_den) :-
        alive(hydra),
	at(shield, in_hand),
        write('the hydra see you stealing his precious shield!'), nl,
        write('the hydra is chasing after you...'), nl, !.

describe(hydra_den) :-
        alive(hydra),
        write('There is a giant hydra here!'), nl,
        write('I would advise you to leave promptly and quitely...'), nl, !.

describe(hydra_den) :-
        write('There is a giant dead hydra here!'), nl.

describe(hydra) :-
        alive(hydra),
        write('You are on top of a giant hydra, standing in a sticky'), nl,
        write('hardened scale.  The smell is awful.'), nl.

describe(hydra) :-
        write('Oh, mighty!  You''re on top of a giant dead hydra!'), nl.



describe(palace) :-
        alive(dragon),
	at(princess, in_hand),
        write('the dragon see you stealing his princess!'), nl,
        write('the dragon is chasing after you...'), nl, !.


describe(palace) :-
        alive(dragon),
        write('There is a giant dragon here!'), nl,
        write('I would advise you to leave promptly and quitely...'), nl, !.

describe(palace) :-
        write('There is a giant dead dragon here!'), nl.

describe(dragon) :-
        alive(dragon),
        write('You are on top of a giant dragon, standing in a rough'), nl,
        write('hardened scale.  The smell is awful.'), nl.

describe(dragon) :-
        write('Oh, mighty!  You''re on top of a giant dead dragon!'), nl.
