menu:-repeat,
      write('Quer ou não quer?'),nl,
      write('1 - Sim'),nl,
      write('2 - Não'),nl,
      write('0 - Sair'),nl,
      read(Opcao),
      rule(Opcao),
      Opcao==0, !, abort.

rule(1):-1 is 1, write('1'), !.
rule(2):-2 is 2, write('2'), !.
rule(0):-!.
rule(_):-write('Opção inválida!'), nl.



euro:-
    write('1 - Adicionar nova equipa'),nl,
    write('2 - Remover equipa'),nl,
    write('stop - para sair'),nl,
    write('Escolha uma opcao'),nl,
    read(X),
    write(X),
    verifica(X),  
    X==stop,!,writeln('Fim').    

verifica(1):-writeln('add'),nl,!.
verifica(2):-writeln('remove'),nl,!.
verifica(stop):-!.
