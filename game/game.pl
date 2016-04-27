/*  */

/* ********************************************************************** */
/* This is the implementation of an Adventure game by Amzi! Prolog 	  */
/* 									  */
/* It has been modified to run on the SWI Web App Platform and feed data  */
/* to the Jcubic -JQuery-Terminal Framework.				  */
/* ********************************************************************** */

% To start the server (and the game) at the command line execute this command: server(5000).


/* Module Section */

% :- module(http_daemon, []).
% :- use_module(library(http/http_unix_daemon)).  % UNIX Daemon Library
% :- use_module(library(debug)).		  % Debug Library
:- use_module(library(http/thread_httpd)).	  % HTTP Multi-threaded library
:- use_module(library(http/http_dispatch)).	  % HTTP Dispatch Library
:- use_module(library(http/http_error)).	  % HTTP Error Library
:- use_module(library(http/html_write)).	  % HTML write library
:- use_module(library(http/http_parameters)).	  % HTTP parameters library
:- use_module(library(http/http_session)).	  % HTTP sessions library
:- use_module(library(http/http_client)). 	  % HTTP client library for http_read_data


%:- initialization http_daemon.			  % Initialize the UNIX Daemon 


/* ************************************************************* */
/* Handler Section:
   This section houses the handler for the 3 pages comprising 
   the game. When it was clear that the JCubic -JQuery-Terminal
   interface was actually going to work in an acceptable way then
   the only page that was to be relevant any longer was the /game
   page. I do keep the other around just for posterity sake.     */
/* ************************************************************* */

:- http_handler('/', launch_page, []).			% The game launch page - [Deprecated]
:- http_handler('/game', game_page, []).		% The landing page for form submissions - [Active]
:- http_handler('/game_over', game_over_page, []).	% The landing page for game completion - [Deprecated]
:- http_handler('/game_quit', game_quit_page, []).	% The landing page for game quit - [Deprecated]


/* Server Port Section */
server(Port) :- http_server(http_dispatch, [port(Port)]).


/* ************************************************************* */
/* Launch Page Section:  - [Deprecated]
   This is the construction of the games launch page.            */
/* ************************************************************* */
   
launch_page(Request) :-
	reply_html_page(
	   title('Adventure Game'),   			% Title

	   [
	   \page_content_banner(Request),		% Banner content
	   \command_execution_form(Request),		% Form content
	   \introduction_text(Request)			% Intro text
	   ])
	   .

/* ************************************************************* */
/* Game Page Section:
   This is where the program goes after every (command) form 
   submission of a game command. In a very real sense, this 
   section is the equivalent of the COMMAND LOOP in modern games. 
   Note: The http_parameters code throws an exception if it's 
   input data is uninstantiated so it's imperative to surround the 
   code with a catch block. I inject a simple space as the recovery
   which effectively solves the problem.                         */
/* ************************************************************* */


game_page(Request) :-
	gamestart, % Checks if the game has been started, if not create the state, if so, does nothing.
	catch(http_parameters(Request, [command(Command,[])]), error(Err,_Context), Command = ' '),
	reply_html_page(
	   [title('Adventure Game')],
	   [
	   \page_content_banner(Request),
	   \command_execution_form(Request)
	   ]),
	   
	   % ****** Effectively Command Loop stuff below **************************************************
	   atomic_list_concat(L,' ', Command),	% reads the Command Variable and puts ... [it,in,list,form]
	   get_command(C, L), 			% Simple English command interpreter - give it a list, 
						% returns this programs internal command. 
	   do(C)				% Execute the program internal equivalent.
	   .		   
	   

	 
/* Game Over Page Section: - [Deprecated]
   This is where the program goes after the player wins. */	 
	 
game_over_page(Request) :-	   
	   reply_html_page(
	   title('Adventure Game'),   			% Title
	   [
	   \page_content_banner(Request),		% Banner content
	   \game_over_page_content(Request)		% Body content
	   ])  
	   .
	   	   
	   
/* Game Quit Page Section: - [Deprecated]
   This is where the program goes after the player quits. */	 
	 
game_quit_page(Request) :-	   
	   reply_html_page(
	   title('Adventure Game'),   			% Title
	   [
	   \page_content_banner(Request),		% Banner content
	   \game_quit_page_content(Request)		% Body content
	   ])  
	   .	   
	   
	   
/* ************************************************************* */	   
/* DGC Section:
   This is where the DGC's get expanded prior to being called.   
   by the above code segments. 					 */
/* ************************************************************* */	
   
   
/* This gets called as a general heading banner of the game. */   
page_content_banner(_Request) -->
	html(
	   [h1('Adventure Game')]).   
   

   
