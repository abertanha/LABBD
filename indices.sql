create table aluno026
( RA int not null,
  Nome  varchar(50),
  CodCurso int,
  datanasc datetime);

  -- Como a PK n�o foi definida o indice n�o foi criado para a coluna RA

  -- Criando uma indice cluster (esparso) para a coluna Curso

 CREATE CLUSTERED INDEX idx_curso  ON aluno(CodCurso);

 -- Obs: no SQL Server Clustered = Esparso
 --                    NoCluster = Denso

  -- Criando uma PK

  Alter table aluno add constraint pk_aluno primary key(RA);


-- Podemos ver que o banco criou automaticamente um indice para a coluna RA porem n�o clusterizado


--- Testando com o default do banco

create table aluno026
( RA int not null,
  Nome  varchar(50),
  Curso varchar(50),
  datanasc datetime);

  -- Criando uma PK

  Alter table aluno026 add constraint pk_aluno026 primary key(RA);


  -- criando um indice  cluster para a coluna curso

  CREATE CLUSTERED INDEX idx_curso026  ON aluno026(Curso);  -- deu erro pois j� existe um outro indice cluster

  -- -- criando um indice  n�o cluster para a coluna curso

  CREATE NONCLUSTERED INDEX idx_curso026  ON aluno026(Curso); -- ok criado



  -- alterando os indices 

  DROP INDEX pk_aluno026 on aluno026; -- Haver� erro pois a chave prim�ria precisar ter sua restri��o deletada
  DROP INDEX idx_curso026 ON aluno026;