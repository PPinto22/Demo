:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- multifile '-'/1.

%Importar o ficheiro que possui a base de conhecimento
:- consult('dadosProblema.pl').
:- consult('demo.pl').
 
% Invariantes Estruturais: 

% Nao permitir a insercao de conhecimento repetido ou contraditorio
+utente( Id,N,I,M ) :: (solucoes(Id,utente(Id,_,_,_),SolsP ),
                        comprimento( SolsP,Cmp ), 
                        Cmp == 1
                       ). 
+servico( Id,D,I,C ) :: (solucoes(Id,servico(Id,_,_,_),Sols ),
                         comprimento( Sols,Cmp ), 
                         Cmp == 1
                        ). 
+consulta( D,U,S,C ) :: (solucoes((D,U,S),consulta(D,U,S,_),Sols ),
                         comprimento( Sols,Cmp ), 
                         Cmp == 1
                        ). 
+profissional( Id,N,S,A ) :: (solucoes(Id,profissional(Id,_,_,_),Sols ),
                              comprimento( Sols,Cmp ), 
                              Cmp == 1
                             ).
					 
							 
 
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
                    profissional( IP,N,S,desconhecido-1 ).
excecao(profissional( IP,N,S,A )):- 
                    profissional( IP,N,S,desconhecido-2 ).
excecao(profissional( IP,N,S,A )):- 
                    profissional( IP,N,S,desconhecido-3 ).                   

%---
excecao(utente( IU,N,A,M )):- 
                    utente( IU,N,A,desconhecido-4 ).
excecao(utente( IU,N,A,M )):- 
                    utente( IU,N,A,desconhecido-5 ).
excecao(utente( IU,N,A,M )):- 
                    utente( IU,N,A,desconhecido-6 ).
excecao(utente( IU,N,A,M )):- 
                    utente( IU,N,A,desconhecido-7 ).
%---

excecao(servico( IS,D,IN,C )):- 
                    servico( IS,D,IN,desconhecido-8 ).
excecao(servico( IS,D,IN,C )):- 
                    servico( IS,D,IN,desconhecido-9 ).
excecao(servico( IS,D,IN,C )):- 
                    servico( IS,D,IN,desconhecido-10 ).
excecao(servico( IS,D,IN,C )):- 
                    servico( IS,D,IN,desconhecido-11 ).

%---
excecao(consulta( D,IU,IS,C )):- 
                    consulta( D,IU,IS,desconhecido-12 ).
excecao(consulta( D,IU,IS,C )):- 
                    consulta( D,IU,IS,desconhecido-13 ).

%- - - - - - - - - - - - - - - - - - - - - - - -- - - - - -
%Representação de conhecimento impreciso

excecao(profissional(11,antonia-abreu,3,40)).
excecao(profissional(11,antonia-abreu,3,20)).


excecao(profissional(12,gloria-costa,4,10)).
excecao(profissional(12,gloria-costa,4,30)).
excecao(profissional(12,gloria-costa,4,20)).

excecao(consulta(01-01-2016,9,8,Custo)) :- Custo >= 5, Custo =< 30.

excecao(servico(11,urologista,hospital-dos-lusiadas,lisboa)).
excecao(servico(11,urologista,hospital-dos-lusiadas,porto)).

%- - - - - - - - - - - - - - - - - - - - - - - -- - - - - -
%Representação de conhecimento interdito

nulo(interdito-1).
excecao(profissional( IP,N,S,A )) :- profissional( IP,N,S,interdito-1 ).
+profissional( IP,N,S,A ) :: (solucoes(As, ( profissional(13,cesar-mourao,8,As), nao(nulo(As)) ), Sols),
                    comprimento(Sols, Cmp), Cmp == 0 ).


nulo(interdito-2).
excecao(utente( IU,N,A,M )) :- utente( IU,N,A,interdito-2 ).
+utente( IU,N,A,M ) :: (solucoes(Ms, ( utente( 11,albertino-silva,40,Ms ), nao(nulo(Ms)) ), Sols),
                    comprimento(Sols, Cmp), Cmp == 0 ).


