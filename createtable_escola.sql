create table Alunos
(
id_alunos int primary key not null,
nome varchar(200),
data_nascimento date,
sexo varchar(1), --M para masculino ou F para feminino
data_cadastro datetime,
login_cadastro varchar(15)
);

create table Situacao
(
id_situacao int primary key not null,
situacao varchar(25) not null,
data_cadastro datetime,
login_cadastro varchar(15)
);

drop table dcursos;

create table Cursos
(
id_curso int primary key not null,
nome_curso varchar(200) not null,
data_cadastro datetime not null,
login_cadastro varchar(15)
);

create table Turmas
(
id_turma int primary key not null,
id_aluno int not null,
id_curso int not null,
valor_turma numeric(15,2) not null,
desconto numeric(3,2) not null,
data_inicio date not null,
data_termino date,
data_cadastro datetime not null,
login_Cadastro varchar(15)
);

create table Registro_Presenca
(
id_turma int not null,
id_aluno int not null,
id_situacao int not null,
data_presenca date not null,
data_cadastro date not null,
login_cadastro varchar(15) not null
);

/*
drop table turmas;
drop table situacao;
drop table cursos;
drop table alunos;
drop table registro_presenca;
*/

select * from Alunos, cursos, turmas, situacao, registro_presenca;
