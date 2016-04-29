ymbol).
   female(symbol).
   father(symbol,symbol).
   husband(symbol,symbol).
   brother(symbol,symbol).
   sister(symbol,symbol).
   listbrothers(symbol).
   listsisters(symbol).
   mother(symbol,symbol).
   grandfather(symbol).
   grandmother(symbol).
   uncle(symbol).
   aunt(symbol).
   cousin(symbol).
   listgrandsons(symbol).
   listgranddaughters(symbol).


   male(dashrath).
   male(ram).
   male(laxman).
   male(bharat).
   male(luv).
   male(kush).
   male(son_of_laxman).

   female(kaushalya).
   female(sita).
   female(urmila).
   female(daughter_of_dashrath).

   father(dashrath,ram).
   father(dashrath,laxman).
   father(dashrath,bharat).
   father(ram,luv).
   father(ram,kush).
   father(laxman,son_of_laxman).
   father(dashrath,daughter_of_dashrath).

   husband(dashrath,kaushalya).
   husband(ram,sita).
   husband(laxman,urmila).

   mother(X,Y):- husband(Z,X),father(Z,Y).

   brother(X,Y):- father(Z,X),father(Z,Y),X=\=Y,male(X).

   sister(X,Y):- father(Z,X),father(Z,Y),X=\=Y,female(X).

   listbrothers(X) :- brother(Z,X),escribe(Z).

   listsisters(X):- sister(Z,X),escribe(Z).

   grandfather(X):-father(Y, Z),father(Z,X),
                   escribe(Y),
		   escribe(' is the grandfather of '),
		   escribe(X),
		   nl.

grandmother(X):-husband(Z,X),
                father(Z,V),
                father(V,Y),
		escribe(Y),
                escribe(' is the grandmother of '),
		escribe(X),
		nl.

listgrandsons(X):-father(X,Z),
                  father(Z,Y),
                  male(Y),
                  escribe(Y),nl,
                  fail.

listgrandsons(X):-husband(Y,X),
                  father(Y,V),
                  father(V,Z),
                  male(Z),
                  escribe(Z),nl,
                  fail.

listgranddaughters(X):-
		  father(X,Z),
                  father(Z,Y),
                  female(Y),
                  escribe(Y),nl,
                  fail.

listgranddaughters(X):-husband(Y,X),
                       father(Y,V),
                       father(V,Z),
                       female(Z),
                       escribe(Z),nl,
                       fail.
uncle(X):-brother(Z,Y),
	  father(Z,X),
          male(Y),
	  escribe(Y),nl,
          fail.

aunt(X):-husband(Z,Y),
         brother(Z,V),
         father(V,X),
         escribe(Y),nl,
         fail.

cousin(X):-father(Z,X),father(V,Y),Z=\=V,brother(V,Z),escribe(Y).


/* pausa <- detiene la ejecucion del programa hasta que se pulse una tecla */
pausa :-nl,write('Pulsa <return> para continuar '),
	skip(10).

/* borraPantalla <- borra la pantalla */
borraPantalla :- borraLinea(25).
borraLinea(1) :- !,nl.
borraLinea(N) :- nl,N1 is N-1,borraLinea(N1).

/*Escribe caracteres*/
escribe([]).
escribe([X|Y]):-
put(X),
escribe(Y).

%-------------------------Muestra mensaje de error---------------------------------
error:-borraPantalla,
       escribe("No escribio un numero"), nl,
       escribe("O el numero escrito no esta en el rango del menu"),
       pausa.


%-------------------------Manejo de opciones Menu Principal---------------------------------%
%
opciones(X):-
(
    (X = 1) ->
    escribe("Escriba el nombre de la persona cuyo padre es que se encuentran:"),nl,
    read(X),
    escribe("Padre "),
    escribe(X),
    escribe(" es:"),nl,
    father(Z,X),
    escribe(Z),nl,
    pausa;
    (X = 2) ->
    escribe("Opcion 2"),nl,
    pausa;
    (X = 3) ->
    escribe("Opcion 3"),nl,
    pausa;
    (X = 4) -> salida

 ).

%-------------------------Menu Principal---------------------------------

menu:-borraPantalla,
      escribe("-----------Menu principal--------------"),nl,
      escribe("Digite su obcion:"),nl,
      tab(10),escribe("1) Opcion 1"),nl,
      tab(10),escribe("2) Opcion 2"),nl,
      tab(10),escribe("3) Opcion 3"),nl,
      tab(10),escribe("4) Salir"),nl,
      escribe("Su opcion es: "), read(X),
      opciones(X),
menu.

