capital('Roraima', 'Boa vista').
capital('Amazonas', 'Manaus').

inicio :- 
		questao_01.

questao_01 :- 
		capital(X, _),
		nl,
		write('Qual é a CAPITAL de '),write(X),write('?'),
		nl,
		read(I),
		capital(X, I).
