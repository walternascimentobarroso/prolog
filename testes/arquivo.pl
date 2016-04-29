man(alan).
man(john).
man(george).

list_all:-
	man(X),
	writeln(X),nl,
	program,
	fail.

program :-
    open('file.txt',write, Stream),
    forall(man(Man), write(Stream,Man)),
    close(Stream).
