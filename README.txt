Author: Vikram Gardella

Course: CS 463G

Date Submitted: 11/4/2016

Code Description: My Prolog program takes in a predicate in the
following form: mazepath(X,Y,Maze,Path,Score). It is expected that
the 2-D list that is entered for Maze is a 5x5 structure. My code
uses recursion of the mazepath predicate with the parameters for the
new iteration being an updated pair of coordinates, Path, and Score as
well as the original Maze 2-D list. Within each iteration it calls
predicates to find out if the location it is currently occupying has
anything special in it and these predicates affect the score and output
to grader accordingly. Then after the encounter predicates, "explore"
is called to determine which adjacent spaces are within the bounds of
the maze as well as not "unavailable" (detailed by being a 'j'). The
results are stored in boolean like variables "Up", "Down", "Left", and
"Right". From there, the 5 move predicates are called separated by "or"
operators (";") so that only one of them will happen (or at least that's
what I had intended). Within them, they update the coordinates as well
as add the previous coordinates to the List of explored coordinates: Path.
"mazepath" is called at the end of itself with the parameters being updated
info and it recurs.

Technical problems: My code has several errors and warnings when I attempt
to compile. Also, I am not confident in my use of predicates. For example,
when I call all of my encounter predicates at the beginning of mazepath,
I am worried that mazepath will be set to false and terminate if any of them
are not true and not all of them can be true at once. Another thing that may
be a problem that does not show up as an error is my "possess_masterball"
predicate. I intended for it to stay permanently true once a Master Ball
was was found but it may get set to true when one is encountered, then
get set back to false the next iteration of "mazepath" because that same
predicate is called again and it will most likely update
"possess_masterball" to be false. Another technical problem that will not
appear during compilation is the fact that my program does not terminate
when it should.

What I learned: This second time around, I definitely became more confident
in my use and understanding of Prolog despite not being able to make my
program compile successfully. I also learned that there is no way to
implement "randomness" in Prolog which is a technical limitation of the
language. The language is meant to handle everything "systematically".
