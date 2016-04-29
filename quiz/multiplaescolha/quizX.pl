:- dynamic gamePoint/1.
:- include(capital).
:- initialization(main).

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
		member(RandomId,Lista),
		writeln(Lista);
		findall(Id,content(Id,_,_,_,_,_,_),_),
		randomizeId(RandomId).
		
quizItem(Id) :-
	question(Id,Question),
	format('Qual é a capital do(e) ~w? ',[Question]),nl,
	alternative(Id,1,FirstAlternative),
	write('  1) '),write(FirstAlternative),nl,
	alternative(Id,2,SecondAlternative),
	write('  2) '),write(SecondAlternative),nl,
	alternative(Id,3,ThirdAlternative),
	write('  3) '),write(ThirdAlternative),nl,
	alternative(Id,4,FourthAlternative),
	write('  4) '),write(FourthAlternative),nl,
	write('  5) Terminar Jogo'),nl,
	read(Choice),
	ifThenElse(Choice=:=5,gameOver,answer(Id,Choice)).
	
ifThenElse(X, Y, _) :- X, !, Y. 
ifThenElse(_, _, Z) :- Z.

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
	write('===============Bem vindo ao SIEGE================='),nl,
	write('=================================================='),nl,
	randomizeId(RandomId),		
	quizEngine(RandomId).

