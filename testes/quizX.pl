:- dynamic recomendations/5.
:- dynamic gamePoint/1.
:- dynamic content/11.

:- initialization(main).

/*Content(Id,Discipline,Lesson,Page,Paragraph,Question,Aternative1,Alternative2,Alternative3,Alternative4,CorrectAlternative) */
content(1,'Haskell',9,18,1,'Qual a capital de Roraima?','Boa Vista','Manaus','Porto Velho','Rorainopolis',1).
content(2,'Haskell',9,22,1,'Como sao representadas funcao para entrada e saida de dados em haskell?','putStrLn, getLine','scanf, fscanf','read, readln','ghci, ghcin',1).
content(3,'Haskell',9,33,1,'O resultado da operacao succ 9*10 e :','91','90','100','0',3).
content(4,'Haskell',9,45,1,'O paradigma funcional prioriza:','passagem por referencia','passagem por parametro','uso de parenteses','recursao',4).
content(5,'Haskell',10,	8,2,'Para obter o elemento de uma lista em haskell pelo seu indice e utilizado o operador:','!!','>/','<>',':-',1).

gamePoint(0).
numberOfQuestions(5).

discipline(Id,Discipline) :- 
	content(Id,Discipline,_,_,_,_,_,_,_,_,_) ;
	recomendations(Id,Discipline,_,_,_).

lesson(Id,Lesson) :- 
	content(Id,_,Lesson,_,_,_,_,_,_,_,_); 
	recomendations(Id,_,Lesson,_,_).

page(Id,Page) :- 
	content(Id,_,_,Page,_,_,_,_,_,_,_) ; 
	recomendations(Id,_,_,Page,_).

paragraph(Id,Paragraph) :- 
	content(Id,_,_,_,Paragraph,_,_,_,_,_,_); 
	recomendations(Id,_,_,_,Paragraph).

question(Id,Question) :- 
	content(Id,_,_,_,_,Question,_,_,_,_,_).

alternative(Id,1,FirstAlternative) :- 
	content(Id,_,_,_,_,_,FirstAlternative,_,_,_,_).

alternative(Id,2,SecondAlternative) :- 
	content(Id,_,_,_,_,_,_,SecondAlternative,_,_,_).

alternative(Id,3,ThirdAlternative) :- 
	content(Id,_,_,_,_,_,_,_,ThirdAlternative,_,_).

alternative(Id,4,FourthAlternative) :- 
	content(Id,_,_,_,_,_,_,_,_,FourthAlternative,_).

alternative(_,5,_) :- halt.

answer(Id,Answer) :- content(Id,_,_,_,_,_,_,_,_,_,Answer).

incrementPoint(Point,PointMoreOne) :- PointMoreOne is Point+1.


randomizeId(RandomId) :-
		numberOfQuestions(Range),
		RandomId is integer(random(Range) + 1),		
		findall(Id,content(Id,_,_,_,_,_,_,_,_,_,_),Lista), 
		member(RandomId,Lista);
		findall(Id,content(Id,_,_,_,_,_,_,_,_,_,_),_),
		randomizeId(RandomId).

randomizeId(_) :- 
		gameOver.			
		

quizItem(Id) :-
	question(Id,Question),
	write(Question),nl,
	alternative(Id,1,FirstAlternative),
	write('  1)'),write(FirstAlternative),nl,
	alternative(Id,2,SecondAlternative),
	write('  2)'),write(SecondAlternative),nl,
	alternative(Id,3,ThirdAlternative),
	write('  3)'),write(ThirdAlternative),nl,
	alternative(Id,4,FourthAlternative),
	write('  4)'),write(FourthAlternative),nl,
	write('  5)Terminar Jogo'),nl,
	read(Choice),
	ifThenElse(Choice=:=5,gameOver,answer(Id,Choice)).
	
ifThenElse(X, Y, _) :- X, !, Y. 
ifThenElse(_, _, Z) :- Z.

/* If the user hit the answer, remove this from database to this dont repeat*/
quizEngine(Id) :- 
	quizItem(Id),
	gamePoint(Point), 
	incrementPoint(Point,PointMoreOne),
	retract(gamePoint(Point)),
	assertz(gamePoint(PointMoreOne)),
	retract(content(Id,_,_,_,_,_,_,_,_,_,_)), 
	write('Voce Acertou'),nl,nl,	
	randomizeId(RandomId),
 	quizEngine(RandomId).

/*If the user dont hit the answer, insert this question Id to the list of recomendations to study*/
quizEngine(Id) :-
	discipline(Id,Discipline),
	lesson(Id,Lesson),
	page(Id,Page),
	paragraph(Id,Paragraph),
	retract(content(Id,_,_,_,_,_,_,_,_,_,_)),
	assert(recomendations(Id,Discipline,Lesson,Page,Paragraph)), 
	write('Voce Errou'),nl,nl,
	randomizeId(RandomId),		
	quizEngine(RandomId).
	

gameOver :- 
	write('Fim de jogo'),nl,nl,
	write('Sua pontuacao final foi: '),
	gamePoint(Point),write(Point),nl,nl,
	showRecomendations.

showRecomendations :- 
	findall(NewId,recomendations(NewId,_,_,_,_),_),
	write('Voce precisa estudar os seguintes itens:'),nl, nl,
	contentRecomendation(_).

showRecomendations :- 
	write('Parabens, voce acertou tudo e aparentemente nao precisa estudar nada por enquanto'),nl,halt.

/*Recommends one content of accord by of  the Id*/
contentRecomendation(Id) :-
	write('Conteudo da disciplina----'),
	discipline(Id,Discipline),write(Discipline),nl,
	write('Que esta na Aula----------'),
	lesson(Id,Lesson),write(Lesson),nl,
	write('Pagina--------------------'),
	page(Id,Page),write(Page),nl,
	write('Paragrafo-----------------'),
	paragraph(Id,Paragraph),write(Paragraph),nl,nl,nl,
	retract(recomendations(Id,_,_,_,_)),
	findall(NewId,recomendations(NewId,_,_,_,_),_),
	contentRecomendation(_).

contentRecomendation(_) :- 
	halt.

main :- 
	write('=================================================='),nl,
	write('============Bem vindo ao QuizComenda=============='),nl,
	write('=================================================='),nl,
	write('Responda as perguntas e iremos te recomendar'),nl,nl,
	randomizeId(RandomId),		
	quizEngine(RandomId).

