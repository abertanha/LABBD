-- Treinos com loops
-- loop = do_while
Declare
    VloopCounter number := 105;
begin
    loop
        insert into Medico values(vLoopCounter,'Dr. Medico '||vLoopCounter);
        VLoopCounter := VloopCounter + 1;
    Exit when vLoopcounter > 150;
    end loop;
end;

select * from Medico;
rollback;

-- for
Begin
    for Vloopcounter in 1..50 loop
        insert into medico values(vLoopCounter,'Medico'||vLoopCounter);
    end loop;
end;

ALTER TABLE tb_produto ADD qtde_estoque NUMBER(5);
UPDATE tb_produto
SET qtde_estoque = 500;

SELECT * FROM tb_produto;
