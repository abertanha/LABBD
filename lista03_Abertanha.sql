-- exercicio 1
select nomecliente from Tb_cliente
where nomecliente <> 'João da Silva'  
and cidade = (select cidade from Tb_cliente where nomecliente = 'João da Silva');

-- exercicio 2
select nomevendedor from tb_vendedor
where salario_fixo < (select avg(salario_fixo)from tb_vendedor);
select * from tb_vendedor;

-- exercicio 3
select codcliente from tb_pedido
where codvendedor = 5 -- errado

select nomecliente from tb_cliente inner join tb_pedido
on tb_cliente.codcliente = tb_pedido.codcliente
where tb_pedido.codvendedor = 5 and tb_cliente.codcliente
not in (select codcliente from tb_pedido where codvendedor <> 5);

-- outra maneira 

select codcliente, nomecliente from tb_cliente
where codcliente in (select codcliente from tb_pedido where codvendedor = 5
                     minus
                     select codcliente from tb_pedido where codvendedor <> 5);

select * from tb_pedido order by codcliente;
-- exercicio 4
select * from tb_vendedor
where codvendedor not in (select codvendedor from tb_pedido
                          group by codvendedor
                          having count(*) > 2);
-- esse comando não está correto pois devolve apenas vendedores
-- que fizeram 1 e 2 pedidos mas não contempla o vendedor que nunca fez pedido
select codvendedor from tb_pedido
group by codvendedor
having count(*) <= 2;

-- exercicio 5(quem não fez pedido em 2025)

select nomevendedor from tb_vendedor
where codvendedor not in (select codvendedor from tb_pedido
                          where prazo_entrega between '01-01-2025' and '31-12-2025');
-- exercicio 6

select tb_vendedor.codvendedor, tb_vendedor.nomevendedor
from tb_pedido inner join tb_vendedor
on tb_pedido.codvendedor = tb_vendedor.codvendedor
group by tb_vendedor.codvendedor, tb_vendedor.nomevendedor
having count(*) = (select max(count(*))
                    from tb_pedido group by codvendedor);
-- exercicio 7

select tb_cliente.codcliente, tb_cliente.nomecliente, count(*) as total
from tb_pedido right join tb_cliente
on tb_pedido.codcliente = tb_cliente.codcliente
group by tb_cliente.codcliente, tb_cliente.nomecliente
order by total desc;
-- exercicio 8

select * from tb_pedido;
select * from tb_item_pedido; 
delete tb_item_pedido
where numpedido in(select numpedido from tb_pedido
                    where codcliente = 32);
rollback;
-- exercicio 9 "sem vendas"

select * from tb_produto;

update tb_produto
set valor_unit = valor_unit * 0.80
where codproduto not in (select codproduto from tb_item_pedido);

rollback;

-- variação do exercicio 9

update tb_produto
set valor_unit = valor_unit * 0.80
where codproduto not in (select codproduto from tb_item_pedido inner join tb_pedido
                            on tb_pedido.numpedido = tb_item_pedido.numpedido
                            where to_char(prazo_entrega, 'yyyy') = '2025');
