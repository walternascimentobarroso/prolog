% Algoritmo A*
% author: Walter Nascimento Barroso

% Cidades
cidade(1,'Arad').
cidade(2,'Bucharest').
cidade(3,'Craiova').
cidade(4,'Dobreta').
cidade(5,'Eforie').
cidade(6,'Fagaras').
cidade(7,'Giurgiu').
cidade(8,'Hirsova').
cidade(9,'Iasi').
cidade(10,'Lugoj').
cidade(11,'Mehadia').
cidade(12,'Neamt').
cidade(13,'Oradea').
cidade(14,'Pitesti').
cidade(15,'Rimnicu Vilcea').
cidade(16,'Sibiu').
cidade(17,'Timisoara').
cidade(18,'Urziceni').
cidade(19,'Vaslui').
cidade(20,'Zerind').

% grafo de Romênia
grafo(13,20,71).
grafo(13,16,151).
grafo(20,1,75).
grafo(1,17,118).
grafo(1,16,140).
grafo(17,10,111).
grafo(10,11,70).
grafo(11,4,75).
grafo(16,6,99).
grafo(16,15,80).
grafo(15,14,97).
grafo(15,3,146).
grafo(3,4,120).
grafo(6,2,211).
grafo(14,3,138).
grafo(14,2,101).
grafo(2,7,90).
grafo(2,18,85).
grafo(18,8,98).
grafo(8,5,86).
grafo(18,19,142).
grafo(19,9,92).
grafo(9,12,87).

% Distância em linha reta até o destino (Bucharest)
distancia(1,2,366).
distancia(2,2,0).
distancia(3,2,160).
distancia(4,2,242).
distancia(5,2,161).
distancia(6,2,176).
distancia(7,2,77).
distancia(8,2,151).
distancia(9,2,226).
distancia(10,2,244).
distancia(11,2,241).
distancia(12,2,234).
distancia(13,2,380).
distancia(14,2,100).
distancia(15,2,193).
distancia(16,2,253).
distancia(17,2,329).
distancia(18,2,80).
distancia(19,2,199).
distancia(20,2,374).

% Obter distância
obterDistancia(Origem, Destino, LinhaReta) :-
 distancia(Origem, Destino, LinhaReta).
obterDistancia(Origem, Destino, LinhaReta) :-
 !,distancia(Destino, Origem, LinhaReta).

% Regra principal do programa
encontrarCaminho(Origen, Destino) :-
 cidade(C1,Origen),
 cidade(C2,Destino),
 buscaHeuristica([[0,C1]],CaminhoInvertido,C2),
 inverterCaminho(CaminhoInvertido, Caminho),
 imprimirCaminho(Caminho).

% Caso exista algum ponto isolado
encontrarCaminho(_,_) :-
 write('Este Caminho não existe.').

% Condição de parada de busca heurística
buscaHeuristica(Caminhos, [Custo,Destino|Caminho], Destino) :-
 membro([Custo,Destino|Caminho],Caminhos),
 escolherProximo(Caminhos, [Custo1|_], Destino),
 Custo1 == Custo.

buscaHeuristica(Caminhos, Solucao, Destino) :-
 escolherProximo(Caminhos, Prox, Destino),
 removerCaminho(Prox, Caminhos, CaminhosRestantes),
 estenderProximoCamino(Prox, NovosCaminhos),
 concatenarCaminhos(CaminhosRestantes, NovosCaminhos, ListaCompleta),
 buscaHeuristica(ListaCompleta, Solucao, Destino).

% Obter todos os caminhos até agora e executa comparações. Só pára quando é o caminho mais curto (menor custo) 

escolherProximo([X],X,_) :- !.

escolherProximo([[Custo1,Cidade1|Resto1],[Custo2,Cidade2|_]|Cola], MelhorCaminho, Destino) :-
 obterDistancia(Cidade1, Destino, Avaliacao1),
 obterDistancia(Cidade2, Destino, Avaliacao2),
 Avaliacao1 +  Custo1 =< Avaliacao2 +  Custo2,
 escolherProximo([[Custo1,Cidade1|Resto1]|Cola], MelhorCaminho, Destino).

escolherProximo([[Custo1,Cidade1|_],[Custo2,Cidade2|Resto2]|Cola], MelhorCaminho, Destino) :-
 obterDistancia(Cidade1, Destino, Avaliacao1),
 obterDistancia(Cidade2, Destino, Avaliacao2),
 Avaliacao1  + Custo1 > Avaliacao2 +  Custo2,
 escolherProximo([[Custo2,Cidade2|Resto2]|Cola], MelhorCaminho, Destino).

estenderProximoCamino([Custo,No|Caminho],NovosCaminhos) :-
 findall([Custo,NovoNo,No|Caminho], (verificarMovimiento(No, NovoNo,_),not(membro(NovoNo,Caminho))), ListaResultante),
 atualizaCustoCaminhos(ListaResultante, NovosCaminhos).


% Atualiza os custos dos caminhos
atualizaCustoCaminhos([],[]) :- !.
atualizaCustoCaminhos([[Custo,NovoNo,No|Caminho]|Cola],[[NovoCusto,NovoNo,No|Caminho]|Cauda1]):-
 verificarMovimento(No, NovoNo, Distancia),
 NovoCusto is Custo + Distancia,
 atualizaCustoCaminhos(Cola,Cauda1).


verificarMovimento(Origem, Destino, Distancia) :-
 grafo(Origem, Destino, Distancia).
verificarMovimento(Origem, Destino, Distancia) :-
 grafo(Destino, Origem, Distancia).


inverterCaminho([X],[X]).
inverterCaminho([X|Y],Lista) :- inverterCaminho(Y,ListaInt),
        concatenarCaminhos(ListaInt,[X],Lista).


concatenarCaminhos([],L,L).
concatenarCaminhos([X|Y],L,[X|Lista]):- concatenarCaminhos(Y,L,Lista).


removerCaminho(X,[X|T],T) :- !.
removerCaminho(X,[Y|T],[Y|T2]) :- removerCaminho(X,T,T2).



% imprime o resultado
imprimeCaminho([Custo]):-
 nl,
 write('A distância total percorrida foi de: '),
 write(Custo),
 write(' km.').


imprimeCaminho([CidadeAtual|Cola]):-
 cidade(CidadeAtual, X),
 write(X),
 write(', '),
 imprimeCaminho(Cola).


imprimeCaminho([CidadeAtual|Cola]):- write('Caminho a percorrer: '),
    imprimeCaminho([CidadeAtual|Cola]).



