:- initialization(menu).
:- dynamic(capital/3).
:- dynamic(ope/1).
:- include(quiz).
capital(1, 'Roraima', 'Boa Vista').
capital(2, 'Amazonas', 'Manaus').

menu :- 
	writeln("-----------Menu principal--------------"),
	writeln("Digite sua opção:"),
	tab(10),writeln("1) Aprender"),
	tab(10),writeln("2) Ensinar"),
	tab(10),writeln("0) Sair"),
	write("Sua opção é: "), read(X),
	ope(X), menu.


ope(X) :- 
	(
		(X = 1) -> menuModulos;
		(X = 0) -> halt
	).

menuModulos :- 
	writeln("-----------Modulos--------------"),
	writeln("Digite sua opção:"),
	tab(10),writeln("1) Capitais"),
	tab(10),writeln("0) Sair"),
	write("Sua opção é: "), read(X),
	opeModulo(X).

opeModulo(X) :- 
	(
		(X = 1) -> quiz;
		(X = 0) -> halt
	).
