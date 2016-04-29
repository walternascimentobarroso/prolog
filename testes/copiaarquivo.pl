copyterms(Infile, Outfile):-
  seeing(Oldinput), see(Infile), telling(Oldoutput), tell(Outfile),
  repeat,read(X),process(X),
  seen, see(Oldinput), told, tell(Oldoutput),!.

process(end_of_file):-!.
process(X):-writeq(X),nl,fail.