/* This gets called as when the players wins the game. - [Deprecated] */   
game_over_page_content(_Request) -->
	html(
	   [p('Congratulations, you saved the Nani!')]).
	   
	   
	   
/* This gets called when the player quits the game.  - [Deprecated] */   
game_quit_page_content(_Request) -->
	html(
	   [p('Giving up?  It''s going to be a scary night...')]).	   
	   
	   
	   
/*  This gets called after every form submission. */

/* It is the Command Submission Form, every user 
   command given to the system goes through this 
   interface. This is also the interface that the 
   PHP cURL code of the JQuery-Terminal
   interface submits to when processing game commands. */
	   
command_execution_form(_Request) -->
	html(
	   [	   
	     form([action='/game', method='POST'], [
		p([], [
		  label([for=command],'command: '),
		  input([name=command, type=textarea])
		      ]),
		p([], input([name=submit, type=submit, value='Submit'], []))
	      ])
	      
	   ]).


	    

/* ************************************************************* */
/* Content Section:
   This is where static content gets created. It *has* to be written
   to the screen as opposed to formatted or created as HTML 
   because the JQuery-Terminal interface requires it that way.   */
/* ************************************************************* */


% The introductory game text 

intro :- 
write('NANI SEARCH - A Sample Adventure Game'), nl,
write('Copyright (C) Amzi! inc. 1990-2010'), nl,
write('No rights reserved, use it as you wish '), nl, nl,

write('Nani Search is designed to illustrate Prolog programming.'), nl,
write('As such, it might be the simplest adventure game.'), nl, nl,

write('Your persona as the adventurer is that of a three year'), nl,
write('old.  The Nani is your security blanket.  It is getting'), nl,
write('late and you''re tired, but you can''t go to sleep'), nl,
write('without your Nani.  Your mission is to find the Nani.'), nl, nl,

write('You control the game by using simple English commands'), nl,
write('expressing the action you wish to take.  You can go to'), nl,
write('other rooms, look at your surroundings, look in things'), nl,
write('take things, drop things, eat things, inventory the'), nl,
write('things you have, and turn things on and off.'), nl,

write('Hit any key to continue.'), nl,
write('Type "help" if you need more help on mechanics.'), nl,
write('Type "hint" if you want a big hint.'), nl,
write('Type "quit" if you give up.'), nl, nl,

write('Enjoy the hunt!'), nl     
.	   
	   
	   
% The help command

nshelp :-
write('Use simple English sentences to enter commands.'),nl,
write('The commands can cause you to:'),nl,
write('   go to a room          (ex. go to the office)'),nl,
write('   look around           (ex. look)'),nl,
write('   look in something     (ex. look in the desk)'),nl,
write('   take something        (ex. take the apple)'),nl,
write('   eat something         (ex. eat the apple)'),nl,
write('   turn something on     (ex. turn on the light)'),nl,
write('   inventory your things (ex. inventory)'),nl,
write('   inventory your things (ex. inventory)'),nl,
write('The examples are verbose, terser commands and synonyms'),nl,
write('are usually accepted.'),nl,
write('Type "hint" if you want a big hint.'),nl,
write('Type "quit" if you give up.'),nl      
.


% The hint command
  
hint :-  
write('You need to get to the cellar, and you can''t unless'),nl,
write('you get some light.  You can''t turn on the cellar'),nl,
write('light, but there is a flash light in the desk in the'),nl,
write('office you might use.'),nl      
.

 
/* ************************************************************* */
/* Game Control section:	
   These are the predicates which control exit from the game. If
   the player has taken the nani, then the call to "have(nani)" 
   will	succeed and the (web modified) command_loop will complete.
   Otherwise it fails and command_loop will repeat.              */
/* ************************************************************* */ 

	    

% GameStart Predicate - if game hasn't started, init KB, it must always succeed w/true or it'll
% break the html_reply_page handler predicate. This calls the 'begin predicate defined below.
% ===> begin :- clear_state, init_dynamic_facts, intro.

gamestart :- not(current_predicate(game_state/1)) -> begin; true.
 
 
% GameWon Predicate - if game won, writes congrats msg, options to begin again, must always succeed w/true.
% gamewon :- have(nani) -> http_redirect(moved, '/game_over', Result); true. <= Used in old html version.

gamewon :- have(nani) -> congrats; true.
congrats :- nl, write('Congratulations, you saved the Nani!'),nl,write('Type "begin" to play again ... ').


