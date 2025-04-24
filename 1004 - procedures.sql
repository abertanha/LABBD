-- aula dia 10-04
--
drop table tab_erro;

create table tab_erro(
dataerro date,
mensagem varchar2(50));

Declare

    V_preco number(5);

Begin
    -- todo select tem um into
    -- todo select tem de retornar uma linha
    select valor_unit into V_preco
    from Tb_produto where codproduto = 15 ;
    
    if V_preco is null then
        update TB_produto
            set valor_unit = 100.00
        where codproduto = 15;
    end if ;
    
    commit;

Exception
    -- no_data_found é um código de erro
    -- retornado da procedure quando o 
    -- ultimo select dela retorna nulo.
    when no_data_found then
        insert into tab_erro values (sysdate, 'Produto não encontrado');

end;
/

-- testando com o produto 15
update tb_produto
set valor_unit = null
where codproduto = 15;

select * from tb_produto;
select * from tab_erro;

-- testando com o produto 99
select * from tab_erro;

-- se comentar o except não executa.


-- 24/04 --

-- primeiro teste
update tb_produto
set valor_unit = null
where codproduto = 15;

select * from tb_produto;

-- segundo teste
update tb_produto
set codproduto = 99
where codproduto = 15;

select * from tb_produto;

-- terceiro teste
-- comentar o exception para deixar o banco imprimir o erro
-- /* Exception até o ;*/

-- quarto teste
-- transformar em procedimento armazenado (dar nome)

CREATE OR REPLACE PROCEDURE  sp_atualizaPreco(Pcodprod number)
AS

    V_preco number(5);

Begin
    -- todo select tem um into
    -- todo select tem de retornar uma linha
    select valor_unit into V_preco
    from Tb_produto where codproduto = Pcodprod ;
    
    if V_preco is null then
        update TB_produto
            set valor_unit = 100.00
        where codproduto = Pcodprod;
    end if ;
    
    commit;

Exception
    when no_data_found then
        insert into tab_erro values (sysdate, 'Produto não encontrado: '||Pcodprod);
end;


exec SP_atualizaPreco(80);
select * from tab_erro;