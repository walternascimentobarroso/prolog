ponto(0).
quiz :- 
	writeln("-----------Menu Quiz Capital--------------"),
	writeln("Digite sua opção:"),
	tab(10),writeln('Qual é a capital de Roraima? '),
	write("Sua opção é: "), read(X),
	capital(_,'Roraima',X).
