create table alunoMa
( ra number(5) primary key,
  nomeAluno varchar2(40),
  codCurso number (3));
  
create table curso
  (codCurso number(3)primary key,
   nomeCurso varchar2(30));
   
   insert into alunoMa values (12345,'Joao X', 003);
    insert into alunoMa values (12355, 'Maria X', 002);
     insert into alunoMa values (12365, 'Liz X', 002);
     
     insert into curso values (001, 'Eletrônica');    
    insert into curso values (002, 'Biomédicos');    
    insert into curso values (003, 'ADS');
    
    select * from user_tables;
    select * from user_tab_columns;
    
    select * from user_constraints
        where table_name = 'ALUNOMA';
    
    alter table CURSO MODIFY NOMECURSO varchar2(30) not null;
    
    alter table ALUNOMA drop CONSTRAINT SYS_C00190066;
    --
    -- Excluindo a pk para recria-la dando nome à regra do banco(constraint)
    
    alter table ALUNOMA add CONSTRAINT PK_ALUNOMA_RA PRIMARY KEY (RA);
    -- Dando nome a constraint
    
    -- Verificando
    select * from user_constraints
    where table_name = 'ALUNOMA';
    
    -- definindo a fk para codcurso na table de aluno
    alter table ALUNOMA add CONSTRAINT FK_ALUNO_CODCURSO
    FOREIGN KEY (CODCURSO) REFERENCES CURSO;
    
    -- TESTANDO A FK CRIADA
    insert into ALUNOMA values (3333, 'Antonio', 004);
    
    create table Livro (CodigoLivro number(5) primary key,
    Titulo varchar2(30),
    Editora varchar2(20),
    Cidade varchar2(30),
    DataEdicao date,
    Versao number(3),
    CodAssunto number(5),
    Preco number(5,2),
    DataCadastro date,
    lancamento Char(1) );
    
    create table Autor (CodAutor number(5) primary key,
    Nomeautor varchar2(20), 
    datanascimento date,
    CidadeNasc varchar2(20),
    sexo char(1));
    
    create table Assunto (CodAssunto number(5) primary key,
    descricao varchar2(40),
    descontopromocao char(1));
    
    create table AutorLivro ( codigoLivro number(5) not NULL,
    codAutor number(5) not NULL);
    
    
    -- DEFININDO A FK DA TABELA LIVRO
    alter table LIVRO add CONSTRAINT FK_LIVRO_CODASSUNTO
    FOREIGN KEY (CODASSUNTO) REFERENCES ASSUNTO;
    
    -- DEFININDO AS FKS DA TABELA AUTORLIVRO    
    alter table AUTORLIVRO add CONSTRAINT FK_AUTORLIVRO_CODAUTOR
    FOREIGN KEY (CODAUTOR) REFERENCES AUTOR;
    
    alter table AUTORLIVRO add CONSTRAINT FK_AUTORLIVRO_CODIGOLIVRO
    FOREIGN KEY (CODIGOLIVRO) REFERENCES LIVRO;
    
    -- CONSTRUINDO A PK DE AUTORLIVRO COMPOSTA DE DUAS FK
    alter table AUTORLIVRO add CONSTRAINT PK_AUTORLIVRO PRIMARY KEY (CODAUTOR,CODIGOLIVRO);
    
    
    
    
    