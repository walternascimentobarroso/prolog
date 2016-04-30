:- initialization(menu).
:- include(engine).
:- include(clima/quizX).
:- include(extremo/quizX).
:- include(relevo/quizX).
:- include(vegetacao/quizX).
:- include(capital/quizX).
:- dynamic(opeModulo/1).

menu :- 
	writeln('=================================================='),
	writeln('===============Bem vindo ao SIEGE================='),
	writeln('=================================================='),
	writeln("Escolha seu Modulo:"),
	tab(10),writeln("1) Capitais"),
	tab(10),writeln("2) Climas"),
	tab(10),writeln("3) Relevos"),
	tab(10),writeln("4) Vegetação"),
	tab(10),writeln("5) Extremos"),
	tab(10),writeln("0) Sair"),
	write("Sua opção é: "), read(X),
	opeModulo(X).

opeModulo(X) :- 
	(
		(X = 1) -> capital;
		(X = 2) -> clima;
		(X = 3) -> relevo;
		(X = 4) -> vegetacao;
		(X = 5) -> extremo;
		(X = 0) -> halt
	).
