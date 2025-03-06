-- desafio 1
-- listar o codigo do produto, nome do produto, o valor unitario original e o valor uniario aumentado em 10%

SELECT codproduto, descricao, 'Antes do aumento' AS Quando, valor_unit FROM tb_produto
UNION ALL
SELECT codproduto, descricao, 'Depois do aumento', valor_unit * 1.1
FROM tb_produto
ORDER BY codproduto, Quando;


-- desafio 2

SELECT  codproduto, descricao, valor_unit FROM tb_produto
UNION
SELECT null, 'Soma dos valores', SUM(valor_unit) FROM tb_produto
ORDER BY 3;

-- ou

SELECT  TO_CHAR(codproduto), descricao, valor_unit FROM tb_produto
UNION
SELECT '  ', 'Soma dos valores', SUM(valor_unit) FROM tb_produto
ORDER BY 3;