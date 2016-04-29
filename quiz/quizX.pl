:- dynamic gamePoint/1.
:- include(capital).
:- include(engine).
:- initialization(main).

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

quizEngine(Id) :- 
	quizItem(Id),
	gamePoint(Point), 
	incrementPoint(Point,PointMoreOne),
	retract(gamePoint(Point)),
	assertz(gamePoint(PointMoreOne)), 
	retract(content(Id,_,_,_,_,_,_)),
	writeln('Voce Acertou'),nl,
	aggregate_all(count, content(_,_,_,_,_,_,_), Count),
	ifThenElse(Count=:=0,gameOver,func).

quizEngine(Id) :-
	retract(content(Id,_,_,_,_,_,_)),
	writeln('Voce Errou'),nl,
	aggregate_all(count, content(_,_,_,_,_,_,_), Count),
	ifThenElse(Count=:=0,gameOver,func).

func :-
	randomizeId(RandomId),	
	quizEngine(RandomId).

gameOver :- 
	writeln('Fim de jogo'),nl,
	write('Sua pontuacao final foi: '),
	gamePoint(Point),writeln(Point),halt.

main :- 
	writeln('=================================================='),
	writeln('===============Bem vindo ao SIEGE================='),
	writeln('=================================================='),
	randomizeId(RandomId),	
	quizEngine(RandomId).

