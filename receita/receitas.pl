refeicao :- cardapio(Comida, Comida_img),
		write('Eh possivel fazer: '),
		write(Comida),
		nl,
		undo,
		shell(Comida_img); write('Se nao tiver miojo vai ficar com fome.').


/* cardaios */
cardapio(bolo_chocolate, 'xdg-open bolo_chocolate.pdf') :- bolo_chocolate, !.
cardapio(bolo_cenoura, 'xdg-open bolo_cenoura.pdf') :- bolo_cenoura, !.
cardapio(bolo_fuba, 'xdg-open bolo_fuba.pdf') :- bolo_fuba, !.
cardapio(torta_alema, 'xdg-open torta_alema.pdf') :- torta_alema, !.
cardapio(torta_limao, 'xdg-open torta_limao.pdf') :- torta_limao, !.
cardapio(escondidinho_carne, 'xdg-open escondidinho_carne.pdf') :- escondidinho_carne, !.
cardapio(rabada, 'xdg-open rabada.pdf') :- rabada, !.
cardapio(tilapia_assada, 'xdg-open tilapia_assada.pdf') :- tilapia_assada, !.
cardapio(lagosta_ao_creme, 'xdg-open lagosta_ao_creme.pdf') :- lagosta_ao_creme, !.
cardapio(macarronada, 'xdg-open macarronada.pdf') :- macarronada, !.
cardapio(panqueca_americana, 'xdg-open panqueca_americana.pdf') :- panqueca_americana, !.




/* ingredientes da refeicao */
bolo_chocolate :- leite,
					ovo,
					margarina,
					acucar,
					farinha_trigo,
					fermento,
					chocolate_po.

bolo_cenoura :- leite,
				ovo,
				margarina,
				acucar,
				farinha_trigo,
				fermento,
				cenoura.

bolo_fuba :- leite,
			ovo,
			margarina,
			acucar,
			farinha_trigo,
			fermento,
			fuba.

torta_alema :- leite,
			ovo,
			acucar_refinado,
			manteiga_sem_sal,
			creme_de_leite,
			essencia_de_baunilha,
			licor_de_chocolate,
			biscoito_de_maizena.

torta_limao :- ovo,
			margarina,
			acucar,
			creme_de_leite,
			leite_condensado,
			limao,
			biscoito_de_maizena.

escondidinho_carne :- leite,
			carne_moida,
			queijo,
			azeite,
			cebola,
			alho,
			pimenta,
			cheiro_verde,
			batata,
			manteiga.

rabada :- carne_rabada,
			oleo,
			agriao,
			cebola,
			alho.

tilapia_assada :- tilapia,
			limao,
			tomate,
			cebola,
			batata,
			salsa,
			azeite.

lagosta_ao_creme :- leite,
			alho,
			tomate,
			cebola,
			lagosta,
			amido_milho,
			milho,
			sal,
			caldo_galinha,
			azeite.

macarronada :- macarrao,
			molho_tomate,
			ervilha,
			creme_de_leite,
			milho.

panqueca_americana :- leite,
			ovo,
			fermento,
			manteiga,
			acucar,
			sal,
			oleo.



/* regras de verificacao */
sal :- verificar('sal').
molho_tomate :- verificar('molho_tomate').
macarrao :- verificar('macarrao').
ervilha :- verificar('ervilha').
lagosta :- verificar('lagosta').
amido_milho :- verificar('amido de milho').
milho :- verificar('milho').
caldo_galinha :- verificar('cubo de caldo de galinha').
tilapia :- verificar('tilapia').
tomate :- verificar('tomate').
salsa :- verificar('salsa').
carne_rabada :- verificar('rabada').
oleo :- verificar('oleo').
agriao :- verificar('agriao').
batata :- verificar('batata').
carne_moida :- verificar('carne moida').
queijo :- verificar('queijo').
azeite :- verificar('azeite').
cebola :- verificar('cebola').
alho :- verificar('alho').
pimenta :- verificar('pimenta').
cheiro_verde :- verificar('cheiro verde').
leite :- verificar('leite').
ovo :- verificar('ovo').
margarina :- verificar('margarina').
acucar :- verificar('acucar').
chocolate_po :- verificar('chocolate em po').
farinha_trigo :- verificar('farinha de trigo').
fermento :- verificar('fermento').
cenoura :- verificar('cenoura').
fuba :- verificar('fuba').
manteiga :- verificar('manteiga').
manteiga_sem_sal :- verificar('manteiga sem sal').
acucar_refinado :- verificar('acucar refinado').
creme_de_leite :- verificar('creme de leite').
essencia_de_baunilha :- verificar('essencia de baunilha').
licor_de_chocolate :- verificar('licor de chocolate').
biscoito_de_maizena :- verificar('biscouto de maizena').
leite_condensado :- verificar('leite condensado').
limao :- verificar('limao').

/* perguntas */
pergunta(Ingreditente) :-
	write('Voce tem '),
	write(Ingreditente),
	write(' na dispensesa? '),
	read(Resposta),
	nl,
	( (Resposta == sim ; Resposta == s)
		->
		assert(sim(Ingreditente)) ;
		assert(nao(Ingreditente)), fail).

:- dynamic sim/1, nao/1.

/* verificar */
verificar(X) :-
	(sim(X)	->	true ;	(nao(X)	 ->	 fail ;	 pergunta(X))).

/* limpar os asserts */
undo :- retract(sim(_)), fail.
undo :- retract(nao(_)), fail.
undo.



/* menu:-  repeat, */
/* 	write('=== RECEITAS ==='), nl, */
/*     write('>>O que voce quer preparar?'),nl, */
/* 	write('1. Bolos e Tortas'), nl, */
/* 	write('2. Carnes'), nl, */
/* 	write('3. Aves'), nl, */
/* 	write('4. Peixes'), nl, */
/* 	write('5. Saladas e Molhos'), nl, */
/* 	write('6. Sopas'), nl, */
/* 	write('7. Massas'), nl, */
/* 	write('8. Bebidas'), nl, */
/* 	write('9. Doces'), nl, */
/*     write('0. Sair'), nl, */
/* 	read(X), */
/* 	option(X), */
/* 	X==0, */
/* 	!. */

/* option(0):- !. */
/* option(1):- write('Quais ingredientes você tem?'), nl, !. */
/* option(2):- write('Quais ingredientes você tem?'), nl, !. */
/* option(_):- write('Digite uma opcao valida.'), nl, !. */

/* %sopas(NOME DA SOPA,INGREDIENTES....). */


/* sopas() */
/* sopaCremosaDeAbobrinha(abobrinha,batata,cebola,alho,leite,cremeDeLeite,amidoDeMilho,sal,pimentaDoReino). */

/* sopaDeFrangoComLeiteDeCoco(PeitoDeFrango,agua,leiteDeCoco,cebola,azeiteDeOliva,macarraoConchinha,coentro,pimentaDedoDeMoca,cafe,sal). */

/* sopaDeCebola(cebola,margarina,caldoDeLegumes,mussarela,agua,farinaDeTrigo,sal,pimentaDoReino). */

/* canjaDeGalinha(alho,cebola,tomateSemCasca,frango,cremeDeCebola,cebolinha,sal,pimenta,limao,chicoria,molhoDeTomate,arroz). */
