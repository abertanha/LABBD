--aula 15/05/25
select object_name from user_objects where object_type = 'PROCEDURE';

OU

Select * from user_source;

-- exibir só o texto da procedure

select text from user_source where name ='SP_ATRASO'

-- uso da variável SQL%Rowcount
-- Exemplo 1
set serveroutput ON;


DECLARE

    i NUMBER;

BEGIN

    UPDATE paciente
    SET desconto = 'N'
    WHERE datanasc > '01-01-1990';


    i := SQL%rowcount;


--note que a atribuição tem que preceder o COMMIT

    COMMIT;

    dbms_output.Put_line('Total de linhas = '||i);

END;

-- exemplo 2
create or replace procedure excluir_cliente (pcodcli number)
as
Begin
    insert into tab_erro values (sysdate,'1-Pedido de exclusão do cliente '|| pcodcli);

    delete TB_cliente
    where codcliente = pcodcli;

    if sql%rowcount = 0 then
        insert into tab_erro
        values (sysdate,'2-Cliente a ser excluído não existe' || pcodcli);
    Else
        insert into tab_erro values (sysdate,'3- Cliente excluído com sucesso '|| pcodcli);
    end if;


commit;

end;

delete tab_erro;

-- testando com cliente que não existe
exec EXCLUIR_CLIENTE (99);

-- testando com cliente que existe
select * from Tb_cliente
select * from tb_pedido
-- preparando a base de dados para os testes – incluindo com cliente sem pedidos
insert into tb_cliente values (41,'Maria','Rua x','Sorocaba', '12222-1','SP');
exec EXCLUIR_CLIENTE (99);
select * from tab_erro;

-- testar com cliente que exista e tenha pedidos
exec EXCLUIR_CLIENTE(31);
-- reescrever a procedure com tratamento de integridade referencial
Create or replace procedure excluir_cliente_FK (pcodcli number)
as
vtotal number;
vcod tb_cliente.codcliente%type;
Begin
    insert into tab_erro values (sysdate,'1-Pedido de exclusão do cliente '|| pcodcli);
    select codcliente into vcod from tb_cliente where codcliente = pcodcli;
    select count(*) into vtotal from Tb_pedido where codcliente = pcodcli;
    
    If vtotal > 0 then
        insert into tab_erro values (sysdate,'4- cliente tem pedido não pode ser excluido '|| pcodcli);
    else
        delete TB_cliente
        where codcliente = pcodcli;
        insert into tab_erro values (sysdate,'3- Cliente excluído com sucesso '|| pcodcli);
    end if;

commit;
Exception
    when no_data_found then
        insert into tab_erro values (sysdate,'2-Cliente a ser excluído não existe ' || pcodcli);
-- rollback;
end;

-- Testando
delete tab_erro;
exec excluir_cliente_FK(31) -- testar com cliente que existe e tem pedidos e verificar na tabela de erros se o resultado é o esperado.(msg = 4)
exec excluir_cliente_FK(99) -- testar com cliente que não existe
exec excluir_cliente_FK(41)
select * from tab_erro;

--utilizando raise_aplication_error



