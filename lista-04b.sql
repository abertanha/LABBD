SELECT * FROM VENDEDOR;
select * from pedido;
select * from ITEM_PEDIDO;

-- você utilizará isso para saber o total vendido por um vendedor
select sum(produto.valor_unitario * item_pedido.QUANTIDADE) as total_vendido
from pedido inner join item_pedido
on pedido.num_pedido = item_pedido.num_pedido
inner join produto
on item_pedido.cod_produto = produto.cod_produto
where pedido.cod_vendedor = 101;

-- EXERCICIO 1
CREATE OR REPLACE PROCEDURE CALCULAR_COMISSAO (p_cod_vendedor NUMBER)
AS
    v_total_vendido NUMBER;
    v_nome_vendedor VARCHAR2(30);
BEGIN
    -- testando se o vendendor informado existe
    SELECT Nome_vendedor INTO v_nome_vendedor
    FROM Vendedor
    WHERE Cod_vendedor = p_cod_vendedor;
    
    -- log de inicio da operação
    INSERT INTO TABLOG (datalog, campo1, campo2)
    VALUES(
        sysdate,
        '1 - Inicio da operação',
        'Vendedor: ' || p_cod_vendedor);
    -- calculando o total vendido
    SELECT NVL(SUM(PR.VALOR_UNITARIO * IP.QUANTIDADE),0)
    INTO v_total_vendido
    FROM PEDIDO P
    INNER JOIN ITEM_PEDIDO IP ON P.num_pedido = IP.num_pedido
    INNER JOIN PRODUTO PR ON IP.cod_produto = PR.cod_produto
    WHERE P.cod_vendedor = p_cod_vendedor;
    
    IF v_total_vendido > 0 AND v_total_vendido < 100 THEN
        UPDATE VENDEDOR SET FAIXA_COMISSAO = 0.10 WHERE COD_VENDEDOR = p_cod_vendedor;
        INSERT INTO TABLOG(datalog, campo1, campo2)
        VALUES (sysdate, '2 - Comissão 10%', 'Vendedor: ' || p_cod_vendedor);
    ELSIF v_total_vendido BETWEEN 100 AND 1000 THEN
        UPDATE VENDEDOR SET FAIXA_COMISSAO = 0.15 WHERE COD_VENDEDOR = p_cod_vendedor;
        INSERT INTO TABLOG (datalog, campo1, campo2)
        VALUES (sysdate, '2 - Comissão 15%', 'Vendedor: ' || p_cod_vendedor);
    ELSIF v_total_vendido > 1000 THEN
        UPDATE VENDEDOR SET FAIXA_COMISSAO = 0.20 WHERE COD_VENDEDOR = p_cod_vendedor;
        INSERT INTO TABLOG (datalog, campo1, campo2)
        VALUES (sysdate, '2 - Comissão 20%', 'Vendedor: ' || p_cod_vendedor);
    ELSE
        UPDATE VENDEDOR SET FAIXA_COMISSAO = 0 WHERE COD_VENDEDOR = p_cod_vendedor;
        INSERT INTO TABLOG (datalog, campo1, campo2)
        VALUES (sysdate, '2 - Comissão 0%', 'Vendedor: ' || p_cod_vendedor);
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        INSERT INTO TAB_ERRO (dataerro, mensagem)
        VALUES (sysdate, 'ERRO: Vendedor não existe: ' || p_cod_vendedor);
    WHEN OTHERS THEN
        DECLARE
            v_erro VARCHAR2(100);
        BEGIN
            v_erro := SUBSTR(SQLERRM, 1, 90);
            INSERT INTO TAB_ERRO(dataerro, mensagem)
            VALUES (sysdate, 'Erro: ' || v_erro);
            RAISE;
        END; 
END;

