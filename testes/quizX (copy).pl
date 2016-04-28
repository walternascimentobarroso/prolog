:- dynamic recomendations/5.
:- dynamic gamePoint/1.
:- dynamic content/11.

/*Content(Id,Discipline,Lesson,Page,Paragraph,Question,Aternative1,Alternative2,Alternative3,Alternative4,CorrectAlternative) */
content(1,'Haskell',9,18,1,'Haskell e uma linguagem de programacao puramente?','orientada a objetos','funcional','imperativa','logica',2).
content(2,'Haskell',9,22,1,'Como sao representadas funcao para entrada e saida de dados em haskell?','putStrLn, getLine','scanf, fscanf','read, readln','ghci, ghcin',1).
content(3,'Haskell',9,33,1,'O resultado da operacao succ 9*10 e :','91','90','100','0',3).
content(4,'Haskell',9,45,1,'O paradigma funcional prioriza:','passagem por referencia','passagem por parametro','uso de parenteses','recursao',4).
content(5,'Haskell',10,	8,2,'Para obter o elemento de uma lista em haskell pelo seu indice e utilizado o operador:','!!','>/','<>',':-',1).
content(6, 'Haskell', 10,22,1,'O que essa funcao, definida por um gerador  [x*2 | x <- [1..10]], retorna?','os numeros pares 2, 4, 6, 8,10,12,14, 16, 18, 20','os numeros  de 1 a 10','Os numeros primos contidos entre 1 e 10','o tamanho da lista',1).
content(7,'Haskell',10,	38,1,'A travessia em ordem faz o seguinte percurso na arvore:','raiz -> subarvore direita -> subarvore esquerda','subarvore esquerda -> raiz -> subarvore direita','subarvore esquerda -> subarvore direita -> raiz','apenas as subarvores', 2).
content(8,'Haskell',12,	4,1,'O que define um modulo em haskell?','uma colecao de listas','uma colecao de numeros','uma colecao de funcao e tipos relacionados','nao existe modulo em haskell',3).
content(9, 'Haskell',12,47,1,'Qual a funcao da main em Haskell?','chamar outros modulos a partir desse modulo main','inicializar as variaves','diminuir a complexidade do codigo','realizar a funcao de um metodo construtor',1).
content(10, 'Haskell',12,7,3,'Qual a palavra reservada utlizada para importar modulos em haskell?','include','import','inclusion','use',2).
content(11,'Haskell',12,14,1,'O que a funcao fromList faz?','verifica se o elemento esta contido na lista','lista todos os elementos da lista','deleta um elemento da lista','lista e mapeia associacoes',4).
content(12, 'Haskell',11,33,2,'Qual o interpretador da linguagem haskell?','MinGw','Dev','Sublime','GHCI',4).
content(13,'Haskell',10,7,1,'Qual o resultado da operacao  [1,2,3] ++ [4] ?','[1,2,3,4]','[1,2,3]','[1,2,3]','[1,2,3]','[1,2,3]','[1,2,3]','[4]','[10]',1).
content(14, 'Haskell',10,8,1,'[1,2,3] e equivalente a ?','1,2,3','[1], [2], [3]','1:2:3:[]','1:2:3:',3).
content(15,'Multiagentes',21,5,2,'Unidades Concorrentes podem ser executadas em: ','Unico processador','varios processadores compartilhando uma memoria','todas as alternativas estao corretas',4).
content(16,'Multiagentes',21,9,1,'A concorrencia e dividida em diferentes niveis, qual esta errado','instrucao','conjunto','comando','unidade',2).
content(17,'Multiagentes',21,39,1,'Em java qual metodo faz com que um recurso seja acessado atomicamente','suspend','notifyAll','syncronized','yield',3).
content(18,'Multiagentes',21,50,1,'A sincronizacao de cooperacao em Java e obtida com os metodos','wait e notify','yeld e wait','notify e yeld','yeld e notifyAll',1).
content(19,'Multiagentes',23,6,1,'Quais sao as três caracteriscas chaves de um Agente de Software','Colaborativo, Autonomia, Aprendizado','Cooperacao, Autonomia, Competicao','Cooperacao, Autonomia, Aprendizado','Cooperacao, Colaborativo, Aprendizado',3).
content(20,'Multiagentes',23,12,1,'Quando um agente responde a mudancas do ambiente a tempo e de maneira apropriada corresponde a:','realividade','proatividade','interatividade','autonomia',1).
content(21,'Multiagentes',23,13,1,'Quando um agente tem capacidade de atuar utilizando o conhecimento adiquirido diante o conexto, corresponte a:','Aprendizagem','racionalidade','mobilidade','proatividade',2).
content(22,'Multiagentes',23,13,1,'Quando um agente tem capacidade de melhorar seu desempenho com o passar do tempo, corresponde a:','racionalidade','autonomia','interatividade','Aprendizagem',4).
content(23,'Multiagentes',24,25,1,'A classe Agente possui as seguintes constantes exceto:','AP_INITIATED ','AP_ACTIVE','AP_FINESHED','AP_SUSPENDED',3).
content(24,'Prolog',14,5,1,'Quais dois elementos disjuntos que constituem um algoritmo de programacao logica?','Logica e Controle','Controle e Condicao','Logica e Condicao','Condicao e Recursividade',1).
content(25,'Prolog',14,5,4,'Qual o paradigma fundamental da programacao logica ?','Programacao Procedimental','Programacao Declarativa','Programacao Recursiva','Programacao Implicita',2).
content(26,'Prolog',14,6,2,'Pode-se expressar conhecimento em Prolog por meio de clausulas de dois tipos:','Fatos e Condicoes','Regras e Condicoes','Fatos e Exemplos','Fatos e Regras',4).
content(27,'Prolog',14,6,3,'Assina-le a alternativa incorreta. Os sistemas de programacao logica em geral, possuem as seguintes propriedades:','nao sao naturalmente recursivas','Possuem capacidade dedutiva','Permitem a representacao de relacoes reversiveis','Operam de forma nao deterministicas',1).
content(28,'Prolog',14,10,4,'No WIN-PROLOG a funcao "Consult" tem o seguinte papel:','Consultar uma base de dados web','Consultar um banco de dados MYSQL','Carregar o programa no interpretador','Fechar o interpretador',3).
content(29,'Prolog',14,14,1,'Qual a correta representacao de um atomo em prolog?','12Atomo','Atomo12','atomo12','12atomo',3).
content(30,'Prolog',14,14,3,'Qual a correta representacao de uma variavel em prolog?','Variavel15','variavel14','15variavel','15Variavel',1).
content(31,'Prolog',14,14,4,'Como representar uma estrutura que representa a data: 7 de setembro de 2002, em Prolog?','(7,setembro,2002)data','data(7,setembro,2002)','data = (7,setembro,2002)','(7,setembro,2002) = data',2).
content(32,'Prolog',14,17,2,'O simbolo reservado ";" exerce qual funcao no interpretador do Prolog? ','Representa o fim de uma pergunta','Remove o fato da base de dados','Investiga outras possiveis resposta para a pergunta','Remove uma regra da base de dados',3).
content(33,'Prolog',14,19,2,'Em uma base de dados com os seguintes fatos: progenitor(pam,bob). progenitor(tom,bob). progenitor(tom,liz) progenitor(bob,ann). progenitor(bob,pat). progenitor(pat,jim). Qual a questao para descobrir quem e o avô de Jim?','?-progenitor(X,Y),progenitor(Y,jim).','?-progenitor(X,progenitor(Y,jim)).','?-progenitor(X,jim),progenitor(X,Y).','?-progenitor(jim,Y),progenitor(Y,jim).',1).
content(34,'Prolog',14,20,2,'Qual a sintaxe para definicao de uma regra em Prolog?','if pred(arg/Var,arg/Var) then pred(arg/Var,arg/Var)','pred(arg/Var,arg/Var) if pred(arg/Var,arg/Var).','pred(arg/Var,arg/Var);pred(arg/Var,arg/Var).','pred(arg/Var,arg/Var):-pred(arg/Var,arg/Var).',4).
content(35,'Prolog',14,20,2,'Qual o significado do operador ":-" em Prolog ?','Else','If','Then','GoTo',2).
content(36,'Prolog',14,23,1,'Os operadores de conjuncao e disjuncao em Prolog sao consecutivamentes','"-:" e ","','":-" e ";"','"," e ";"','";" e "-:"',3).
content(37,'Prolog',15,3,4,'O operador de corte "Cut" e representado por:','"!"','";"','"break"','"abort()"',1).
content(38,'Prolog',15,9,1,'Em Prolog, a expressao: X e menor ou igual a Y. E representada como:','X <= Y','Y >= X','X =< Y','X < Y || X = Y',3).
content(39,'Prolog',16,11,'Em Prolog, como adicionar clausulas na base de dados em tempo de execucao?','add(clausula(var1))','assert(clausula(var1)','adc(clausula(var1))','insert(clausula(var1))',2).
content(40,'Prolog',16,13,'Em Prolog, como remover uma clausula da base de dados em tempo de execucao?','remove(clausula(var1))','delete(clausula(var1))','retract(clausula(var1))','del(clausula(var1))',3).
content(41,'Prolog',18,10,'Em Prolog, para se declarar um operador infixo usa-se a seguinte sitaxe:',':-op(precedencia,xfx,[operadores]).',':-op(precedencia,xf,[operadores]).',':-op(precedencia,fx,[operadores]).','op(precedencia,xfxx,[operadores]).',1).
content(42,'Grails', 4,9,2,'Quais sao alguns dos facilitadores do Grails?', 'Suporte nativo a listas, mapas e closure', 'Possui listas, grafos e hashes', 'Aceita linguagens como Python, Rails e C', 'Suporte nativo a internacionalizacao', 1).
content(43,'Grails', 4,29,1,'Qual o comando para criar uma aplicacao em Grails?', 'sudo apt-get install grails-app', 'grails create-domain-class Nome', 'grails create-app Nome', 'package Nome', 3).
content(44,'Grails', 4,44,1,'Qual o comando para criar as telas, controladoras e testes da classe dominio?','grails run-app','grails generate-all Classe','grails create-app Nome','static belongsTo = [classe: Classe]',2).
content(45,'Grails',5,6,3,'Comando para criar uma classe de dominio e:','grails create-domain-class Classe',':-op(precedencia,xf,[operadores]).','cout >> "Create domain class Classe";','SELECT * FROM Classe',1).
content(46,'Grails',5,35,2,'Comando utilizado para atualizar as dependencias do Grails e:','grails rake schema.db','sudo apt-get update','grails update-dependencies','grails refresh-dependencies',4).
content(47,'Grails',5,34,2,'O conceito de scaffold esta relacionado a:','Possibilitar que a aplicacao contenha metodos do CRUD','Seja possivel utilizar o bootstrap','Criptografe as senhas dos usuarios','Que a aplicacao se torne web',1).
content(48,'Grails',5,18,1,'Qual o codigo para gerar uma associacao 1:1?','set.Association  = [1:1->Classe]','this.HasOne.Classe','static hasOne = [classe:Classe]','classe unique: true',3).
content(49,'Grails',5,18,1,'Codigo para que uma das dependencias nao sejam obrigatorias na criacao.','classe unique: true','classe nullable: true','bool is_nullable = 1;','n.d.a.',2).
content(50,'Grails',5,37,1,'O que em um codigo referencia para uma dependencia de outra classe?','set.BelongTo = Classe','static hasOneFather = Classe','static belongsTo = Classe','Todas as anteriores',3).
content(51,'Grails',5,18,2,'Unique, nullable, blank entre outras, sao:','Variaveis estaticas','Atributos da Classe','Classes','Constraints',4).

