:- dynamic(cidade/2).
:- dynamic(grafo/2).
:- dynamic(distancia/3).

%%%%%%%%%%%%%%%%%%%%%%%%% Cidades %%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%% Grafo de Romênia %%%%%%%%%%%%%%%%%%%%
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

%%%%% Distância em linha reta até o destino (Bucharest) %%%%%
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
