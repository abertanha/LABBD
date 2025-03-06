
-- Modelo Paciente- Consulta-Medico

Create table Paciente
( Codpaciente    number(4,0)    Primary  Key,
  Nompaciente    varchar2(30)   not null,
  Datanasc       date,
  Sexo           char( 1 ) check (sexo in ( 'F',  'M' )),	
  Endereco      varchar2(25) ) ;


Create table medico
(codmedico number(4,0) primary key,
 nomeMedico  varchar2(40));

Create table Consulta
(   Codconsulta   number(3,0)     Primary Key ,
    Dataconsulta  date,
    Tipocons      char(01)   check  (tipocons in ('P','C')),
    Codpaciente  number(4,0) Not Null   References Paciente,                   
    Codmedico    number(4,0) Not Null   References Medico ,
    Valconsulta  number(6,2) Not Null ) ;




-- Incluindo novas colunas na tabela de paciente

ALTER TABLE  Paciente ADD (cidade varchar2( 15 )  ) ;

ALTER TABLE  Paciente  MODIFY (cidade varchar2( 20 )   NOT   Null ) ;

ALTER TABLE  Paciente  ADD (desconto char( 01 )   check  (desconto in ('S','N' ) )) ;

/*
Restrições que podem ser implementadas na criação da Tabela
Restrição de Chave primária
Restrição de Chave estrangeira
Restrição de cláusula check
Restrição Unique
Restrição de valores nulos NULL e o NOt NULL */

-- Inserindo dados nas tabelas

-- Inserindo 5 pacientes

insert into Paciente values  (1,'Maria Antônia da Silva', '20/03/1998','F','Rua das Flores,40','Sorocaba','S');
insert into Paciente values  (3,'José Roberto Pereira', '20/04/2002','M','Rua Margarida,60','Itu','N');
insert into Paciente values  (4,'Ana Costa', '02/06/1998','F','Rua das Camélias,140','Sorocaba','S');
insert into Paciente values  (5,'Solange Pinheiro', '15/10/1994','F','Avenida Verão, 234','Itapetininga','N');
insert into Paciente values  (6,'Caio da Silva', '05/03/1998','M','Rua das Flores,40','Sorocaba','S');
insert into paciente values  (2,'Jose Maria','20/03/01','M','Rua Inverno, 30','Itu','N');

-- Verificando as inserções

select * from paciente;


/* quando for necessário inserir dados em uma ordem diferente da ordem dos campos na tabela.
insert into Paciente (nompaciente, codpaciente,.....) values ('Maria Antônia da Silva', 2,...)*/


-- inserir 5 médicos
insert into medico values (100,'Dr. Who');
insert into medico values (101,'Dr. House');
insert into medico values (102,'Dr. Smith');
insert into medico values (103,'Dr. X');
insert into medico values (104,'Dr. Estranho');

-- inserir 5 consultas

insert into consulta values (300,'01-03-2021','P',3,102,500.50);
insert into consulta values (301,'05-02-2021','C',5,103,100.50);
insert into consulta values (302,'01-03-2020','P',2,102,600.00);
insert into consulta values (303,'25-04-2021','C',1,104,99.98);

commit;

-- verificando as inclusões
select * from paciente;
select * from medico;
select * from consulta;
-------------------------------------------------------------

-- visões
-- 1 - Visão 1
CREATE OR REPLACE VIEW pacsor
AS SELECT * FROM paciente
WHERE cidade = 'Sorocaba'
WITH CHECK OPTION;

SELECT * FROM pacsor;

SELECT * FROM paciente;

SELECT nompaciente, datanasc FROM pacsor
WHERE desconto = 'S';

INSERT INTO pacsor
VALUES(77, 'Roberto Souza', sysdate, 'M','rua', 'Sorocaba', 'S');

UPDATE pacsor
SET endereco = 'Rua dos anjos, 33'
WHERE codpaciente = 77;

UPDATE pacsor
SET nompaciente = 'Carlos da silva'
WHERE codpaciente = 3;

-- visão 2

CREATE OR REPLACE VIEW pacsor_res
AS SELECT codpaciente,nompaciente,datanasc AS data_nascimento, sexo
FROM pacsor;

INSERT INTO pacsor_res(codpaciente,nompaciente, data_nascimento, sexo)
VALUES (49, 'Ana Mel', sysdate, 'F');

SELECT * FROM pacsor_res;

-- visão 3

CREATE OR REPLACE VIEW consulta_pac
AS SELECT p.codpaciente, p.nompaciente, c.codconsulta
FROM paciente p, consulta c
WHERE c.codpaciente = p.codpaciente;

SELECT * FROM consulta_pac;