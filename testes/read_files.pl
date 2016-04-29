readline:-get0(X),process(X).
process(10).
process(X):-X=\=11,put(X),nl,readline.

readterms(Infile,Outfile):-
  see(Infile),tell(Outfile),
  read(T1),write(T1),nl,
  read(T2),write(T2),nl,
  read(T3),write(T3),nl,
  read(T4),write(T4),nl,
seen,told.
