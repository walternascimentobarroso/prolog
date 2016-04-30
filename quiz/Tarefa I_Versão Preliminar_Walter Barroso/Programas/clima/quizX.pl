:- include(clima).

question(Id,Question) :- 
	clima(Id,Question,_).

answer(Id,Answer) :- clima(Id,_,Answer).

randomizeId(RandomId) :-
	numberOfQuestions(Range),
	RandomId is integer(random(Range) + 1),		
	findall(Id,clima(Id,_,_),Lista), 
	member(RandomId,Lista);
	findall(Id,clima(Id,_,_),_),
	randomizeId(RandomId).
		
quizItem(Id) :-
	question(Id,Question),
	format('~w? ',[Question]),nl,
	write('Resposta:'), read(Choice),
	answer(Id,Choice).

quizEngine(Id) :- 
	quizItem(Id),
	newPoint,
	retract(clima(Id,_,_)),
	writeln('Voce Acertou'),nl,
	aggregate_all(count, clima(_,_,_), Count),
	ifThenElse(Count=:=0,gameOver,clima).

quizEngine(Id) :-
	retract(clima(Id,_,_)),
	writeln('Voce Errou'),nl,
	aggregate_all(count, clima(_,_,_), Count),
	ifThenElse(Count=:=0,gameOver,clima).

clima :- 
	randomizeId(RandomId),	
	quizEngine(RandomId).
