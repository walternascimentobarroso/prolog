:- dynamic(stand/2).
% 1: representacao da base de dados
stand(vegas,[
cliente(rui,2324,23,medico,[ carro(audi,a2,20000),
     carro(bmw,serie3,30000)]),
cliente(rita,2325,32,advogado,[carro(audi,a3,30000)]),
cliente(joao,2326,26,professor,[moto(honda,gl1800,26000)]),
cliente(ana,2327,49,medico,[
carro(audi,a4,40000),
carro(bmw,serie3,32000),
carro(ford,focus,24000)])
]).
stand(miami,[ 
cliente(rui,3333,33,operario,[carro(fiat,panda,12000)]),
cliente(paulo,3334,22,advogado,[carro(audi,a4,36000)]),
cliente(pedro,3335,46,advogado,[carro(honda,accord,32000),
        carro(audi,a2,20000)])
      ]).
% 2.1: devolve a lista com o nome de todos os clientes de um stand
listar_clientes(X,LC) :-
stand(X,L),
findall(C,member(cliente(C,_,_,_,_),L),LC).
% 2.2: devolve os dados de cliente (todos excepto o nome): 
listar_dados(X,C,D) :-
stand(X,L),
findall((N,ID,P),member(cliente(C,N,ID,P,_),L),D).
% 2.3: 
listar_carros(X,LM) :-
stand(X,L),
findall(C,member(cliente(_,_,_,_,C),L),LC),
      flatten(LC,LCC),
      findall(M,member(carro(M,_,_),LCC),LM1),
list_to_set_(LM1,LM).
% 2.4:
listar_advogados(LA) :-
findall(L,stand(_,L),LL),
flatten(LL,LL2),
findall(C,member(cliente(C,_,_,advogado,_),LL2),LA1),
      list_to_set_(LA1,LA).
% 2.5: 
preco_medio(X,Med) :-
stand(X,L),
findall(C,member(cliente(_,_,_,_,C),L),LP),
      flatten(LP,LP2),
      findall(P,member(carro(_,_,P),LP2),LP3),
media(Med,LP3).
% 2.6:
altera_id(X,C,Id) :-
retract(stand(X,L)),
altera_id(L,L2,C,Id),
assert(stand(X,L2)). 
% predicado auxiliar:
altera_id(L,L2,C,NID) :-
 select(cliente(C,N,_,P,V),L,L1),
append([cliente(C,N,NID,P,V)],L1,L2).
% exemplo de um teste deste programa:
teste :-
write('mudar idade da ana\nde:'),
  listar_dados(vegas,ana,D),write(D),
        altera_id(vegas,ana,50),listar_dados(vegas,ana,D1),
write(' para: '),write(D1).
