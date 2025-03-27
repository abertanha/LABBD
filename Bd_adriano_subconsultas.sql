Fatec Sorocaba - ADS
Aula Pr�tica de LBD  - atualizado em 09-09-2024
Prof. Maria Ang�lica C. de Andrade Cardieri
-------------------------------------------------------------------------------------------------------------------

Subconsultas
============

Uma subquery ou subconsulta  � quando o resultado de uma consulta � utilizado por 
outra consulta, de forma encadeada e contida no mesmo comando SQL.


Restri��es:

�	A query interna deve ser usada dentro de par�nteses
�	A subquery n�o pode conter a cl�usula order by
�	Quando utilizando m�ltiplas colunas em uma subquery, estas colunas devem aparecer na mesma ordem  
         e com os mesmos tipos de dados da query principal, al�m do mesmo n�mero de colunas
�	Podem ser utilizados operadores l�gicos 



select ......from ....
        where a =  (select a from ... where....);



Exemplo1: Listar a descri��o do produto que tem o pre�o unit�rio maior que a m�dia.

forma 1: com 2 selects isolados

(select avg(valor_unit) from TB_PRODUTO);
678,97

select * from tb_produto
where valor_unit > 678,97;

forma 2: usando subconsulta

select * from tb_produto
where valor_unit > (select avg(valor_unit) from TB_PRODUTO);



ou com subconsulta:

        select descricao from tb_produto 
        where valor_unit > (select avg(valor_unit) from TB_PRODUTO);

	>   <    >=   <=   <>


Exemplo2: Listar o nome dos clientes que moram na mesma cidade do 'Jo�o da Silva';


    select nomecliente from Tb_cliente
    where nomecliente <> 'Jo�o da Silva'  
    and cidade = (select cidade from Tb_cliente where nomecliente = 'Jo�o da Silva');	

    x in (x,y,z)


Exemplo3: Listar o nome dos clientes que tem pedidos


** Pode ser feito usando jun��o:

select nomecliente from TB_cliente inner join tb_pedido
on tb_pedido.codcliente = tb_cliente.codcliente;

dar prefer�ncia a jun��o, pois � mais r�pida a execu��o e o SGBD pode usar os �ndices criados


** usando subconsultas:

exibir o nome dos clientes que tem pedidos:

 select nomecliente from TB_cliente
 where codcliente in ( select codcliente from TB_pedido);

	n�o � t�o eficiente.	

Pode ser feito usando Intersect

select codcliente from tb_cliente
intersect
select codcliente from tb_pedido;

Exemplo4: Listar o nome dos clientes que n�o tem pedidos

select codcliente, nomecliente from tb_cliente
 where codcliente not in ( select codcliente from TB_pedido);

-- usando operador da algebra relacional(mais restrita a exibi��o)
select codcliente from TB_cliente
minus 
select  codcliente  from TB_pedido


select nome_cliente from cliente,pedido
where pedido.cod_cliente <> cliente.cod_cliente; --- n�o funciona




Exemplo 5: Listar o nome do vendedor que n�o tem pedidos com prazo de entrega em fevereiro/2020.
========


 select tb_vendedor.codvendedor,nomevendedor
 from Tb_vendedor, tb_pedido
 where Tb_pedido.codvendedor = tb_vendedor.codvendedor and 
 to_char(prazo_entrega,'mm/yyyy') <> '08/2024'; 


A consulta acima n�o contempla o vendedor que nunca fez pedidos

select nomevendedor from tb_vendedor
where codvendedor not in (select codvendedor from tb_pedido
                   where to_char(prazo_entrega,'mm/yyyy') = '08/2024')



para se filtrar  02 de 2020 podemos usar:


where to_char(prazo_entrega,'mm/yyyy') = '08/2020'

ou
 where prazo_entrega between '01/08/2020' and '31/08/2020';


 --year(prazo_entrega) = 2020 and month(prazo_entrega) = 08 sql server

(extract year from prazo_entrega)  = 2020 and (extract month from prazo_entrega) 


Exemplo 6: Listar o c�digo do produto que tem o menor pre�o.
============================================================

select min(valor_unitario), cod_produto from produto   ; Errado n�o funciona


 select cod_produto, valor_unitario from produto
  where valor_unitario = (select min(valor_unitario) from produto); 

correto


exercicio extra:

Listar o codigo dos  vendedores que fizeram  mais pedidos que o vendedor de nome �Carlos Sola'


 select tb_pedido.codvendedor, nomevendedor,count(*) 
 from tb_pedido,tb_vendedor
 where tb_pedido.codvendedor = tb_vendedor.codvendedor
 group by tb_pedido.codvendedor, nomevendedor
 having count(*)>  (select count(*) from tb_pedido,tb_vendedor
	where tb_pedido.codvendedor = tb_vendedor.codvendedor
	and nomevendedor = 'Carlos Sola');

