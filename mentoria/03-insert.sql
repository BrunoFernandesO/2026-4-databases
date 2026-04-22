/* 
    ---------------INSERT SYNTAX-----------------
    INSERT INTO table_name (column_1, column_2)
    (value1_col1, value1_col2),
    (value2_col1, value2_col2),
    [...]
    (valueN_col1, valueN_col2)
    -----------------------------------
    Insert commands create a new row with a certain value to a certain column
*/
INSERT INTO usuario (username, nome) VALUES
('bruno.ofernandes', 'Bruno Ortega'),
('carlossilva', 'Carlos Silva'),
('analuiza99', 'Ana Luiza Ferreira')

INSERT INTO produto (nome, preco, estoque) VALUES
('Tênis Nike Air', 349.9, 15),
('Camiseta Polo', 89.9, 40),
('Mochila Escolar', 129.5, 8)

INSERT INTO pedido (id_usuario, status) VALUES
(1, 'ENTREGUE'),
(2, 'EM PROGRESSO'),
(3, 'CANCELADO')

INSERT INTO item_pedido (id_pedido, id_produto, quantidade) VALUES
(2, 1, 2),
(2, 2, 1),
(3, 3, 1),
(1, 2, 4),
(1, 3, 2)

INSERT INTO avaliacao (id_usuario, id_produto, nota, comentario)
VALUES (1, 1, 5, 'Excelente produto!'),
(2, 3, 3, 'Razoavel pelo preco'),
(1, 2, 4, '')*/