gamePoint(0).
/*Total of questions stored on database*/
numberOfQuestions(51).

/*Binary relationships of the content*/
discipline(Id,Discipline) :- content(Id,Discipline,_,_,_,_,_,_,_,_,_) ; recomendations(Id,Discipline,_,_,_).
lesson(Id,Lesson) :- content(Id,_,Lesson,_,_,_,_,_,_,_,_) ; recomendations(Id,_,Lesson,_,_).
page(Id,Page) :- content(Id,_,_,Page,_,_,_,_,_,_,_) ; recomendations(Id,_,_,Page,_).
paragraph(Id,Paragraph) :- content(Id,_,_,_,Paragraph,_,_,_,_,_,_) ; recomendations(Id,_,_,_,Paragraph).
question(Id,Question) :- content(Id,_,_,_,_,Question,_,_,_,_,_).
alternative(Id,1,FirstAlternative) :- content(Id,_,_,_,_,_,FirstAlternative,_,_,_,_).
alternative(Id,2,SecondAlternative) :- content(Id,_,_,_,_,_,_,SecondAlternative,_,_,_).
alternative(Id,3,ThirdAlternative) :- content(Id,_,_,_,_,_,_,_,ThirdAlternative,_,_).
alternative(Id,4,FourthAlternative) :- content(Id,_,_,_,_,_,_,_,_,FourthAlternative,_).
alternative(Id,5,QuitGame) :- abort.
answer(Id,Answer) :- content(Id,_,_,_,_,_,_,_,_,_,Answer).