================================================
obs sobre o uso do operador in

   select * from cliente 
   where cidade in ('Sorocaba','Itu');

� a mesma coisa que:

   select * from cliente 
   where cidade = 'Sorocaba'  or cidade = 'Itu';

/*===========================================================================

operadores:


= > < <> <= >=         => usar qdo a subconsulta compara 1 elem.

in  
not in                 => usar qdo a subconsulta devolve v�rios elem.			
                	elementos (testa se pertence a um conjunto)


Exists
not exists	       =>  Testa se o select interno � verdadeiro 	
    			   ou falso


===========================================*/
Exerc�cio subconsultas em aula:

select * from tb_vendedor
select * from tb_pedido
select * from tb_cliente

Listar o codigo dos  vendedores que fizeram  mais pedidos que o 
vendedor de nome 'Carlos Sola'


 select tb_pedido.codvendedor, nomevendedor,count(*) 
 from tb_pedido,tb_vendedor
 where tb_pedido.codvendedor = tb_vendedor.codvendedor
 group by tb_pedido.codvendedor, nomevendedor
 having count(*)>  (select count(*) from tb_pedido,tb_vendedor
	where tb_pedido.codvendedor = tb_vendedor.codvendedor
	and nomevendedor = 'Carlos Sola');
    
-------------------------------------------------------------------------------------------
-- Complemento aula de Subconsultas  - Parte 02

   -- Operador EXISTS  -  executa a consulta externa se a interna for Verdadeira

select * from tabela where exists ( select ...)             se retornar 1 ou + linhas � verdadeiro
                                                                                   se retornar zero linha � Falso.
    
   -- Exemplo1:  listar o nome dos clientes que tem pedidos
    
    -- Compara��o Usando IN  

    select nomecliente from tb_cliente
    where codcliente in (select codcliente from tb_pedido);
    
    -- usando Exists  - comando incorreto

    select nomecliente from tb_cliente
    where exists (select codcliente from tb_pedido) 
                       
    -- Exists -- comando correto
    
     select nomecliente from tb_cliente
    where exists (select 1 from tb_pedido 
                   where tb_cliente.codcliente = tb_pedido.codcliente);
    
    select * from tb_cliente;
 -------------------------------------------------------------------------------------------------
 Exemplo2: Listar nome dos clientes que n�o tem pedidos
 
 NOT exists   --  executa a consulta externa se a interna for FALSO
    
 usando not in
 
 select nomecliente from tb_cliente
 where codcliente not in (select codcliente from tb_pedido);
 
 usando not exists
 
    select nomecliente from tb_cliente
    where not exists (select codcliente from tb_pedido 
                   where tb_cliente.codcliente = tb_pedido.codcliente);
                   
                   
 Exerc�cio: Exibir a frase "n�o existem pedidos para o cliente 34" 
 se isso for verdade.
 
 select 'n�o existem pedidos para o cliente 34' as Consulta from dual
 where not exists(SELECT codcliente FROM tb_pedido
                  where codcliente = 34); 
 
 
 select * from tb_pedido;
 select * from tb_cliente;

 
 
 -----------------------------------------------------------------------------         
Usando subconsultas com update e delete

EX4: Excluir o cliente que n�o tem pedidos.


delete Tb_cliente
where codcliente not in (select codcliente from TB_pedido);


select * from tb_cliente;

rollback;

delete tb_cliente
where not exists (select codcliente from tb_pedido
                  where tb_pedido.codcliente = tb_cliente.codcliente);


--Ex5: Alterar em menos 20%, o pre�o dos produtos que n�o tem pedidos 

update tb_produto
set valor_unit = valor_unit * 0.80
where codproduto not in (select codproduto from tb_item_pedido);

select * from tb_produto;

rollback;

ou

update tb_produto
set valor_unit = valor_unit * 0.80
where not exists (select 1 from tb_item_pedido 
                  where tb_item_pedido.codproduto = tb_produto.codproduto);



---------------------------Ex6 com insert---------------------------

CREATE TABLE cliente_bkp
( codcliente number(5) primary key,
  nomecliente varchar2(30));

insert into cliente_bkp
select codcliente, nomecliente from tb_cliente where cidade = 'SOROCABA'

select * from cliente_bkp;


=================================================
criando uma tabela a partir de outra

create table tb_cliente_bkp
as select * from tb_cliente;

select * from tb_cliente_bkp;

create table tb_cliente_bkp2
as select * from tb_cliente where codcliente = 9999999;

select * from tb_cliente_bkp2;

drop table tb_cliente_bkp2;

create table cliente_bkp
as select codcliente,nomecliente, cidade from tb_cliente


===================================================
Fazer a lista de Subconsultas para a pr�xima aula

