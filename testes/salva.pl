salva(P) :-
	assert(P),
	tell('Saida.txt'),
	listing(P),
	told.
