-- lista visao
-- exercicio 1
Create or replace view v_retorno
AS Select codmedico, codpaciente, dataconsulta + 30 as "retorno" 
From consulta;

SELECT * FROM v_retorno;

-- exercicio 2
CREATE OR REPLACE VIEW v_consulta
AS SELECT codmedico, codconsulta, dataconsulta
FROM consulta;

SELECT * FROM v_consulta;

-- exercicio 3

CREATE OR REPLACE VIEW v_consultasMedico
AS SELECT codmedico, SUM(valconsulta) AS "valpormedico"
FROM consulta
GROUP BY codmedico;

SELECT * FROM v_consultasMedico; 

-- exercicio 4

CREATE OR REPLACE VIEW v_valmediomedico
AS SELECT c.codmedico, m.nomemedico, 
AVG(valconsulta) AS "valmedio",
FROM consulta c INNER JOIN medico m
GROUP BY codmedico, nomemedico;

SELECT * FROM v_consultasMedico; 