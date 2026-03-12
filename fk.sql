-- Turmas X alunos
alter table Turmas
	add constraint fk_TurmasAlunos foreign key (id_aluno) references Alunos (id_alunos);

-- Turmas X Cursos
alter table Turmas
	add constraint fk_TurmasCursos foreign key (id_curso) references Cursos (id_curso);

-- Reg. Presença X Turmas
alter table Registro_Presenca
	add constraint fk_RegTurmas foreign key (id_turma) references Turmas (id_turma);

-- Reg. Presença X Alunos
alter table Registro_Presenca
	add constraint fk_RegAlunos foreign key (id_aluno) references Alunos (id_alunos);

-- Reg. Presença X Situação
alter table Registro_Presenca
	add constraint fk_RegSituacao foreign key (id_situacao) references Situacao (id_situacao);
