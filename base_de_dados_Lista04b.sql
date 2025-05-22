CREATE TABLE Cliente (
    cod_cliente NUMBER PRIMARY KEY,
    nome_cliente VARCHAR2(30),
    endereco    VARCHAR2(30),
    cidade  VARCHAR2(20),
    cep VARCHAR2(10),
    uf  VARCHAR2(2)
);

CREATE TABLE Vendedor (
    Cod_vendedor    NUMBER PRIMARY KEY,
    Nome_vendedor  VARCHAR2(30),
    Faixa_comissao NUMBER(4,2),
    Salario_fixo   NUMBER(7,2)
);

CREATE TABLE Produto (
    cod_produto NUMBER PRIMARY KEY,
    descricao VARCHAR2(20),
    unidade VARCHAR2(2),
    valor_unitario NUMBER(6,2)
);

CREATE TABLE Pedido (
    Num_pedido     NUMBER PRIMARY KEY,
    Prazo_entrega  DATE,
    Cod_cliente    NUMBER,
    Cod_vendedor   NUMBER,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (Cod_cliente) REFERENCES Cliente(Cod_cliente),
    CONSTRAINT fk_pedido_vendedor FOREIGN KEY (Cod_vendedor) REFERENCES Vendedor(Cod_vendedor)
);

CREATE TABLE Item_pedido (
    Num_pedido     NUMBER,
    Cod_produto    NUMBER,
    Quantidade     NUMBER(5),
    CONSTRAINT pk_item_pedido PRIMARY KEY (Num_pedido, Cod_produto),
    CONSTRAINT fk_item_pedido_pedido FOREIGN KEY (Num_pedido) REFERENCES Pedido(Num_pedido),
    CONSTRAINT fk_item_pedido_produto FOREIGN KEY (Cod_produto) REFERENCES Produto(Cod_produto)
);

------------------------------------------
-- Inserção na tabela Cliente (10 registros)
------------------------------------------
INSERT INTO Cliente VALUES (1, 'Maria Silva', 'Rua das Flores, 123', 'São Paulo', '01234-567', 'SP');
INSERT INTO Cliente VALUES (2, 'João Oliveira', 'Av. Brasil, 456', 'Rio de Janeiro', '20000-000', 'RJ');
INSERT INTO Cliente VALUES (3, 'Ana Souza', 'Rua da Praia, 789', 'Salvador', '40000-000', 'BA');
INSERT INTO Cliente VALUES (4, 'Carlos Pereira', 'Alameda Santos, 101', 'Belo Horizonte', '30123-456', 'MG');
INSERT INTO Cliente VALUES (5, 'Fernanda Lima', 'Av. Paulista, 2020', 'São Paulo', '01310-100', 'SP');
INSERT INTO Cliente VALUES (6, 'Pedro Costa', 'Rua XV de Novembro, 55', 'Curitiba', '80050-000', 'PR');
INSERT INTO Cliente VALUES (7, 'Juliana Almeida', 'Travessa das Acácias, 7', 'Porto Alegre', '90010-010', 'RS');
INSERT INTO Cliente VALUES (8, 'Ricardo Nunes', 'Av. Beira Mar, 300', 'Fortaleza', '60000-000', 'CE');

------------------------------------------
-- Inserção na tabela Vendedor (8 registros)
------------------------------------------
INSERT INTO Vendedor VALUES (101, 'Roberto Santos', 0.10, 3500.00);
INSERT INTO Vendedor VALUES (102, 'Patrícia Oliveira', 0.12, 4200.50);
INSERT INTO Vendedor VALUES (103, 'Lucas Mendes', 0.08, 2800.75);
INSERT INTO Vendedor VALUES (104, 'Camila Costa', 0.15, 5200.00);
INSERT INTO Vendedor VALUES (105, 'Gustavo Rocha', 0.09, 3100.00);
INSERT INTO Vendedor VALUES (106, 'Amanda Lima', 0.11, 3800.25);
INSERT INTO Vendedor VALUES (107, 'Felipe Gomes', 0.07, 2650.90);
INSERT INTO Vendedor VALUES (108, 'Isabela Martins', 0.13, 4400.00);

