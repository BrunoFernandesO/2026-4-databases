--Everything here will be in mySQL
CREATE DATABASE ECOMMERCE;
USE ECOMMERCE; -- USE command makes the code you run run in the database you specify right after

CREATE TABLE CATEGORIA(
    id int AUTO_INCREMENT PRIMARY KEY,
    nome varchar(30) NOT NULL
);

CREATE TABLE PRODUTO(
    id int NOT NULL,
    nome varchar(40) NOT NULL,
    preco_unitario decimal(10, 2),
    estoque int,
    id_categoria int
);

CREATE TABLE CLIENTE(
    id int NOT NULL,
    nome varchar(30) NOT NULL,
    cpf int,
    email varchar(50)
);

CREATE TABLE PEDIDO(
    id int AUTO_INCREMENT PRIMARY KEY,
    id_cliente int,
    data_pedido TIMESTAMP,
    total_pedido decimal(10,2)
);

CREATE TABLE ITEM_PEDIDO(
    id_pedido int,
    id_produto int,
    quantidade int,
    preco_unitario decimal(10, 2)
);

ALTER TABLE PRODUTO 
ADD CONSTRAINT produto_pk 
PRIMARY KEY (id_produto);

ALTER TABLE PRODUTO 
ADD CONSTRAINT produto_preco_unitario_ck 
CHECK (preco_unitario > 0);

ALTER TABLE PRODUTO 
ADD CONSTRAINT produto_estoque_ck 
CHECK (estoque > 0);

ALTER TABLE PRODUTO 
ADD CONSTRAINT id_categoria_fk 
FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id);

ALTER TABLE CLIENTE
ADD CONSTRAINT id_cliente_pk
PRIMARY KEY (id);

ALTER TABLE CLIENTE 
ADD CONSTRAINT cliente_cpf_uq 
UNIQUE (cpf);

ALTER TABLE CLIENTE 
ADD CONSTRAINT cliente_email_uq 
UNIQUE (email);

ALTER TABLE CLIENTE 
ADD status_cliente varchar(7) 
DEFAULT 'ATIVO';

ALTER TABLE CLIENTE 
ADD CONSTRAINT status_cliente_ck 
CHECK (status_cliente IN ('ATIVO', 'INATIVO'));

ALTER TABLE PEDIDO
ADD CONSTRAINT pedido_id_cliente_fk
FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id);

ALTER TABLE ITEM_PEDIDO 
ADD CONSTRAINT item_pedido_pk 
PRIMARY KEY (id_pedido, id_produto);


ALTER TABLE ITEM_PEDIDO 
ADD CONSTRAINT item_pedido__id_pedido__fk 
FOREIGN KEY id_pedido REFERENCES PEDIDO(id);


ALTER TABLE ITEM_PEDIDO 
ADD CONSTRAINT item_pedido__id_produto__fk 
FOREIGN KEY id_produto REFERENCES PRODUTO(id);