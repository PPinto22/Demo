:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- op( 900,xfy, '::' ). 
:- op( 900,xfy,'e' ).

:- multifile '-'/1.

%Importar o ficheiro que possui a base de conhecimento
:- consult('dadosProblema.pl').
 

%- - - - - - — - - - - - Predicados auxiliares - - - - - - - - - - - - - - - - 
%-----------------------------------------------------------------

% Extensao do predicado nao: Questao -> {V,F}

nao(Questao) :- Questao, !, fail.
nao(Questao).

%-----------------------------------------------------------------
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
demo1(verdadeiro,verdadeiro) :- !.
demo1(falso,falso) :- !.
demo1(desconhecido,desconhecido) :- !.
demo1( Questao,verdadeiro ) :-
    Questao.
demo1( Questao,falso ) :-
    -Questao.
demo1( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).

%-----------------------------------------------------------------
% Extensao do predicado solucoes: Valor,Predicado,Resultado -> {V,F}

solucoes(X,Y,Z) :- findall(X,Y,Z).

%-----------------------------------------------------------------
% Extensao do predicado comprimento: Lista,Resultado -> {V,F}

comprimento(L,N) :- length(L,N).

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

%- - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - -
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%Representação de conhecimento negativo

%Profissional
-profissional( IP,N,S,A ):-
        nao(profissional( I,N,S,A )),
        nao( excecao( profissional( I,N,S,A ))).


%Utente
-utente( IU,N,A,M ):-
        nao(utente( I,N,A,M )),
        nao( excecao( utente( I,N,A,M ))).

%Serviço
-servico( IS,D,IN,C ):-
        nao(servico( I,D,I,C )),
        nao( excecao( servico( I,D,I,C ))).

%Consulta
-consulta( D,IU,IS,C ):-
        nao(consulta( D,IU,IS,C )),
        nao( excecao( consulta( D,IU,IS,C ))).

%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%- - - - - - - - -  - -Representação de conhecimento Imperfeito

%Representação de conhecimento incerto

%---
excecao(profissional( IP,N,S,A )):- 
                    profissional( IP,N,S,desconhecido_1 ).
excecao(profissional( IP,N,S,A )):- 
                    profissional( IP,N,S,desconhecido_2 ).
excecao(profissional( IP,N,S,A )):- 
                    profissional( IP,N,S,desconhecido_3 ).                   

%---
excecao(utente( IU,N,A,M )):- 
                    utente( IU,N,A,desconhecido_4 ).
excecao(utente( IU,N,A,M )):- 
                    utente( IU,N,A,desconhecido_5 ).
excecao(utente( IU,N,A,M )):- 
                    utente( IU,N,A,desconhecido_6 ).
excecao(utente( IU,N,A,M )):- 
                    utente( IU,N,A,desconhecido_7 ).
%---

excecao(servico( IS,D,IN,C )):- 
                    servico( IS,D,IN,desconhecido_8 ).
excecao(servico( IS,D,IN,C )):- 
                    servico( IS,D,IN,desconhecido_9 ).
excecao(servico( IS,D,IN,C )):- 
                    servico( IS,D,IN,desconhecido_10 ).
excecao(servico( IS,D,IN,C )):- 
                    servico( IS,D,IN,desconhecido_11 ).

%---
excecao(consulta( D,IU,IS,C )):- 
                    consulta( D,IU,IS,desconhecido_12 ).
excecao(consulta( D,IU,IS,C )):- 
                    consulta( D,IU,IS,desconhecido_13 ).

%- - - - - - - - - - - - - - - - - - - - - - - -- - - - - -
%Representação de conhecimento impreciso

excecao(profissional(11,antonia-abreu,3,40)).
excecao(profissional(11,antonia-abreu,3,20)).


excecao(profissional(12,gloria-costa,4,10)).
excecao(profissional(12,gloria-costa,4,30)).
excecao(profissional(12,gloria-costa,4,20)).

excecao(consulta(01-01-2016,9,8,Custo)) :- Custo >= 5, Custo =< 30.

excecao(servico(11,urologista,hospital_dos_lusiadas,lisboa)).
excecao(servico(11,urologista,hospital_dos_lusiadas,porto)).

%- - - - - - - - - - - - - - - - - - - - - - - -- - - - - -
%Representação de conhecimento interdito

nulo(interdito_1).
excecao(profissional( IP,N,S,A )) :- profissional( IP,N,S,interdito_1 ).
+profissional( IP,N,S,A ) :: (solucoes(As, ( profissional(13,cesar_mourao,8,As), nao(nulo(As)) ), S),
                    comprimento(S, R), R == 0 ).


nulo(interdito_2).
excecao(utente( IU,N,A,M )) :- utente( IU,N,A,interdito_2 ).
+utente( IU,N,A,M ) :: (solucoes(Ms, ( utente( 11,albertino_silva,40,Ms ), nao(nulo(Ms)) ), S),
                    comprimento(S, R), R == 0 ).


