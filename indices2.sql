--1- Inicialmente vamos criar a tabela TB01.


create table TB026

(c1 int not null,

c2 char(200) not null default '**')


--2- Vamos inserir 100.000 linhas nesta tabela:

Begin
DECLARE @cnt INT = 0;

WHILE @cnt < 100000
BEGIN
	insert TB026(c1)
		select 1000;
	SET @cnt = @cnt + 1;
END;
END;

-- Checando as inserções


select * from TB026;


Select COUNT(*) from TB026


--3- Agora vamos inserir somente uma linha com o valor 2000


insert TB026(c1) values(2000)


--Como pode ser visto, nós inserimos 10000 linhas na tabela com o valor de 1000 na coluna C1 e apenas uma linha com o valor 2000.



--4- Vamos agora dar uma olhada no Plano de excução para as duas consultas a seguir:


-- consulta 1

select c1, c2 from TB026 where c1=1000


-- consulta 2

select c1, c2 from TB026 where c1=2000

--create a nonclustered index on column c1

-- Exemplo 5

create nonclustered index ix_TB026_C1 on TB026(c1)


-- Vamos executar novamente as consultas


-- consulta 1

select c1, c2 from TB026 where c1=1000


-- consulta 2

select c1, c2 from TB026 where c1=2000

-- consulta 4

select c1, c2 from TB026 where c1=1500

-- consulta 5

select c1 from TB026 where c1=1000