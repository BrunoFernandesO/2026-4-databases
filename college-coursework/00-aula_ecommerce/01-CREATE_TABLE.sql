-- ======================================================
-- AULA MYSQL - ECOMMERCE V2.0
-- NOVO: Tabela VENDEDOR com auto-relacionamento + PEDIDO com vendedor
-- Tema: JOIN, LEFT, RIGHT, SELF JOIN + SUM, MAX, MIN, COUNT, AVG
-- ======================================================

-- LIMPEZA
DROP DATABASE IF EXISTS ECOMMERCE2;
CREATE DATABASE ECOMMERCE2;
USE ECOMMERCE2;

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