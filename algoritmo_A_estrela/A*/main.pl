%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                       %
%       Walter Nascimento Barroso       %
%                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- dynamic(menu/0).
:- dynamic(op/1).
:- dynamic(menuRomenia/0).
:- dynamic(opRomenia/1).
:- dynamic(acaoRomenia/0).
:- dynamic(imprimirCaminho/1).
:- initialization(menu).
:- include(romenia).
:- include(aEstrela).

%%%%%%%%%%%%% Menu Principal %%%%%%%%%%%%

menu :-
	writeln("-----------Menu principal--------------"),
	writeln("Digite sua opção:"),
	tab(10),writeln("1) Mapa da romenia"),
	tab(10),writeln("2) Sair"),
	write("Sua opção é: "), read(X),
	op(X),
menu.


op(X) :- 
	(
		(X = 1) -> menuRomenia;
		(X = 2) -> halt
	).

menuRomenia :- 
	writeln("-----------Menu Romênia----------------"),
	writeln("Digite sua opção:"),
	tab(10),writeln("1) Encontrar melhor caminho até Bucharest"),
	tab(10),writeln("2) Sair"),
	write("Sua opção é: "), read(X),
	opRomenia(X).

opRomenia(X) :- 
	(
		(X = 1) -> acaoRomenia,nl;
		(X = 2) -> halt
	).

acaoRomenia :-
	writeln("-----------Melhor Caminho--------------"),
	writeln("Digite sua opção:"),
	tab(10),writeln("Em qual cidade você esta?"), read(X),
	encontrarCaminho(X,'Bucharest'),nl.

%%%%%%%%%%%%%%%%%%%%% imprime o resultado %%%%%%%%%%%%%%%%%%%%%
imprimirCaminho([CidadeAtual|Cola]) :-
	writeln('Caminho a percorrer: '),
	imprimeCaminho([CidadeAtual|Cola]).

imprimeCaminho([CidadeAtual|Cola]) :-
	cidade(CidadeAtual, X),
	write(X),
	(X = 'Bucharest' -> write('.'); write(', ')),
	imprimeCaminho(Cola).

imprimeCaminho([Custo]) :-
	nl,write('A distância total percorrida foi de: '),
	write(Custo),
	write(' km.').