------------------------------------------
-- Inserção na tabela Produto (10 registros)
------------------------------------------
INSERT INTO Produto VALUES (1001, 'Notebook Dell', 'UN', 4500.00);
INSERT INTO Produto VALUES (1002, 'Mouse Sem Fio', 'UN', 89.90);
INSERT INTO Produto VALUES (1003, 'Teclado Mecânico', 'UN', 250.00);
INSERT INTO Produto VALUES (1004, 'Monitor 24"', 'UN', 899.00);
INSERT INTO Produto VALUES (1005, 'Impressora Laser', 'UN', 1200.00);
INSERT INTO Produto VALUES (1006, 'HD Externo 1TB', 'UN', 299.90);
INSERT INTO Produto VALUES (1007, 'Webcam Full HD', 'UN', 159.50);
INSERT INTO Produto VALUES (1008, 'Headphone Gamer', 'UN', 399.00);
INSERT INTO Produto VALUES (1009, 'Tablet Samsung', 'UN', 1500.00);
INSERT INTO Produto VALUES (1010, 'Pen Drive 64GB', 'UN', 45.90);

------------------------------------------
-- Inserção na tabela Pedido (12 registros)
------------------------------------------
INSERT INTO Pedido VALUES (5001, TO_DATE('2023-11-15', 'YYYY-MM-DD'), 1, 101);
INSERT INTO Pedido VALUES (5002, TO_DATE('2023-11-18', 'YYYY-MM-DD'), 2, 102);
INSERT INTO Pedido VALUES (5003, TO_DATE('2023-11-20', 'YYYY-MM-DD'), 3, 103);
INSERT INTO Pedido VALUES (5004, TO_DATE('2023-11-22', 'YYYY-MM-DD'), 4, 104);
INSERT INTO Pedido VALUES (5005, TO_DATE('2023-11-25', 'YYYY-MM-DD'), 5, 105);
INSERT INTO Pedido VALUES (5006, TO_DATE('2023-11-28', 'YYYY-MM-DD'), 6, 106);
INSERT INTO Pedido VALUES (5007, TO_DATE('2023-12-01', 'YYYY-MM-DD'), 7, 107);
INSERT INTO Pedido VALUES (5008, TO_DATE('2023-12-05', 'YYYY-MM-DD'), 8, 108);
INSERT INTO Pedido VALUES (5009, TO_DATE('2023-12-10', 'YYYY-MM-DD'), 1, 101);
INSERT INTO Pedido VALUES (5010, TO_DATE('2023-12-12', 'YYYY-MM-DD'), 2, 102);
INSERT INTO Pedido VALUES (5011, TO_DATE('2023-12-15', 'YYYY-MM-DD'), 3, 103);
INSERT INTO Pedido VALUES (5012, TO_DATE('2023-12-20', 'YYYY-MM-DD'), 4, 104);

------------------------------------------
-- Inserção na tabela Item_pedido (15 registros)
------------------------------------------
INSERT INTO Item_pedido VALUES (5001, 1001, 1);
INSERT INTO Item_pedido VALUES (5001, 1002, 2);
INSERT INTO Item_pedido VALUES (5002, 1003, 1);
INSERT INTO Item_pedido VALUES (5003, 1004, 3);
INSERT INTO Item_pedido VALUES (5004, 1005, 1);
INSERT INTO Item_pedido VALUES (5005, 1006, 2);
INSERT INTO Item_pedido VALUES (5006, 1007, 4);
INSERT INTO Item_pedido VALUES (5007, 1008, 1);
INSERT INTO Item_pedido VALUES (5008, 1009, 2);
INSERT INTO Item_pedido VALUES (5009, 1010, 5);
INSERT INTO Item_pedido VALUES (5010, 1001, 1);
INSERT INTO Item_pedido VALUES (5011, 1002, 3);
INSERT INTO Item_pedido VALUES (5012, 1003, 2);
INSERT INTO Item_pedido VALUES (5002, 1004, 1);
INSERT INTO Item_pedido VALUES (5003, 1005, 1);


commit;

Create table TabLog
(datalog date,
campo1 varchar2(100),
campo2 varchar2(100);

Create table Tab_erro
( dataerro date,
mensagem varchar2(100));