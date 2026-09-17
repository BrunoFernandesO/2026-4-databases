-- ======================================================
-- AULA MYSQL - ECOMMERCE V2.0
-- NOVO: Tabela VENDEDOR com auto-relacionamento + PEDIDO com vendedor
-- Tema: JOIN, LEFT, RIGHT, SELF JOIN + SUM, MAX, MIN, COUNT, AVG
-- ======================================================

-- LIMPEZA
DROP DATABASE IF EXISTS ECOMMERCE;
CREATE DATABASE ECOMMERCE;
USE ECOMMERCE;

-- ======================================================
-- 1. CREATE TABLE - BASE DO ALUNO
-- ======================================================
CREATE TABLE CATEGORIA(
idcategoria int AUTO_INCREMENT PRIMARY KEY,
nome varchar(30) NOT NULL);

CREATE TABLE PRODUTO(
idproduto       int NOT NULL,
nome            varchar(40) NOT NULL,
preco_unitario  decimal(10,2),
estoque         int,
categoria_id    int);

CREATE TABLE CLIENTE(
idcliente int NOT NULL,
nome      varchar(30) NOT NULL,
cpf       varchar(12),
email     varchar(60));

-- NOVA TABELA VENDEDOR COM AUTO-RELACIONAMENTO
CREATE TABLE VENDEDOR(
idvendedor int AUTO_INCREMENT PRIMARY KEY,
nome varchar(30) NOT NULL,
gerente_id int,
CONSTRAINT vendedor_gerente_fk FOREIGN KEY (gerente_id) REFERENCES VENDEDOR(idvendedor)
);

CREATE TABLE PEDIDO(
idpedido int AUTO_INCREMENT PRIMARY KEY,
cliente_id int,
vendedor_id int,
data_pedido date,
total_pedido decimal(10,2));

CREATE TABLE ITEMPEDIDO(
pedido_id int,
produto_id int,
quantidade int,
preco_unitario decimal(10,2));


-- ======================================================
-- 2. ALTER TABLE - CONSTRAINTS
-- ======================================================
ALTER TABLE PRODUTO ADD CONSTRAINT produto_pk PRIMARY KEY (idproduto);
ALTER TABLE PRODUTO ADD CONSTRAINT produto_preco_unitario_ck CHECK (preco_unitario > 0);
ALTER TABLE PRODUTO ADD CONSTRAINT produto_estoque_ck CHECK (estoque >=0);
ALTER TABLE PRODUTO ADD CONSTRAINT categoria_produto_fk FOREIGN KEY (categoria_id) REFERENCES CATEGORIA(idcategoria);

ALTER TABLE CLIENTE ADD CONSTRAINT cliente_pk PRIMARY KEY (idcliente);
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_cpf_uq UNIQUE (cpf);
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_email_uq UNIQUE (email);
ALTER TABLE CLIENTE ADD status varchar(10) DEFAULT 'Ativo';
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_status_ck CHECK (status IN ('Ativo','Inativo'));

ALTER TABLE PEDIDO ADD CONSTRAINT cliente_pedido_fk FOREIGN KEY (cliente_id) REFERENCES CLIENTE(idcliente);
ALTER TABLE PEDIDO ADD CONSTRAINT vendedor_pedido_fk FOREIGN KEY (vendedor_id) REFERENCES VENDEDOR(idvendedor);

ALTER TABLE ITEMPEDIDO ADD CONSTRAINT pedido_produto_pk PRIMARY KEY (pedido_id, produto_id);
ALTER TABLE ITEMPEDIDO ADD CONSTRAINT pedido_itempedido_fk FOREIGN KEY (pedido_id) REFERENCES PEDIDO(idpedido);
ALTER TABLE ITEMPEDIDO ADD CONSTRAINT produto_itempedido_fk FOREIGN KEY (produto_id) REFERENCES PRODUTO(idproduto);
ALTER TABLE ITEMPEDIDO ADD CONSTRAINT itempedido_quantidade_ck CHECK (quantidade > 0);
ALTER TABLE ITEMPEDIDO ADD CONSTRAINT itempedido_preco_unitario_ck CHECK (preco_unitario > 0);

-- ======================================================
-- 3. INSERTS - POPULANDO
-- ======================================================
INSERT INTO CATEGORIA (nome) VALUES 
('Periféricos'),
('Eletrônicos'),
('Cadeiras Gamer'),
('Acessórios'),
('Monitores');

