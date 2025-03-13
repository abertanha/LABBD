create table aluno026
( RA int not null,
  Nome  varchar(50),
  CodCurso int,
  datanasc datetime);

  -- Como a PK náo foi definida o indice náo foi criado para a coluna RA

  -- Criando uma indice cluster (esparso) para a coluna Curso

 CREATE CLUSTERED INDEX idx_curso  ON aluno(CodCurso);

 -- Obs: no SQL Server Clustered = Esparso
 --                    NoCluster = Denso

  -- Criando uma PK

  Alter table aluno add constraint pk_aluno primary key(RA);


-- Podemos ver que o banco criou automaticamente um indice para a coluna RA porem náo clusterizado


--- Testando com o default do banco

create table aluno026
( RA int not null,
  Nome  varchar(50),
  Curso varchar(50),
  datanasc datetime);

  -- Criando uma PK

  Alter table aluno026 add constraint pk_aluno026 primary key(RA);


  -- criando um indice  cluster para a coluna curso

  CREATE CLUSTERED INDEX idx_curso026  ON aluno026(Curso);  -- deu erro pois já existe um outro indice cluster

  -- -- criando um indice  náo cluster para a coluna curso

  CREATE NONCLUSTERED INDEX idx_curso026  ON aluno026(Curso); -- ok criado



  -- alterando os indices 

  DROP INDEX pk_aluno026 on aluno026; -- Haverá erro pois a chave primária precisar ter sua restrição deletada
  DROP INDEX idx_curso026 ON aluno026;