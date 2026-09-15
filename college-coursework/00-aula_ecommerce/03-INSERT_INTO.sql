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