% The Quit predicate - writes condolences msg, executes begin predicate.
% quit:- http_redirect(moved, '/game_quit', Result).  <= Used in old html version.

quit :-  condolences.
condolences :- nl, write('Giving up?  It''s going to be a scary night...'),nl,nl,nl,write('Type "begin" to play again ... ').


% respond simplifies writing a mixture of literals and variables
 
respond([]):-    write('.'),nl,nl.
respond([H|T]):- write(H), respond(T).	    
	    
	    
	    
% Simple English command listener.  It does some semantic checking
% and allows for various synonyms.  Within a restricted subset of
% English, a command can be phrased many ways.  Also non grammatical
% constructs are understood, for example just giving a room name
% is interpreted as the command to goto that room.

% Some interpretation is based on the situation.  Notice that when
% the player says turn on the light it is ambiguous.  It could mean
% the room light (which can't be turned on in the game) or the
% flash light.  If the player has the flash light it is interpreted
% as flash light, otherwise it is interpreted as room light.
	    
% atomic_list_concat(L,' ', Command),	% reads the Command Variable and puts ... [it,in,list,form]
% Note: priot to get_command(C, L) being called, atomic_list_concat is called to convert the natural
% language to [a,list,of,this,form] so get_command(C, L) can use it properly.

	    
get_command(C, L):-	% Modified from original predicate, takes a 'proper' list and 'receives' a program command in return.
  			% write(C), nl,	==> % Debug  - write out the returned command
  command(X,L,[]),    	% call the DCG grammar for command
  C =.. X,!.           	% make the command list a structure
  			% write(X).     ==> % Debug - write out the list structure for inspection

  % Note: I took out the 'fail' predicate at the end of this line because it crashed the  reply_html_page predicate.
  %       I also set the command to a non-command to fix the errant backtracking through the predicates problem when
  % 	  a non command was encountered since it did not break the reply_html_page predicate in the process: 
  %       C = [notinlexicon].

 get_command(C, L):- write('I don''t understand, try again or type help. '), C = [notinlexicon], !.
  
  
  
% do - matches the input command with the predicate which carries out
%     the command.  More general approaches which might work in the
%     listener are not supported in the compiler.  This approach
%     also gives tighter control over the allowable commands.

%     The cuts prevent the forced failure at the end of "command_loop"
%     from backtracking into the command predicates.

do(goto(X)):-goto(X),!.
do(nshelp):-nshelp,!.
do(hint):-hint,!.
do(inventory):-inventory,!.
do(take(X)):-take(X), gamewon, !.
do(drop(X)):-drop(X),!.
do(eat(X)):-eat(X),!.
do(look):-look,!.
do(turn_on(X)):-turn_on(X),!.
do(turn_off(X)):-turn_off(X),!.
do(look_in(X)):-look_in(X),!.
do(quit):-quit,!.
do(begin) :- begin,!.
do(_) :- nl, write('I don''t know how to do that.'). 	    
	    
	    
/* ********************************************************************************/ 
/* Environment section:	Static facts which do not change during program execution */
/* ********************************************************************************/ 	    
	    
% Initial facts describing the world. Rooms, doors, etc do not change, 
% so they are compiled.

light(kitchen).

room(office).
room(kitchen).
room('dining room').
room(toilet).
room(hall).
room(cellar).

door(office,hall).
door(hall,'dining room').
door('dining room',kitchen).
door(kitchen,cellar).
door(kitchen,office).

furniture(desk).
furniture('washing machine').
furniture(table).

edible(apple).
edible(crackers).

tastes_yuchy(broccoli).	    

connect(X,Y):- door(X,Y).
connect(X,Y):- door(Y,X).


/* ********************************************************************************************** */ 
/* Environment section:	Dynamic facts and predicated which change often so they must be asserted. */
/* ********************************************************************************************** */ 

% These facts are all subject to *change* during the game, so rather
% than being compiled, they are "asserted" to the listener at
% run time.  This predicate is called when the game starts up.

init_dynamic_facts:-
  assertz(game_state(in_progress)),
  assertz(have(slippers)),
  assertz(location(desk,office)),
  assertz(location(apple,kitchen)),
  assertz(location(flashlight,desk)),
  assertz(location('washing machine',cellar)),
  assertz(location(nani,'washing machine')),
  assertz(location(table,kitchen)),
  assertz(location(crackers,desk)),
  assertz(location(broccoli,kitchen)),
  assertz(here(kitchen)),
  assertz(turned_off(flashlight)),
  assertz(turned_on(light(kitchen))
  ).


% Clear State: This predicate clears the current state of the game 
% and reasserts the KB in route to beginning a new game. 

clear_state :- retractall(have(_)), 
	       retractall(game_state(_)), 
	       retractall(location(_,_)), 
	       retractall(here(_)), 
	       retractall(turned_off(_)),
	       retractall(turned_on(_)).	    


%%%%%%%%%%%%%%%%%%% COMMANDS %%%%%%%%%%%%%%%%%%%%%%%

% goto moves the player from room to room.

goto(Room):-
  can_go(Room),                 % check for legal move
  puzzle(goto(Room)),           % check for special conditions
  moveto(Room),                 % go there and tell the player
  look.
goto(_):- look.			% Each time players goes anywhere, look around.

can_go(Room):-                  % if there is a connection it, then  
  here(Here),                   % is a legal move.
  connect(Here,Room),!.
can_go(Room):-
  respond(['You can''t get to ',Room,' from here']),fail.

moveto(Room):-                  % update the logic base with the new room
  retract(here(_)),             
  asserta(here(Room)).


% Look lists the things in a room, and the connections

look:-
  here(Here),
  respond(['You are in the ',Here]),
  format('You can see the following things:'), nl,  
  list_things(Here),nl,
  format('You can go to the following rooms:'), nl, 
  list_connections(Here).

list_things(Place):-
  location(X,Place),
  tab(2),write(X),nl,
  fail.
list_things(_).

list_connections(Place):-
  connect(Place,X),
  tab(2),write(X),nl,
  fail.
list_connections(_).


% look_in - allows the player to look inside a thing which might contain other things

look_in(Thing):-
  location(_,Thing),               % make sure there's at least one
  write('The '),write(Thing),write(' contains:'),nl,
  list_things(Thing).
look_in(Thing):-
  respond(['There is nothing in the ',Thing]).

% take - allows the player to take something.  As long as the thing is
% contained in the room it can be taken, even if the adventurer hasn't
% looked in the the container which contains it.  Also the thing
% must not be furniture.

take(Thing):-
  is_here(Thing),
  is_takable(Thing),
  move(Thing,have),
  respond(['You now have the ',Thing]).

is_here(Thing):-
  here(Here),
  contains(Thing,Here),!.          % don't backtrack
is_here(Thing):-
  respond(['There is no ',Thing,' here']),
  fail.

contains(Thing,Here):-             % recursive definition to find
  location(Thing,Here).            % things contained in things etc.
contains(Thing,Here):-
  location(Thing,X),
  contains(X,Here).

is_takable(Thing):-                % you can't take the furniture
  furniture(Thing),
  respond(['You can''t pick up a ',Thing]),
  !,fail.
is_takable(_).                     % not furniture, OK to take

move(Thing,have):-
  retract(location(Thing,_)),      % take it from its old place
  asserta(have(Thing)).            % and add to your possessions

% drop - allows the player to transfer a possession to a room

drop(Thing):-
  have(Thing),                     % you must have the thing to drop it
  here(Here),                      % where are we
  retract(have(Thing)),
  asserta(location(Thing,Here)).
drop(Thing):-
  respond(['You don''t have the ',Thing]).


% eat, because every adventure game lets you eat stuff.

eat(Thing):-
  have(Thing),
  eat2(Thing).
eat(Thing):-
  respond(['You don''t have the ',Thing]).
  
eat2(Thing):-
  edible(Thing),
  retract(have(Thing)),
  respond(['That ',Thing,' was good']).
eat2(Thing):-
  tastes_yuchy(Thing),
  respond(['Three year olds don''t eat ',Thing]).
eat2(Thing):-
  respond(['You can''t eat a ',Thing]).

% inventory - list your possessions

inventory:-
  have(X),                         % make sure you have at least one thing
  write('You have: '),nl,
  list_possessions.
  
inventory:-  write('You have nothing. '),nl, nl.

list_possessions:- have(X), tab(2),write(X),nl, fail.
list_possessions.

% turn_on recognizes two cases.  If the player tries to simply turn
% on the light, it is assumed this is the room light, and the
% appropriate error message is issued.  Otherwise turn_on has to
% refer to an object which is turned_off.

turn_on(light):-
  respond(['You can''t reach the switch and there''s nothing to stand on']).
turn_on(Thing):-
  have(Thing),
  turn_on2(Thing).
turn_on(Thing):-
  respond(['You don''t have the ',Thing]).

turn_on2(Thing):-
  turned_on(Thing),
  respond([Thing,' is already on']).
turn_on2(Thing):-
  turned_off(Thing),
  retract(turned_off(Thing)),
  asserta(turned_on(Thing)),
  respond([Thing,' turned on']).
turn_on2(Thing):-
  respond(['You can''t turn a ',Thing,' on']).


% turn_off - I didn't feel like implementing turn_off

turn_off(Thing):-
  respond(['I lied about being able to turn things off']).


% begin - is called when a player quits, wins or the a new gets initialized.
% It clears the state, recreates the KB (and the state), and displays an intro.
begin :- clear_state, init_dynamic_facts, intro.


% The only special puzzle in Nani Search has to do with going to the
% cellar.  Puzzle is only called from goto for this reason.  Other
% puzzles pertaining to other commands could easily be added.

puzzle(goto(cellar)):-
  have(flashlight),
  turned_on(flashlight),!.
  
puzzle(goto(cellar)):-
  write('You can''t go to the cellar because it''s dark in the'),nl,
  write('cellar, and you''re afraid of the dark!'),nl,
  !,fail.
puzzle(_).

	    
	    
	    
/* ***************************************/ 
/* Grammar section:			 */
/* ***************************************/ 
	    
% Since the input is coming from an HTTP request instead of the command line
% the usual character procurement processes of the original version are no longer
% required. They are procured by the form submission and formulated using the 
% atomic_list_concat(L,' ', Command) predicate. Therefore only the grammar 
% processing is necessary from this point. 


% The grammar doesn't have to be real English.  There are two
% types of commands in Nani Search, those with and without a 
% single argument.  A *special case* is also made for the command
% goto which can be activated by simply giving a room name.

command([Pred,Arg]) --> verb(Type,Pred),nounphrase(Type,Arg).
command([Pred]) --> verb(intran,Pred).
command([goto,Arg]) --> noun(go_place,Arg).

% Recognize three types of verbs.  Each verb corresponds to a command,
% but there are many synonyms allowed.  For example the command
% turn_on will be triggered by either "turn on" or "switch on".

verb(go_place,goto) --> go_verb.
verb(thing,V) --> tran_verb(V).
verb(intran,V) --> intran_verb(V).

go_verb --> [go].
go_verb --> [go,to].
go_verb --> [g].

tran_verb(take) --> [take].
tran_verb(take) --> [pick,up].
tran_verb(drop) --> [drop].
tran_verb(drop) --> [put].
tran_verb(drop) --> [put,down].
tran_verb(eat) --> [eat].
tran_verb(turn_on) --> [turn,on].
tran_verb(turn_on) --> [switch,on].
tran_verb(turn_off) --> [turn,off].
tran_verb(look_in) --> [look,in].
tran_verb(look_in) --> [look].
tran_verb(look_in) --> [open].

intran_verb(inventory) --> [inventory].
intran_verb(inventory) --> [i].
intran_verb(begin) --> [begin].
intran_verb(look) --> [look].
intran_verb(look) --> [look,around].
intran_verb(look) --> [l].
intran_verb(quit) --> [quit].
intran_verb(quit) --> [exit].
intran_verb(quit) --> [end].
intran_verb(quit) --> [bye].
intran_verb(nshelp) --> [help].
intran_verb(hint) --> [hint].

% a noun phrase is just a noun with an optional determiner in front.

nounphrase(Type,Noun) --> det,noun(Type,Noun).
nounphrase(Type,Noun) --> noun(Type,Noun).

det --> [the].
det --> [a].

% Nouns are defined as rooms, or things located somewhere.  We define
% special cases for those things represented in Nani Search by two
% words.  We can't expect the user to type the name in quotes.

noun(go_place,R) --> [R], {room(R)}.
noun(go_place,'dining room') --> [dining,room].

noun(thing,T) --> [T], {location(T,_)}.
noun(thing,T) --> [T], {have(T)}.
noun(thing,flashlight) --> [flash,light].
noun(thing,'washing machine') --> [washing,machine].
noun(thing,'dirty clothes') --> [dirty,clothes].

% If the player has just typed light, it can be interpreted three ways.
% If a room name is before it, it must be a room light.  If the
% player has the flash light, assume it means the flash light.  Otherwise
% assume it is the room light.

noun(thing,light) --> [X,light], {room(X)}.
noun(thing,flashlight) --> [light], {have(flashlight)}.
noun(thing,light) --> [light].



	   
% UNIX Server Notes ....
% Launching SWI-Prolog instance online:
% File 'launch' contains: swipl -s game.pl -g 'server(5000)' 	  
% execute: screen ./launch & at command line or job to launch it
% and keep it in the background. Remember to chmod+x the file launch.

	   
/* ************************************************************* */
/* 			End of Prolog File 			 */
/* ************************************************************* */ 
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   	   