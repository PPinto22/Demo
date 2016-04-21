%dynamic utente/4.
%dynamic servico/4.
%dynamic consulta/4.
%dynamic profissional/4.

%-----------------------Utentes--------------------------
% Extensao do predicado utente(#IdUt,Nome,Idade,Morada) -> {V,F,D}

utente( 1,joaquina_maria,50,braga ).
utente( 2,afonsina_ribeiro,19,lixa ).
utente( 5,antonio_oliveira,50,chaves ).
utente( 7,mariana_castro,34,barcelinhos ).
-utente( 8,marco_silva,60,alvalade ).
-utente( 9,joaquim,17,paredes ).


	%Valor Nulo Tipo 1
	utente( 3,carlota_carvalho,27,desconhecido_4 ).
	utente( 4,joao_fernandes,40,desconhecido_5 ).
	utente( 6,carlos_moreira,60,desconhecido_6 ).
	utente( 10,julia_matos,55,desconhecido_7 ).

	%Valor Nulo Tipo 3
	utente( 11,albertino_silva,40,interdito_2 ).

%demo(utente( 11,albertino_silva,40,casa ),R).
%-----------------------Servicos--------------------------
% Extensao do predicado servico(#Serv,Descrição,Instituição,Cidade) -> {V,F,D}

servico( 3,ginecologia,hospital_sao_marcos,braga ).
servico( 4,pediatria,hospital_sao_marcos,beja ).
servico( 5,psiquiatria,hospital_santa_maria,porto ).
-servico( 7,pneumologia,hospital_de_braga,barcelos ).
servico( 8,oftalmologia,hospital_sao_joao_deus,famalicao ).
servico( 10,acumpultura,hospital_de_braga,braga ).


	%Valor Nulo Tipo 1
	servico( 1,cardiologia,hospital_nossa_senhora_oliveira,desconhecido_8 ).
	servico( 2,nefrologia,hospital_dos_lusiadas,desconhecido_9 ).
	servico( 6,psiquiatria,hospital_narciso_ferreira,desconhecido_10 ).	
	servico( 9,dermatologia,hospital_da_arrabida,desconhecido_11 ).

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
	consulta( 17-09-2014,5,7,desconhecido_12 ).
	consulta( 01-03-2003,2,9,desconhecido_13 ).


%-----------------------Profissionais--------------------------
% Extensao do predicado profissional(#IdProf,Nome,#Serv,Anos_Servico ) -> {V,F,D}

profissional( 1,duarte_pereira,1,27 ).
profissional( 3,rui-guedes,5,25 ).
profissional( 4,vidal,2,40 ).
profissional( 5,duarte-pereira,4,4 ).
profissional( 7,anita-costa,8,38 ).
-profissional( 8,manuel-aarao,6,30 ).
profissional( 9,odete-couto,3,8 ).


	%Valor Nulo Tipo 1
	profissional( 2,joao-souttomayor,9,desconhecido_1 ).
	profissional( 6,adelina-carlos,2,desconhecido_2 ).
	profissional( 10,afonso-aarao,10,desconhecido_3 ).

	%Valor Nulo Tipo 3
	profissional( 13,cesar-mourao,8,interdito_1 ).

