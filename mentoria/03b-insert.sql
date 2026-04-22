/* Let's populate a little more this table :D */
-- USUARIOS (ids will be 4-10)
INSERT INTO usuario (username, nome) VALUES
('rafaelmendes', 'Rafael Mendes'),
('juliana.costa', 'Juliana Costa'),
('pedro.alves', 'Pedro Alves'),
('mariasantos', 'Maria Santos'),
('thiagolima', 'Thiago Lima'),
('fernandaoliveira', 'Fernanda Oliveira'),
('lucasbarbosa', 'Lucas Barbosa')

-- PRODUTOS (ids will be 4-10)

INSERT INTO produto (nome, preco, estoque) VALUES
('Calça Jeans Slim', 199.90, 25),
('Tênis Adidas Ultraboost', 599.90, 10),
('Boné Aba Curva', 49.90, 60),
('Relógio Casio', 289.90, 12),
('Fone de Ouvido Bluetooth', 179.90, 30),
('Carteira de Couro', 89.90, 45),
('Óculos de Sol', 159.90, 20)

-- PEDIDOS (adjust id_usuario to match your real IDs)
INSERT INTO pedido (id_usuario, status) VALUES
(1, 'ENTREGUE'),
(2, 'ATRASADO'),
(3, 'ENTREGUE'),
(4, 'EM PROGRESSO'),
(5, 'CANCELADO'),
(6, 'ENTREGUE'),
(7, 'EM PROGRESSO'),
(1, 'CANCELADO'),
(3, 'ATRASADO')

-- ITEM_PEDIDO (adjust id_pedido and id_produto to match your real IDs)
INSERT INTO item_pedido (id_pedido, id_produto, quantidade) VALUES
(5, 4, 1),
(5, 5, 2),
(6, 1, 1),
(6, 6, 1),
(7, 2, 1),
(8, 7, 3),
(8, 3, 2),
(9, 4, 1),
(9, 5, 1),
(10, 6, 2),
(11, 1, 1),
(12, 7, 1),
(13, 2, 1)

-- AVALIACOES
INSERT INTO avaliacao (id_usuario, id_produto, nota, comentario) VALUES
(1, 2, 5, 'Melhor tênis que já comprei!'),
(2, 1, 4, 'Boa qualidade, entrega rápida.'),
(3, 3, 2, 'Esperava mais pelo preço.'),
(4, 4, 5, 'Relógio lindo, valeu muito!'),
(5, 5, 3, 'Som ok, mas o microfone é fraco.'),
(6, 6, 4, 'Couro de qualidade, recomendo.'),
(7, 7, 1, 'Veio com defeito, péssimo.'),
(1, 4, 4, 'Bom custo-benefício.'),
(3, 5, 5, 'Excelente, superou expectativas!')