-- exemplo 3
-- junção
select nomecliente from TB_cliente inner join tb_pedido
on tb_pedido.codcliente = tb_cliente.codcliente;

-- subconsulta
select nomecliente from TB_cliente
where codcliente in ( select codcliente from TB_pedido);

-- intersecção
select codcliente from tb_cliente
intersect
select codcliente from tb_pedido;

-- exemplo 4

select codcliente, nomecliente from tb_cliente
where codcliente not in ( select codcliente from TB_pedido);

-- usando operador da algebra relacional(mais restrita a exibição)
select codcliente from TB_cliente
minus 
select  codcliente  from TB_pedido;

-- junção externa
-- listando os clientes que não fizeram pedido
select c.codcliente, nomecliente, p.codcliente
from tb_cliente c left join tb_pedido p
on c.codcliente = p.codcliente
where p.codcliente is null;

-- exemplo 5

select * from tb_pedido order by codvendedor;

select tb_vendedor.codvendedor,nomevendedor
 from tb_vendedor inner join tb_pedido
 on tb_pedido.codvendedor = tb_vendedor.codvendedor and 
 to_char(prazo_entrega,'yyyy') <> '2025'; 
 
-- A consulta acima não contempla o vendedor que nunca fez pedidos

select codvendedor, nomevendedor from tb_vendedor
where codvendedor not in (select codvendedor from tb_pedido
where to_char(prazo_entrega,'yyyy') = '2025');

-- para se filtrar  02 de 2020 podemos usar:

where to_char(prazo_entrega,'mm/yyyy') = '08/2020'

-- ou
where prazo_entrega between '01/08/2020' and '31/08/2020';

 --year(prazo_entrega) = 2020 and month(prazo_entrega) = 08 sql server

(extract year from prazo_entrega)  = 2020 and (extract month from prazo_entrega) 

--Exemplo 6: Listar o código do produto que tem o menor preço.

select min(valor_unitario), cod_produto from produto   ; Errado não funciona

select cod_produto, valor_unitario from produto
where valor_unitario = (select min(valor_unitario) from produto); 

-- correto

select * from tb_pedido order by codcliente;

