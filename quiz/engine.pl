gamePoint(0).
numberOfQuestions(5).

	
ifThenElse(X, Y, _) :- X, !, Y. 
ifThenElse(_, _, Z) :- Z.