EXEC CALCULAR_COMISSAO(99);
EXEC CALCULAR_COMISSAO(101);
EXEC CALCULAR_COMISSAO(102);
EXEC CALCULAR_COMISSAO(103);
EXEC CALCULAR_COMISSAO(104);
EXEC CALCULAR_COMISSAO(105);
EXEC CALCULAR_COMISSAO(106);
EXEC CALCULAR_COMISSAO(107);
EXEC CALCULAR_COMISSAO(108);
SELECT * FROM TABLOG;
SELECT * FROM TAB_ERRO;

-- EXERCICIO 2

-- inserindo produto sem pedidos na base de dados
INSERT INTO Produto (Cod_produto, Descricao, Unidade, Valor_unitario)
VALUES (1011, 'SSD 256GB', 'UN', 199.90);

INSERT INTO Produto (Cod_produto, Descricao, Unidade, Valor_unitario)
VALUES (1012, 'Carregador Portátil', 'UN', 150.00);

-- averiguando numero de pedidos que esses produtos se encontram
SELECT DISTINCT Num_pedido
FROM Item_pedido
WHERE Cod_produto = 1011;

SELECT P.Cod_produto, P.Descricao
FROM Produto P
LEFT JOIN Item_pedido IP ON P.Cod_produto = IP.Cod_produto
WHERE IP.Cod_produto IS NULL;

CREATE OR REPLACE PROCEDURE DELETAR_PRODUTO_SEM_PEDIDO (p_cod_produto NUMBER)
AS
    v_descricao produto.DESCRICAO%TYPE;
    v_pedidos_existem NUMBER;
BEGIN

    -- testando se o produto informado existe
    SELECT DESCRICAO INTO v_descricao 
    FROM produto
    where cod_produto = p_cod_produto;
    
    -- log de inicio da operação
    INSERT INTO TABLOG (datalog, campo1, campo2)
    VALUES(
        sysdate,
        '1 - Inicio da operação',
        'Produto: ' || p_cod_produto);

    -- Verifica se há pedidos para o produto
    SELECT COUNT(*) INTO v_pedidos_existem
    FROM Item_pedido
    WHERE Cod_produto = p_cod_produto;


    IF v_pedidos_existem = 0 THEN       
        INSERT INTO TABLOG (datalog, campo1, campo2)
        VALUES (
            SYSDATE,
            'Exclusão - Código: ' || p_cod_produto,
            'Descrição: ' || v_descricao || ' | Usuário: ' || USER
        );
        
        DELETE FROM produto
        WHERE cod_produto = p_cod_produto;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        INSERT INTO TAB_ERRO (dataerro, mensagem)
        VALUES (sysdate, 'Código do produto inexistente ' || p_cod_produto);
    WHEN OTHERS THEN
        DECLARE
            v_erro VARCHAR2(100);
        BEGIN
            v_erro := SUBSTR(SQLERRM, 1, 90);
            INSERT INTO TAB_ERRO(dataerro, mensagem)
            VALUES (sysdate, 'Erro: ' || v_erro);
            RAISE;
        END; 
END;

EXEC DELETAR_PRODUTO_SEM_PEDIDO(1000);
SELECT * FROM TABLOG;
SELECT * FROM TAB_ERRO;
select * from produto;

ROLLBACK;

ALTER TABLE TABLOG 
MODIFY (
    campo1 VARCHAR2(100),
    campo2 VARCHAR2(100)
);

------------------- Exercicio 3 -------------------

CREATE OR REPLACE PROCEDURE DELETAR_PRODUTO_SEM_PEDIDO (p_cod_produto NUMBER)
AS
    v_descricao produto.DESCRICAO%TYPE;
    v_pedidos_existem NUMBER;