/*Increment the point of quiz game*/
incrementPoint(Point,PointMoreOne) :- PointMoreOne is Point+1.

/*Return a random Id that is contained in the list of contents*/
randomizeId(RandomId) :-
		numberOfQuestions(Range),
		RandomId is integer(random(Range) + 1),		
		findall(Id,content(Id,_,_,_,_,_,_,_,_,_,_),Lista), 
		member(RandomId,Lista). /*Verify if random id is on the list of contents*/ 
randomizeId(RandomId) :-  /*If the random item does not on the list of contents, randomize a new number*/
		findall(Id,content(Id,_,_,_,_,_,_,_,_,_,_),Lista),
		%solution(member(X,Lista),S), /*Verify if the list is not Null*/
		randomizeId(RandomId).
randomizeId(RandomId) :- /* if the list is null, the game over*/
		gameOver.			
		
/*Represent a scene with a question and return if the answer is correct or no*/
quizItem(Id) :-
	discipline(Id,Disciplines),write(Disciplines),write('-'),question(Id,Question),write(Question),nl,
	alternative(Id,1,FirstAlternative),write('  1)'),write(FirstAlternative),nl,
	alternative(Id,2,SecondAlternative),write('  2)'),write(SecondAlternative),nl,
	alternative(Id,3,ThirdAlternative),write('  3)'),write(ThirdAlternative),nl,
	alternative(Id,4,FourthAlternative),write('  4)'),write(FourthAlternative),nl,
	write('  5)Terminar Jogo'),nl,
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
	retract(content(Id,_,_,_,_,_,_,_,_,_,_)), /* If the user hit the answer, remove this from database to this dont repeat*/
	write('Voce Acertou'),nl,nl,	
	randomizeId(RandomId),
 	quizEngine(RandomId).
