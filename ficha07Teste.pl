

% ------------------ Ficheiro de Teste ---------------------- %


%--------------------------------- - - - - - - - - - -  -  -  -
% SICStus PROLOG: definicoes iniciais

:- consult(demo).
:- multifile '-'/1.

:- dynamic jogo/3.

%--------------------------------- - - - - - - - - - -  -  -  -
% Extensao do predicado jogo: Id,Arb,AjCusto  -> {V,F,D}

-jogo(Id,A,C) :-
	nao(jogo(Id,A,C)),
	nao(excepcao(jogo(Id,A,C))).
		
excepcao(jogo(Id,A,C)) :- jogo(Id,A,nulo001).

%1
jogo(1,aa,500).

%2
jogo(2,bb,nulo001).

%3
excepcao(jogo(3,cc,500)).
excepcao(jogo(3,cc,2500)).

%4
excepcao(jogo(4,dd,C)) :-
	C >= 250,
	C =< 750.
	
%5
jogo(5,ee,nulo005).
excepcao(jogo(J,A,C)) :- jogo(J,A,nulo005).
nulo(nulo005).

+jogo(J,A,C) :: (
	solucoes(C,( jogo(5,ee,C), nao(nulo(C))), S),
	length(S,0) 
	).
	
%6
jogo(6,ff,250).
excepcao(jogo(6,ff,C)) :-
	C > 5000.
	
%7
-jogo(7,gg,2500).
jogo(7,gg,nulo007).
excepcao(jogo(J,A,C)) :- jogo(J,A,nulo007).

%8
excepcao(jogo(8,hh,C)) :-
	cerca(1000,Sup,Inf),
	C >= Inf,
	C =< Sup.

cerca(X,Sup,Inf) :-
	Sup is X*1.25,
	Inf is X*0.75.
	
mproximo(X,Sup,Inf) :-
	Sup is X*1.1,
	Inf is X*0.9.



