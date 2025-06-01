CREATE DATABASE db_faculdade_dados;
USE db_faculdade_dados;

CREATE TABLE tbl_Cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nome_curso VARCHAR(100) UNIQUE NOT NULL,
    descricao TEXT,
    carga_horaria INT NOT NULL
);

CREATE TABLE tbl_Professores (
    id_professor INT PRIMARY KEY AUTO_INCREMENT,
    nome_completo VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    logradouro VARCHAR(150),
    numero VARCHAR(10),
    complemento VARCHAR(50),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado CHAR(2),
    cep VARCHAR(9),
    pais VARCHAR(100) NOT NULL DEFAULT 'Brasil'
);

CREATE TABLE tbl_Professor_Telefones (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    id_professor INT NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_professor) REFERENCES tbl_Professores(id_professor)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE tbl_Professor_Especializacoes (
    id_especializacao INT PRIMARY KEY AUTO_INCREMENT,
    id_professor INT NOT NULL,
    especializacao VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_professor) REFERENCES tbl_Professores(id_professor)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE tbl_Materias (
    id_materia INT PRIMARY KEY AUTO_INCREMENT,
    nome_materia VARCHAR(100) UNIQUE NOT NULL,
    ementa TEXT,
    carga_horaria INT NOT NULL,
    id_professor INT,
    FOREIGN KEY (id_professor) REFERENCES tbl_Professores(id_professor)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE tbl_Alunos (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    RA VARCHAR(20) UNIQUE NOT NULL,
    nome_completo VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_nascimento DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    id_curso INT NOT NULL,
    logradouro VARCHAR(150),
    numero VARCHAR(10),
    complemento VARCHAR(50),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado CHAR(2),
    cep VARCHAR(9),
    pais VARCHAR(100) NOT NULL DEFAULT 'Brasil',
    FOREIGN KEY (id_curso) REFERENCES tbl_Cursos(id_curso)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE tbl_Aluno_Telefones (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    id_aluno INT NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES tbl_Alunos(id_aluno)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE tbl_Turmas (
    id_turma INT PRIMARY KEY AUTO_INCREMENT,
    ano_semestre VARCHAR(10) NOT NULL,
    id_materia INT NOT NULL,
    id_professor INT NOT NULL,
    FOREIGN KEY (id_materia) REFERENCES tbl_Materias(id_materia)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_professor) REFERENCES tbl_Professores(id_professor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE tbl_Notas (
    id_nota INT PRIMARY KEY AUTO_INCREMENT,
    id_aluno INT NOT NULL,
    id_materia INT NOT NULL,
    valor_nota DECIMAL(4,2) NOT NULL,
    data_avaliacao DATE NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES tbl_Alunos(id_aluno)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_materia) REFERENCES tbl_Materias(id_materia)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    UNIQUE (id_aluno, id_materia, data_avaliacao)
);

CREATE TABLE tbl_Alunos_Turmas (
    id_aluno INT NOT NULL,
    id_turma INT NOT NULL,
    PRIMARY KEY (id_aluno, id_turma),
    FOREIGN KEY (id_aluno) REFERENCES tbl_Alunos(id_aluno)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_turma) REFERENCES tbl_Turmas(id_turma)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO tbl_Cursos (nome_curso, descricao, carga_horaria) VALUES
('Engenharia de Software', 'Foco em desenvolvimento e arquitetura de sistemas.', 3600),
('Ciência da Computação', 'Estudo de algoritmos, estruturas de dados e IA.', 3200),
('Análise e Desenv. de Sistemas', 'Desenvolvimento de sistemas para negócios.', 2400);

INSERT INTO tbl_Professores (nome_completo, cpf, email, logradouro, numero, bairro, cidade, estado, cep) VALUES
('Ana Clara Lima', '111.222.333-44', 'ana.lima@faculdade.com', 'Rua das Flores', '100', 'Centro', 'São Paulo', 'SP', '01000-000'),
('Carlos Eduardo Souza', '555.666.777-88', 'carlos.souza@faculdade.com', 'Av. Brasil', '2500', 'Jardins', 'Rio de Janeiro', 'RJ', '20000-000');

INSERT INTO tbl_Professor_Telefones (id_professor, telefone) VALUES
(1, '11987654321'),
(1, '1133334444'),
(2, '21998877665');

INSERT INTO tbl_Professor_Especializacoes (id_professor, especializacao) VALUES
(1, 'Banco de Dados'),
(1, 'Engenharia de Requisitos'),
(2, 'Inteligência Artificial'),
(2, 'Machine Learning');

INSERT INTO tbl_Materias (nome_materia, ementa, carga_horaria, id_professor) VALUES
('Banco de Dados I', 'Modelagem e teoria relacional.', 80, 1),
('Algoritmos e Estruturas de Dados', 'Fundamentos de programação.', 120, 2),
('Inteligência Artificial', 'Introdução a IA e seus conceitos.', 80, 2),
('Engenharia de Software I', 'Ciclo de vida de software.', 80, 1);

INSERT INTO tbl_Alunos (RA, nome_completo, cpf, data_nascimento, email, id_curso, logradouro, numero, bairro, cidade, estado, cep) VALUES
('20220001', 'João Pedro Silva', '999.888.777-66', '2000-01-15', 'joao.silva@aluno.com', 1, 'Rua da Paz', '50', 'Vila Nova', 'São Paulo', 'SP', '02000-000'),
('20240002', 'Maria Alice Santos', '123.456.789-01', '2001-05-20', 'maria.santos@aluno.com', 2, 'Av. Atlântica', '1000', 'Copacabana', 'Rio de Janeiro', 'RJ', '21000-000'),
('20250003', 'Pedro Henrique Costa', '101.202.303-40', '2002-11-30', 'pedro.costa@aluno.com', 1, 'Rua das Oliveiras', '123', 'Centro', 'Belo Horizonte', 'MG', '30000-000');

INSERT INTO tbl_Aluno_Telefones (id_aluno, telefone) VALUES
(1, '11911112222'),
(2, '21922223333'),
(3, '31933334444');

INSERT INTO tbl_Turmas (ano_semestre, id_materia, id_professor) VALUES
('2025/1', 1, 1), 
('2025/1', 2, 2), 
('2025/1', 3, 2);

INSERT INTO tbl_Alunos_Turmas (id_aluno, id_turma) VALUES
(1, 1), 
(1, 2), 
(2, 1), 
(2, 3), 
(3, 1); 

INSERT INTO tbl_Notas (id_aluno, id_materia, valor_nota, data_avaliacao) VALUES
(1, 1, 8.50, '2025-04-10'), 
(1, 2, 7.00, '2025-04-15'), 
(2, 1, 9.20, '2025-04-10'), 
(2, 3, 6.80, '2025-04-20'), 
(3, 1, 7.50, '2025-04-10'); 

SELECT * FROM tbl_Cursos;
SELECT * FROM tbl_Professores;
SELECT * FROM tbl_Materias;
SELECT * FROM tbl_Alunos;
SELECT * FROM tbl_Turmas;
SELECT * FROM tbl_Notas;
SELECT * FROM tbl_Professor_Telefones;
SELECT * FROM tbl_Professor_Especializacoes;
SELECT * FROM tbl_Aluno_Telefones;
SELECT * FROM tbl_Alunos_Turmas;

show tables;

#drop database db_faculdade_dados;