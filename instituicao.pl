:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- dynamic utente/4.
:- dynamic servico/4.
:- dynamic consulta/4.
:- dynamic profissional/4.

%Importar o ficheiro que possui a base de conhecimento
:- consult('demo.pl').
:- multifile '-'/1.

%-----------------------Utentes--------------------------
% Extensao do predicado utente(#IdUt,Nome,Idade,Morada) -> {V,F,D}

utente( 1,joaquina-maria,50,braga ).
utente( 2,afonsina-ribeiro,19,lixa ).
utente( 5,antonio-oliveira,50,chaves ).
utente( 7,mariana-castro,34,barcelinhos ).
-utente( 8,marco-silva,60,alvalade ).
-utente( 9,joaquim,17,paredes ).


    %Valor Nulo Tipo 1
    utente( 3,carlota-carvalho,27,desconhecido-4 ).
    utente( 4,joao-fernandes,40,desconhecido-5 ).
    utente( 6,carlos-moreira,60,desconhecido-6 ).
    utente( 10,julia-matos,55,desconhecido-7 ).

    %Valor Nulo Tipo 3
    utente( 11,albertino-silva,40,interdito-2 ).

%-----------------------Servicos--------------------------
% Extensao do predicado servico(#Serv,Descrição,Instituição,Cidade) -> {V,F,D}

servico( 3,ginecologia,hospital-sao-marcos,braga ).
servico( 4,pediatria,hospital-sao-marcos,beja ).
servico( 5,psiquiatria,hospital-santa-maria,porto ).
-servico( 7,pneumologia,hospital-de-braga,barcelos ).
servico( 8,oftalmologia,hospital-sao-joao-deus,famalicao ).
servico( 10,acumpultura,hospital-de-braga,braga ).


    %Valor Nulo Tipo 1
    servico( 1,cardiologia,hospital-nossa-senhora-oliveira,desconhecido-8 ).
    servico( 2,nefrologia,hospital-dos-lusiadas,desconhecido-9 ).
    servico( 6,psiquiatria,hospital-narciso-ferreira,desconhecido-10 ). 
    servico( 9,dermatologia,hospital-da-arrabida,desconhecido-11 ).

%-----------------------Consultas--------------------------
% Extensao do predicado consulta(Data,#IdUt,#Serv,Custo) -> {V,F,D}

consulta( 15-03-2003,1,1,10 ).
consulta( 10-02-2016,2,3,35 ).
consulta( 22-08-2002,3,5,40 ).
consulta( 04-05-2007,4,2,20 ).
consulta( 13-03-2003,6,8,15 ).
consulta( 23-06-2013,7,9,45 ).
-consulta( 10-01-2006,8,4,10 ).
consulta( 08-04-2016,9,3,35 ).


    %Valor Nulo Tipo 1
    consulta( 17-09-2014,5,7,desconhecido-12 ).
    consulta( 01-03-2003,2,9,desconhecido-13 ).


%-----------------------Profissionais--------------------------
% Extensao do predicado profissional(#IdProf,Nome,#Serv,Anos-Servico ) -> {V,F,D}

profissional( 1,duarte-pereira,1,27 ).
profissional( 3,rui-guedes,5,25 ).
profissional( 4,vidal,2,40 ).
profissional( 5,duarte-pereira,4,4 ).
profissional( 7,anita-costa,8,38 ).
-profissional( 8,manuel-aarao,6,30 ).
profissional( 9,odete-couto,3,8 ).


    %Valor Nulo Tipo 1
    profissional( 2,joao-souttomayor,9,desconhecido-1 ).
    profissional( 6,adelina-carlos,2,desconhecido-2 ).
    profissional( 10,afonso-aarao,10,desconhecido-3 ).

    %Valor Nulo Tipo 3
    profissional( 13,cesar-mourao,8,interdito-1 ).

 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Invariantes Estruturais: 

% Nao permitir a insercao de conhecimento repetido
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
% Invariantes referenciais:

% Nao permitir a insercao de consultas cujo utente ou servico
% nao existam na base de conhecimento               
+consulta( D,U,S,C ) :: (solucoes(U,utente(U,_,_,_),LU ),
                         comprimento( LU,CmpLU ), 
                         CmpLU > 0,
                         solucoes(S,servico(S,_,_,_),LS),
                         comprimento(LS,CmpLS),
                         CmpLS > 0
                        ). 
                        
% Nao permitir a insercao de profissionais cujo servico
% nao exista na base de conhecimento    
+profissional( Id,N,S,A ) :: (solucoes(S,servico(S,_,_,_),Sols ),
                              comprimento( Sols,Cmp ), 
                              Cmp > 0
                             ).  

% Nao permitir a remocao de servicos que estejam
% a ser prestados por algum profissional 
-servico( S,D,I,C ) :: (solucoes(S,profissional(_,_,S,_),LS ),
                        comprimento( LS,Cmp ), 
                        Cmp == 0
                        ).
                             
% Nao permitir a remocao de servicos que tenham algum
% registo em alguma consulta  
-servico( S,D,I,C ) :: (solucoes(S,consulta(_,_,S,_),LS ),
                        comprimento( LS,Cmp ), 
                        Cmp == 0
                        ).
                             
% Nao permitir a remocao de utentes que tenham algum
% registo em alguma consulta  
-utente( U,N,A,M ) :: (solucoes(I,consulta(_,U,_,_),LU ),
                        comprimento( LU,Cmp ), 
                        Cmp == 0
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


