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

CREATE OR REPLACE VIEW v_valmediomedico as
SELECT c.codmedico, m.nomemedico, 
AVG(valconsulta) AS "valmedio"
FROM consulta c INNER JOIN medico m
on c.codmedico = m.codmedico
GROUP BY c.codmedico, m.nomemedico;

SELECT * FROM v_valmediomedico; 

-- exercicio 5

select table_name as nome_da_view
from information_schema.views -- na hora de correção leve em consideração que por enquanto uso
			      -- postgresql para realizar os exercicios.	
where table_name like '%SOR%' -- se quiser ignorar caixa alta usar ILIKE
	and table_schema = 'public';