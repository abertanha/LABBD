-- LISTA 5 DE FUNÇÕES - ADRIANO BERTANHA 0030482321026

-- EXERCÍCIO 3
ALTER TABLE PRODUTO
ADD QTDE_ESTOQUE number; -- LETRA B)

CREATE OR REPLACE FUNCTION FN_ConsultaEstoque(P_COD_PRODUTO PRODUTO.COD_PRODUTO%TYPE) -- LETRA A)
RETURN NUMBER
AS
    v_qtde_estoque produto.QTDE_ESTOQUE%TYPE;
Begin
    
    SELECT QTDE_ESTOQUE INTO V_QTDE_ESTOQUE
    FROM produto
    WHERE COD_PRODUTO = P_COD_PRODUTO;

    RETURN V_QTDE_ESTOQUE;
exception
    WHEN no_data_found THEN
        INSERT INTO TAB_ERRO (dataerro, campo1, campo2)
        values (sysdate, 'Código do produto inexistente', P_COD_PRODUTO);
        RETURN NULL;
end FN_ConsultaEstoque;

-- LETRA C)
-- vou atualizar os valores de qtde estoque
UPDATE PRODUTO
SET QTDE_ESTOQUE = FLOOR(DBMS_RANDOM.VALUE(1, 101))
WHERE QTDE_ESTOQUE IS NULL;

SELECT descricao, FN_ConsultaEstoque(cod_produto) AS estoque
FROM produto;

-- EXERCÍCIO 5

CREATE OR REPLACE FUNCTION fn_ClassificarCliente(p_cod_cliente cliente.cod_cliente%TYPE)
RETURN VARCHAR2
AS
    v_nome_cliente cliente.NOME_CLIENTE%TYPE;
    v_qtde_pedido NUMBER;
    v_mensagem VARCHAR2(200);
BEGIN
    -- verifica se o cliente existe
    SELECT NOME_CLIENTE INTO v_nome_cliente
    FROM cliente
    WHERE cod_cliente = p_cod_cliente;

    -- contando pedidos
    SELECT COUNT(*) INTO v_qtde_pedido
    FROM PEDIDO
    WHERE cod_cliente = p_cod_cliente;

    -- classificação
    IF v_qtde_pedido > 3 THEN
        v_mensagem := 'Cliente preferencial - Código: ' || p_cod_cliente || ', Nome: ' || v_nome_cliente;
    ELSIF v_qtde_pedido BETWEEN 1 AND 3 THEN
        v_mensagem := 'Cliente normal - Código: ' || p_cod_cliente || ', Nome: ' || v_nome_cliente;
    ELSE
        v_mensagem := 'Cliente Inativo - Código: ' || p_cod_cliente || ', Nome: ' || v_nome_cliente;
    END IF;

    RETURN v_mensagem;
EXCEPTION
    WHEN no_data_found THEN
        RETURN 'Erro: Cliente com código ' || p_cod_cliente || 'não encontrado';
    WHEN OTHERS THEN
        RETURN 'Erro inesperado: ' || SQLERRM;

END fn_ClassificarCliente;
    


