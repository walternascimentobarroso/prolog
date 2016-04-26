:- use_module(library(pce)).

alo_mundo :-
        % criacao da janela
        new(D, window('Minha primeira janela')),
        % redefine o tamanho da janela
        send(D, size, size(250, 100)),
        % cria um texto na janela
        new(T, text('Hello World !')),
        % mostra o texto na posicao desejada
        send(D, display, T, point(80, 40)),
        % mostra a janela
        send(D, open).