INSERT INTO PRODUTO VALUES
(1, 'Mouse Gamer RGB', 149.90, 50, 1),
(2, 'Teclado Gamer Mecânico', 299.90, 25, 1),
(3, 'Headset Gamer PRO', 199.90, 8, 1),
(4, 'Cadeira Gamer Thunder', 899.00, 15, 3),
(5, 'Mousepad Gamer XXL', 79.90, 100, 4),
(6, 'Monitor 24pol 144Hz', 1199.90, 12, 5),
(7, 'Notebook Gamer', 4599.90, 5, 2),
(8, 'Webcam Full HD', 189.90, 0, 2),
(9, 'Cadeira Escritório', 450.00, 20, 3),
(10, 'Suporte Monitor', 129.90, 30, 4);

INSERT INTO CLIENTE (idcliente, nome, cpf, email, status) VALUES
(1, 'Ana Silva', '11111111111', 'ana.silva@email.com', 'Ativo'),
(2, 'Bruno Costa', '22222222222', 'bruno.costa@email.com', 'Ativo'),
(3, 'Carla Dias', '33333333333', NULL, 'Inativo'),
(4, 'Diego Souza', '44444444444', 'diego.souza@email.com', 'Ativo'),
(5, 'Eva Lima', '55555555555', 'eva.lima@email.com', 'Ativo');

-- INSERT VENDEDOR COM HIERARQUIA (AUTO-RELACIONAMENTO)
-- Nivel 1: Diretor (sem gerente)
INSERT INTO VENDEDOR (idvendedor, nome, gerente_id) VALUES (1, 'Roberto Diretor', NULL);
-- Nivel 2: Gerentes que reportam para Diretor
INSERT INTO VENDEDOR (idvendedor, nome, gerente_id) VALUES 
(2, 'Fernanda Gerente', 1),
(5, 'Marcos Gerente', 1);
-- Nivel 3: Vendedores que reportam para Gerentes
INSERT INTO VENDEDOR (idvendedor, nome, gerente_id) VALUES 
(3, 'Carlos Vendedor', 2),
(4, 'Juliana Vendedor', 2),
(6, 'Patricia Vendedor', 5);

-- PEDIDOS - SEM VENDEDOR AINDA (vendedor_id NULL por enquanto para demonstrar UPDATE)
INSERT INTO PEDIDO (idpedido, cliente_id, vendedor_id, data_pedido, total_pedido) VALUES
(1, 1, NULL, '2024-11-10', 449.80),
(2, 2, NULL, '2024-11-12', 899.00),
(3, 1, NULL, '2024-12-01', 1199.90),
(4, 4, NULL, '2025-01-15', 4759.70),
(5, 2, NULL, '2025-02-20', 209.80),
(6, 5, NULL, '2025-03-10', 350.00);

INSERT INTO ITEMPEDIDO VALUES
(1, 1, 1, 149.90),
(1, 2, 1, 299.90),
(2, 4, 1, 899.00),
(3, 6, 1, 1199.90),
(4, 7, 1, 4599.90),
(4, 5, 2, 79.90),
(5, 1, 1, 149.90),
(5, 3, 1, 199.90),
(6, 10, 1, 129.90),
(6, 5, 1, 79.90);

-- ======================================================
-- 4. UPDATE - ATRIBUINDO VENDEDORES AOS PEDIDOS (Aula de UPDATE + JOIN)
-- ======================================================
-- Agora vamos atualizar os pedidos com vendedores
UPDATE PEDIDO SET vendedor_id = 3 WHERE idpedido IN (1,2); -- Carlos fez 2 vendas
UPDATE PEDIDO SET vendedor_id = 4 WHERE idpedido = 3; -- Juliana
UPDATE PEDIDO SET vendedor_id = 3 WHERE idpedido = 4; -- Carlos vendeu Notebook (venda grande)
UPDATE PEDIDO SET vendedor_id = 6 WHERE idpedido IN (5,6); -- Patricia

-- Vendedor 2 (Fernanda) e 5 (Marcos) são gerentes e 1 é diretor - não vendem direto, só gerenciam
-- Isso será útil para LEFT JOIN: vendedores sem venda


