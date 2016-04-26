/*
	Nome: Walter Nascimento Barroso
	Projeto: Familia.pl
*/

% representação de uma arvore genealogica à qual vamos fazer queries(consultas)

% Fatos:
% homem H é verdadeiro quando H é Masculino
% predicado homem/1
% 1 é o numero de argumentos do predicado e denomina-se de aridade
homem(jose).
homem(carlos).
homem(pedro).
homem(andre).

% mulher F é verdadeiro quando F é feminino
% predicado mulher/1
mulher(ana).
mulher(maria).
mulher(carla).
mulher(sandra).

% progenitor P é verdadeiro quando P é o pai ou é a mae
% predicado progenito/2
% progenitor(progenitor,filho).
progenitor(carlos, jose).
progenitor(maria, jose).
progenitor(pedro, carlos).
progenitor(sandra, carlos).
progenitor(pedro, andre).
% ana é irma de jose
progenitor(maria, ana).
% Ricardo tem avô é o pedro
progenitor(andre, ricardo).
% Ricardo e ana tem avós
progenitor(ana, ricardo).
progenitor(jose, tomaz).

% Regras ( :- se if , e and ; ou or)
%
% Saber se duas pessoas sao irmãos
% Regra - duas pessoas são irmaos se tiverem pelos menos um dos pais comum
irmao(F1, F2) :- progenitor(P1, F1), progenitor(P1, F2).

% Saber que está casado
% Regra - para estar casado tem que ter pelo menos um filho
casado(P1, P2) :- progenitor(P1, Filho), progenitor(P2, Filho).

% Descobrir um dos avos
% Regra - é neto se for filho do filho de alguem (avos)
avo(Avo, Neto) :- progenitor(Avo, Z), progenitor(Z, Neto).
