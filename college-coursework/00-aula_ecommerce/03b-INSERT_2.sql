-- ============================================================
-- CONTINUATION SEED SCRIPT
-- Builds on top of your EXISTING data (categoria 1-5, produto 1-10,
-- cliente 1-5, vendedor 1-6, pedido 1-6, itempedido as already loaded).
-- All new IDs below start strictly after your current maximums, so
-- nothing here collides with what's already in the tables.
-- ============================================================

-- ------------------------------------------------------------
-- 0. CORRECTION: pedido 5 and 6 had total_pedido values that
--    didn't match their itempedido sums (they were swapped, and
--    pedido 6 was also off by 0.20).
--    pedido 5 items: 149.90 + 199.90 = 349.80
--    pedido 6 items: 79.90 + 129.90 = 209.80
-- ------------------------------------------------------------
UPDATE pedido SET total_pedido = 349.80 WHERE idpedido = 5;
UPDATE pedido SET total_pedido = 209.80 WHERE idpedido = 6;

-- ------------------------------------------------------------
-- 1. CATEGORIA (auto_increment picks up from 6)
-- Edge case: 'Cabos e Adaptadores' (7) ends up with ZERO produtos -> Q37
-- ------------------------------------------------------------
INSERT INTO categoria (idcategoria, nome) VALUES
(6, 'Áudio'),
(7, 'Cabos e Adaptadores');  -- 0 produtos

-- ------------------------------------------------------------
-- 2. PRODUTO (not auto_increment — explicit IDs, starting at 11)
-- Edge case: 'Fone de Ouvido Gamer' (11) is NEVER sold -> Q38
-- Respects CHECK constraints: preco_unitario > 0, estoque >= 0
-- ------------------------------------------------------------
INSERT INTO produto (idproduto, nome, preco_unitario, estoque, categoria_id) VALUES
(11, 'Fone de Ouvido Gamer',    249.90,  40, 6),  -- nunca vendido
(12, 'Caixa de Som Bluetooth',  179.90,  22, 6),
(13, 'Microfone Condensador',   349.90,  10, 6),
(14, 'Cadeira Gamer Pro Max',   1299.00, 6,  3),
(15, 'Mouse Pad Speed Grande',  49.90,   80, 4),
(16, 'Hub USB-C 7 portas',      99.90,   35, 4),
(17, 'Monitor Ultrawide 34pol', 2199.90, 5,  5),
(18, 'Notebook Ultra Slim',     3899.00, 7,  2),
(19, 'Smartwatch Gamer',        899.90,  14, 2);

-- ------------------------------------------------------------
-- 3. CLIENTE (not auto_increment — explicit IDs, starting at 6)
-- Respects UNIQUE cpf/email and the status CHECK ('Ativo'/'Inativo')
-- Edge case: Julio Prado (10) NEVER places an order
-- ------------------------------------------------------------
INSERT INTO cliente (idcliente, nome, cpf, email, status) VALUES
(6,  'Fernando Alves',  '66666666666',  'fernando.alves@email.com',  'Ativo'),
(7,  'Gabriela Nunes',  '77777777777',  'gabriela.nunes@email.com',  'Ativo'),
(8,  'Henrique Melo',   '88888888888',  'henrique.melo@email.com',   'Ativo'),
(9,  'Isabela Rocha',   '99999999999',  'isabela.rocha@email.com',   'Inativo'),
(10, 'Julio Prado',     '10101010101',  'julio.prado@email.com',     'Ativo'); -- nunca compra

-- ------------------------------------------------------------
-- 4. VENDEDOR (auto_increment picks up from 7)
-- Edge case: Beatriz (7) reports to Marcos but NEVER sells -> Q40 anti-join
-- Edge case: Rafael (8) has NO gerente_id, but DOES sell -> self-join NULL case
-- ------------------------------------------------------------
INSERT INTO vendedor (idvendedor, nome, gerente_id) VALUES
(7, 'Beatriz Alves', 5),     -- nunca vende
(8, 'Rafael Torres', NULL);  -- sem gerente, mas vende

-- ------------------------------------------------------------
-- 5. PEDIDO (auto_increment picks up from 7)
-- total_pedido pre-calculated to match itempedido sums below.
-- ------------------------------------------------------------
INSERT INTO pedido (idpedido, cliente_id, vendedor_id, data_pedido, total_pedido) VALUES
(7,  6,  3, '2025-04-05', 279.70),
(8,  7,  4, '2025-04-10', 3899.00),
(9,  8,  6, '2025-04-15', 999.80),
(10, 2,  3, '2025-05-01', 349.90),
(11, 9,  8, '2025-05-05', 2199.90),
(12, 1,  4, '2025-05-10', 1348.90),
(13, 6,  6, '2025-05-15', 359.80),
(14, 4,  8, '2025-06-01', 449.60),
(15, 3,  3, '2025-06-05', 4399.90),
(16, 7,  4, '2025-06-10', 49.90),
(17, 9,  6, '2025-06-15', 1349.00),
(18, 5,  8, '2025-06-20', 1199.90);

-- ------------------------------------------------------------
-- 6. ITEMPEDIDO
-- Composite PK (pedido_id, produto_id) — all pairs below use fresh
-- pedido_id values (7-18), so no collision with existing rows.
-- Edge case: Notebook Gamer (7) sold here at 4399.90 (pedido 15),
-- vs. its catalog price of 4599.90 and its earlier sale at 4599.90
-- in pedido 4 -> reinforces catalog price vs. actual sale price.
-- Edge case: Mouse Pad Speed Grande (15) sold at 49.90 (pedido 16)
-- becomes the new overall minimum sale price across all data.
-- ------------------------------------------------------------
INSERT INTO itempedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(7,  12, 1, 179.90),
(7,  15, 2, 49.90),
(8,  18, 1, 3899.00),
(9,  19, 1, 899.90),
(9,  16, 1, 99.90),
(10, 13, 1, 349.90),
(11, 17, 1, 2199.90),
(12, 14, 1, 1299.00),
(12, 15, 1, 49.90),
(13, 12, 2, 179.90),
(14, 1,  1, 149.90),
(14, 16, 3, 99.90),
(15, 7,  1, 4399.90),  -- promo price vs. catalog 4599.90
(16, 15, 1, 49.90),
(17, 4,  1, 899.00),
(17, 9,  1, 450.00),
(18, 6,  1, 1199.90);