BEGIN

    BEGIN
        SELECT DESCRICAO INTO v_descricao
        FROM produto
        WHERE cod_produto = p_cod_produto;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            INSERT INTO TAB_ERRO (dataerro, campo1, campo2)
            VALUES (SYSDATE, 'Código do produto inexistente: ' || p_cod_produto,'. Descrição não disponível.');
            -- Encerra o procedimento, pois o produto não existe.
            RETURN;
    END;
    
    -- log de inicio da operação
    INSERT INTO TABLOG (datalog, campo1, campo2)
    VALUES(
        sysdate,
        '1 - Inicio da operação',
        'Produto: ' || p_cod_produto);

    -- Verifica se há pedidos para o produto
    SELECT COUNT(*) INTO v_pedidos_existem
    FROM Item_pedido
    WHERE Cod_produto = p_cod_produto;


    IF v_pedidos_existem = 0 THEN       
        --Log de anuncio da exclusao
        INSERT INTO TAB_ERRO (dataerro, campo1, campo2)
        VALUES (SYSDATE,
                'Exclusão - Código: ' || p_cod_produto,
                'Descrição: ' || v_descricao || ' | Usuário: ' || USER);
        
        --deletando o produto sem pedidos
        DELETE FROM produto
        WHERE cod_produto = p_cod_produto;
        
        --log de confirmação da exclusão do produto sem pedido
        INSERT INTO TABLOG (datalog, campo1, campo2)
        VALUES (SYSDATE, 'Sucesso - Produto excluído', 'Produto: ' || p_cod_produto);
    ELSE 
        RAISE_APPLICATION_ERROR(
            -20000,
            'Erro, produto com pedidos associaodos.Código: ' || p_cod_produto);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DECLARE
            v_cod_erro NUMBER := SQLCODE;
            v_msg_erro VARCHAR2(100) := SUBSTR(SQLERRM, 1, 100);
        BEGIN
            INSERT INTO TAB_ERRO(dataerro, campo1, campo2)
            VALUES (SYSDATE,
                    'Erro inesperado: (' || v_cod_erro || ')',
                    SUBSTR('Msg: ' || v_msg_erro || ' | Ao processar produto: ' || p_cod_produto, 1, 100)
                   );
            RAISE;
        END; 
END DELETAR_PRODUTO_SEM_PEDIDO;

------------------- Exercicio 4 -------------------
CREATE OR REPLACE PROCEDURE ATUALIZA_PRECO_POR_UNIDADE (p_unidade VARCHAR2)
AS
    v_linhas_afetadas NUMBER;
BEGIN

    BEGIN
        SELECT unidade INTO v_unidade_teste -- v_unidade_teste pode nem ser necessária se você só quer testar a existência
        FROM produto
        WHERE unidade = p_unidade
          AND ROWNUM = 1; -- Garante que apenas uma linha seja buscada
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            INSERT INTO TAB_ERRO (dataerro, campo1, campo2)
            VALUES (SYSDATE, 'Unidade inexistente na tabela Produto: ' || p_unidade, 'Nenhum produto encontrado com esta unidade.');
            RETURN;
    END;

    -- log de inicio da operação
    INSERT INTO TABLOG (datalog, campo1, campo2)
    VALUES (SYSDATE, 'Inicio Atualizar_preco_por_unidade','Unidade: ' || p_unidade);

    --Atualiza o valor_unitario em 10% para os produtos com a unidade parâmetro
    UPDATE PRODUTO
    SET valor_unitario = valor_unitario * 1.1
    WHERE unidade = p_unidade;

    -- captura o número de linhas que foram afetadas pelo UPDATE
    v_linhas_afetadas := SQL%ROWCOUNT;

    -- Log dos requisitos do enunciado
    INSERT INTO TABLOG (datalog, campo1, campo2)
    VALUES (SYSDATE,
            'Produtos com preço modificado= ',
            TO_CHAR(v_linhas_afetadas));

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
    INSERT INTO TabLog (datalog, campo1, campo2)
        VALUES (SYSDATE,
                'ERRO em ATUALIZAR_PRECO_POR_UNIDADE',
                SUBSTR('Unidade: ' || p_unidade || ' - Erro: ' || SQLERRM, 1, 60)
               );
        RAISE;
END ATUALIZAR_PRECO_POR_UNIDADE;
