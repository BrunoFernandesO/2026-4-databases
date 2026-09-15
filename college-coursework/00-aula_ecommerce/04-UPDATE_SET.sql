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