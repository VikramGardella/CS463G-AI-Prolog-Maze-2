%finds the value of an element in the 2-D List, "M"
ind(M,Y,X,V) :-
	write('in ind'), nl,
	nth1(Y, M, MatrixRow),
	nth1(X, MatrixRow, V),
	write('finished ind'), nl.



% predicate that evaluates whether coordinates are the same
% this will be used to see if the destination is reached
notdest(Xo,Yo,Xf,Yf) :-
	\+(Xo = Xf);
	\+(Yo = Yf).

% checks to see if a pair of coordinates are already
% in the list "Path"
inPath(C,[C|Path]).
inPath(C,[H|T]):-
	inPath(C,T).

%the following predicates check to see if something is
%encountered at the current location and adjusts score
%accordingly
encountered_mewtwo(X,Y,Maze,Score) :-
	ind(Maze,Y,X,Value),
	Value = 'mt'.

encountered_masterball(X,Y,Maze,Score) :-
	ind(Maze,Y,X,Value),
	Value = 'mb',
	write('You found the Master Ball!'), nl.

encountered_egg(X,Y,Maze,Score) :-
	ind(Maze,Y,X,Value),
	Value = 'e',
	Score is Score+10,
	write('You found an egg!'), nl.

encountered_pikachu(X,Y,Maze,Score) :-
	ind(Maze,Y,X,Value),
	Value = 'p',
	Score is Score+1,
	write('You found a Pikachu!'), nl.

%first possible outcome for running into a mewtwo
%this one ends well for the player
captured_mewtwo(X,Y,Maze,Score) :-
	encountered_mewtwo(X,Y,Maze,Score),
	possess_masterball,
	write('You captured the Mewtwo!'), nl.

%second possible outcome for running into a mewtwo
%this one ends poorly for the player
game_over(X,Y,Maze,Score) :-
	encountered_mewtwo(X,Y,Maze,Score),
	not(possess_masterball),
	write('Game Over! You ran into the Mewtwo without a Master Ball!'), nl,
	write('Final Score: '), write(Score), nl.

possess_masterball :-
	encountered_masterball(X,Y,Maze,Score).

% the following "can_walk_to" predicate checks to see
% if adjacent squares are within bounds and are not
%unavailable

can_walk_to(XA,YA,XB,YB,Maze,Path,NextX,NextY):-
	XB is XA, %check down
	YB is YA-1,
	YB > 0;
	XB is XA, %check up
	YB is YA+1,
	YB < 6;
	XB is XA-1, %check left
	YB is YA,
	XB > 0;
	XB is XA+1, %check right
	YB is YA,
	XB < 6,
	ind(Maze,YB,XB,Value),
	Value is not('j'),
	unexplored(XB,YB,Path).


%Establishes which adjacent spaces are within bounds and
%don't have a 'j' in them by storing them in booleans
explore(X1,Y1,Maze,Up,Down,Left,Right):-
	X2 is X1,%check up
	Y2 is Y1-1,
	Up is can_walk_to(X1,Y1,X2,Y1,Maze,Path,NextX,NextY),
	X2 is X1,%check down
	Y2 is Y1+1,
	Down is can_walk_to(X1,Y1,X2,Y2,Maze,Path,NextX,NextY),	%check left
	X2 is X1-1,%check left
	Y2 is Y1,
	Left is can_walk_to(X1,Y1,X2,Y1,Maze,Path,NextX,NextY),
	X2 is X1+1,%check right
	Y2 is Y1,
	Right is can_walk_to(X1,Y1,X2,Y2,Maze,Path,NextX,NextY),
	write("Left movability: "),
	write(L), nl.

%	Path = [(X2,Y2)|Path],


%determines whether or not a pair of coordinates has
%already been explored or not, somewhat redundant because
%I could just have used "inPath" directly but helps
%make things clearer
unexplored(XB,YB,Path):-
	not(inPath((XB,YB),Path)).

all_explored(Up,Down,Left,Right):-
	Up is 1,
	Down is 1,
	Left is 1,
	Right is 1.

%below are the move predicates with conditions,
%theoretically only one of these will happen because
%of the "or" operators (";") in mazepath
move_back(Up,Down,Left,Right,X,Y,Path) :-
	all_explored(Up,Down,Left,Right),
	Path = [H|T],
	Path = T,
	Path = [(XC,YC)|N],
	X = XC,
	Y = YC.

move_up(Up,X,Y,Path) :-
	Up is 1,
	unexplored(X,Y,Path),
	Path = [(X,Y)|Path],
	Y = Y-1.

move_down(Down,X,Y,Path) :-
	Down is 1,
	unexplored(X,Y,Path),
	Path = [(X,Y)|Path],
	Y = Y+1.

move_left(Left,X,Y,Path) :-
	Left is 1,
	unexplored(X,Y,Path),
	Path = [(X,Y)|Path],
	X = X-1.

move_right(Right,X,Y,Path) :-
	Right is 1,
	unexplored(X,Y,Path),
	Path = [(X,Y)|Path],
	X = X+1.



% this is a recursive function that calls explore each
% iteration then picks one of the ok adjacent squares to
% move to
mazepath(X,Y,Maze,Path,Score) :-
	write('currently at: ('),
	write(X),
	write(','),
	write(Y),
	write(')'),
	nl,
	%tests these predicates for encounters
	captured_mewtwo(X,Y,Maze,Score),
	game_over(X,Y,Maze,Score),
	encountered_masterball(X,Y,Maze,Score),
	encountered_egg(X,Y,Maze,Score),
	encountered_pikachu(X,Y,Maze,Score),
	write("About to explore..."), nl,
	Up is 0,
	Down is 0,
	Left is 0,
	Right is 0,
	explore(X,Y,Maze,Up,Down,Left,Right),
	move_up(Up,X,Y,Path);
	move_down(Down,X,Y,Path);
	move_left(Left,X,Y,Path);
	move_right(Right,X,Y,Path);
	move_back(Up,Down,Left,Right,X,Y,Path),
	write('Moving to ('),
	write(X),
	write(','),
	write(Y),
	write(')'), nl,
	write('about to recurse'), nl, nl.
	mazepath(X,Y,Maze,Path,Score).










































