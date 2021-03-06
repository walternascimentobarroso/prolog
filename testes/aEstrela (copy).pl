:- initialization
   format('A* em prolog!~n').

:- include(romenia).

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
 member([Custo,Destino|Caminho],Caminhos),
 escolherProximo(Caminhos, [Custo1|_], Destino),
 Custo1 == Custo.

buscaHeuristica(Caminhos, Solucao, Destino) :-
 escolherProximo(Caminhos, Prox, Destino),
 removerCaminho(Prox, Caminhos, CaminhosRestantes),
 estenderProximoCaminho(Prox, NovosCaminhos),
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

estenderProximoCaminho([Custo,No|Caminho],NovosCaminhos) :-
 findall([Custo,NovoNo,No|Caminho], (verificarMovimento(No, NovoNo,_),not(member(NovoNo,Caminho))), ListaResultante),
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


imprimirCaminho([CidadeAtual|Cola]):- write('Caminho a percorrer: '),
    imprimeCaminho([CidadeAtual|Cola]).


%-------------------------Menu Principal---------------------------------

menu:-
      write("-----------Menu principal--------------"),nl,
      write("Digite su obcion:"),nl,
      tab(10),write("1) Opcion 1"),nl,
      tab(10),write("2) Opcion 2"),nl,
      tab(10),write("3) Opcion 3"),nl,
      tab(10),write("4) Salir"),nl,
      write("Su opcion es: "), read(X),
      opciones(X),
menu.

pausa :-nl,write('Pulsa <return> para continuar '),
skip(10).

opciones(X):-
(
    (X = 1) -> 
	write("Escreva:"),nl,
	read(X),
	write("Padre "),
	read(X),
	write(" es:"),nl,
	read(X),
	pausa;
    (X = 2) ->
	write("Opcion 2"),nl,
	read(X),
	pausa;
    (X = 3) ->
	write("Opcion 3"),nl,
	read(X),
	pausa;
    (X = 4) -> abort

).
