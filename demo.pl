%--------------------------------- - - - - - - - - - -  -  -  -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'e' ).
:- op( 900,xfy,'::' ).
:- multifile '-'/1.

%--------------------------------- - - - - - - - - - -  -  -  -
% Extensao do meta-predicado demo: Q1 e Q2,Resposta -> {V,F,D}

demo(Q1 e Q2, R) :-
	demo1(Q1,R1),
	demo(Q2,R2),
	e(R1,R2,R),!.
demo(Q,R) :- demo1(Q,R).

%--------------------------------- - - - - - - - - - -  -  -  -
% Extensao do meta-predicado e: {V,F,D},{V,F,D} -> {V,F,D}

e(verdadeiro,verdadeiro,verdadeiro).
e(verdadeiro,falso,falso).
e(verdadeiro,desconhecido,desconhecido).
e(falso,verdadeiro,falso).
e(falso,falso,falso).
e(falso,desconhecido,falso).
e(desconhecido,verdadeiro,desconhecido).
e(desconhecido,falso,falso).
e(desconhecido,desconhecido,desconhecido).

%--------------------------------- - - - - - - - - - -  -  -  -
% Extensao do meta-predicado demo1: Questao,Resposta -> {V,F,D}
demo1(verdadeiro,verdadeiro).
demo1(falso,falso).
demo1(desconhecido,desconhecido).
demo1( Questao,verdadeiro ) :-
    Questao.
demo1( Questao,falso ) :-
    -Questao.
demo1( Questao,desconhecido ) :-
	Questao \= verdadeiro,
	Questao \= falso,
    nao( Questao ),
    nao( -Questao ).
	
%--------------------------------- - - - - - - - - - -  -  -  -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -
% Extensao do predicado que permite a insercao do conhecimento

insercao( T ) :-
    solucoes( I, +T::I, Li),
    inserir(T),
    testar(Li).
	
-insercao( T ) :- nao(insercao(T)).
	
%--------------------------------- - - - - - - - - - -  -  -  -
% Extensao do predicado que permite a remocao do conhecimento

remocao( T ) :-
	T,
    solucoes( I, -T::I, Li),
    remover(T),
    testar(Li).
	
-remocao( T ) :- nao(remocao(T)).
	    
%--------------------------------- - - - - - - - - - -  -  -  -
% Extensao do predicado inserir: T -> {V,F}

inserir(T) :- assert(T).
inserir(T) :- retract(T),!,fail.

%--------------------------------- - - - - - - - - - -  -  -  -
% Extensao do predicado remover: T -> {V,F}

remover(T) :- retract(T).
remover(T) :- assert(T),!,fail.

%--------------------------------- - - - - - - - - - -  -  -  -
% Extensao do predicado testar: L -> {V,F}

testar([]).
testar([I|Li]) :- I,testar(Li).


%--------------------------------- - - - - - - - - - -  -  -  -

solucoes(X,Y,Z) :- findall(X,Y,Z).
comprimento(L,N) :- length(L,N).                 