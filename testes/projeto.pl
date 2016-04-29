:- dynamic capital/2.

geo :- carrega('geo.bd'),
	format('~n*** Memoriza capitais ***~n~n'),
	repeat,
		pergunta(E),
		responde(E),
		continua(R),
	R = n,
	!,
	salva('geo.bd').

carrega(A) :-
	exists_file(A),
	consult(A)
	;
	true.

pergunta(E) :-
	format('~nQual o estado cuja capital você quer saber? '),
	read(E).

responde(E) :-
	capital(C, E),
	!,
	format('A capital de ~w é ~w.~n',[E,C]).

responde(E) :-
	format('Também não sei. Qual é a capital de ~w? ',[E]),
	read(C),
	asserta(capital(C,E)).

continua(R) :-
	salva('geo.bd'),
	format('~nContinua? [s/n] '),
	get_char(R),
	get_char('\n').

gets(S) :-
	read_line_to_codes(user,C),
	name(S,C).

salva(A) :-
	tell(A),
	listing(capital),
	told.
