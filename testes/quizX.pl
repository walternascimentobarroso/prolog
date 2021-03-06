:- dynamic gamePoint/1.
:- dynamic content/7.

:- initialization(main).

/*Content(Id,Discipline,Lesson,Page,Paragraph,Question,Aternative1,Alternative2,Alternative3,Alternative4,CorrectAlternative) */
content(1,'Qual a capital de Roraima?','Boa Vista','Manaus','Porto Velho','Rorainopolis',1).
content(2,'Como sao representadas funcao para entrada e saida de dados em haskell?','putStrLn, getLine','scanf, fscanf','read, readln','ghci, ghcin',1).
content(3,'O resultado da operacao succ 9*10 e :','91','90','100','0',3).
content(4,'O paradigma funcional prioriza:','passagem por referencia','passagem por parametro','uso de parenteses','recursao',4).
content(5,'Para obter o elemento de uma lista em haskell pelo seu indice e utilizado o operador:','!!','>/','<>',':-',1).

gamePoint(0).
numberOfQuestions(5).

question(Id,Question) :- 
	content(Id,Question,_,_,_,_,_).

alternative(Id,1,FirstAlternative) :- 
	content(Id,_,FirstAlternative,_,_,_,_).

alternative(Id,2,SecondAlternative) :- 
	content(Id,_,_,SecondAlternative,_,_,_).

alternative(Id,3,ThirdAlternative) :- 
	content(Id,_,_,_,ThirdAlternative,_,_).

alternative(Id,4,FourthAlternative) :- 
	content(Id,_,_,_,_,FourthAlternative,_).

alternative(_,5,_) :- halt.

answer(Id,Answer) :- content(Id,_,_,_,_,_,Answer).

incrementPoint(Point,PointMoreOne) :- PointMoreOne is Point+1.


randomizeId(RandomId) :-
		numberOfQuestions(Range),
		RandomId is integer(random(Range) + 1),		
		findall(Id,content(Id,_,_,_,_,_,_),Lista), 
		member(RandomId,Lista);
		findall(Id,content(Id,_,_,_,_,_,_),_),
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
	retract(content(Id,_,_,_,_,_,_)), 
	write('Voce Acertou'),nl,nl,	
	randomizeId(RandomId),
 	quizEngine(RandomId).

quizEngine(Id) :-
	retract(content(Id,_,_,_,_,_,_)),
	write('Voce Errou'),nl,nl,
	randomizeId(RandomId),		
	quizEngine(RandomId).
	

gameOver :- 
	write('Fim de jogo'),nl,nl,
	write('Sua pontuacao final foi: '),
	gamePoint(Point),write(Point),nl,halt.

main :- 
	write('=================================================='),nl,
	write('============Bem vindo ao QuizComenda=============='),nl,
	write('=================================================='),nl,
	write('Responda as perguntas e iremos te recomendar'),nl,nl,
	randomizeId(RandomId),		
	quizEngine(RandomId).