quizEngine(Id) :-
	discipline(Id,Discipline),
	lesson(Id,Lesson),
	page(Id,Page),
	paragraph(Id,Paragraph),
	retract(content(Id,_,_,_,_,_,_,_,_,_,_)),
	assert(recomendations(Id,Discipline,Lesson,Page,Paragraph)), /*If the user dont hit the answer, insert this question Id to the list of recomendations to study*/
	write('Voce Errou'),nl,nl,
	randomizeId(RandomId),		
	quizEngine(RandomId).
	

gameOver :- write('Fim de jogo'),nl,nl,
		write('Sua pontuacao final foi: '),gamePoint(Point),write(Point),nl,nl,
		showRecomendations.

showRecomendations :- findall(NewId,recomendations(NewId,_,_,_,_),Lista),
		%solution(member(CurrentId,Lista),SelectedMember),
		 write('Voce precisa estudar os seguintes itens:'),nl, nl,
		contentRecomendation(CurrentId).
showRecomendations :- write('Parabens, voce acertou tudo e aparentemente nao precisa estudar nada por enquanto'),nl,abort.

/*Recommends one content of accord by of  the Id*/
contentRecomendation(Id) :-
	write('Conteudo da disciplina----'),discipline(Id,Discipline),write(Discipline),nl,
	write('Que esta na Aula----------'),lesson(Id,Lesson),write(Lesson),nl,
	write('Pagina--------------------'),page(Id,Page),write(Page),nl,
	write('Paragrafo-----------------'),paragraph(Id,Paragraph),write(Paragraph),nl,nl,nl,
	retract(recomendations(Id,_,_,_,_)),
	findall(NewId,recomendations(NewId,_,_,_,_),Lista),
	%solution(member(CurrentId,Lista),SelectedMember),
	contentRecomendation(CurrentId).
contentRecomendation(Id) :- 
	abort.

main :- nl,nl,nl,
	write('=================================================='),nl,
	write('============Bem vindo ao QuizComenda=============='),nl,
	write('=================================================='),nl,
	write('Responda as perguntas e iremos te recomendar somente o que voce realmente precisa estudar'),nl,
	write('Economize o seu tempo e esfoco'),nl,nl,
	randomizeId(RandomId),		
	quizEngine(RandomId).

