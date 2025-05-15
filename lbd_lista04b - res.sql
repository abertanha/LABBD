--  Lista4B
-- exercício 1
Create table TabLog
(datalog date,
campo1 varchar2(60),
campo2 varchar2(60));


Create table Tab_erro
( dataerro date,
mensagem varchar2(100));

select * from tb_vendedor;
select * from tb_pedido;
select * from tb_item_pedido;

select sum(tb_produto.valor_unit * tb_item_pedido.qtde)
from tb_pedido inner join tb_item_pedido
on tb_pedido.numpedido = tb_item_pedido.numpedido
inner join tb_produto
on tb_item_pedido.codproduto = tb_produto.codproduto
where tb_pedido.codvendedor = 15;
