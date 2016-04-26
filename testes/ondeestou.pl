:- dynamic estou/1.
% declara modificação dinâmica
estou(paulista).
ando(Destino) :-
retract(estou(Origem)),
asserta(estou(Destino)),
format('Ando da ~w até a ~w',[Origem,Destino]).
