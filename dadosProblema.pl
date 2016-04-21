:- multifile '-'/1.

:- dynamic utente/4.
:- dynamic servico/4.
:- dynamic consulta/4.
:- dynamic profissional/4.

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

