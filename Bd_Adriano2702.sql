-- Mostra a data do sistema.
SELECT SYSDATE FROM DUAL;

-- TO_CHAR parse date format to string, you add a string mask.
SELECT TO_CHAR(SYSDATE, 'dd/mm/yyyy:hh24:mi:ss') FROM dual;

-- EXTRACT pode retirar um valor por vez
SELECT EXTRACT (YEAR FROM sysdate) FROM dual;

-- Subtração de dias de uma data
UPDATE livro
    SET dataedicao = dataedicao - 3
    WHERE codlivro = 1;

SELECT SYSDATE - 30 FROM DUAL;

-- Soma ou subtração de meses
SELECT add_months(SYSDATE, -2) FROM DUAL;
SELECT add_months(SYSDATE, +2) FROM DUAL;

-- Diferença entre datas(devolve em dias)
SELECT sysdate - datanascimento FROM autor;

-- Calcule quantos dias vocês já viveram
SELECT sysdate - TO_DATE('26/04/1990:07:00', 'dd/mm/yyyy:hh24:mi') FROM dual;
SELECT (sysdate - TO_DATE('26/04/1990:07:00', 'dd/mm/yyyy:hh24:mi')) FROM dual;

-- Calcule a idade de uma pessoa
SELECT (sysdate - TO_DATE('26/04/1990'))/365.25 FROM dual;

-- Clausula LIKE
-- Dessa forma busca qualquer coisa BANCO DE DADOS qualquer coisa
SELECT titulo FROM livro
    WHERE titulo LIKE '%BANCO DE DADOS%';

-- TO DO AVERIGUAR DEPOIS
SELECT titulo FROM livro
    WHERE titulo LIKE '--------DE DADOS%';

-- Clausula BETWEEN, tem que ser crescente
SELECT cidadenasc,nomeautor FROM autor
WHERE datanascimento BETWEEN '01/01/1950' AND '31/12/1970'
ORDER BY cidadenasc, nomeautor;

SELECT cidadenasc,nomeautor FROM autor
WHERE TO_CHAR(datanascimento, 'yyyy') BETWEEN '01/01/1950' AND '31/12/1970'
ORDER BY cidadenasc, nomeautor;

-- filtro condicional HAVING
SELECT codautor, COUNT(*) AS quantidade
FROM autorlivro
GROUP BY codautor
HAVING COUNT(*) >= 2;

SELECT autor.codautor, autor.nomeautor , COUNT(*) AS quantidade
FROM autorlivro INNER JOIN autor
ON autorlivro.codautor = autor.codautor
GROUP BY autor.codautor, autor.nomeautor;

