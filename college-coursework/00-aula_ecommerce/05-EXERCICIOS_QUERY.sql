-- ------------------------------------------------------
-- PARTE A - AGREGAÇÃO SIMPLES (Revisão)
-- ------------------------------------------------------
-- Q30 - COUNT: Quantos produtos cadastrados?
SELECT 
    count(idproduto) AS qtd_produtos 
FROM 
    produto;

-- Q31 - SUM, AVG, MAX, MIN: Estatísticas de preço
SELECT 
    sum(preco_unitario) AS soma_total, 
	avg(preco_unitario) AS preco_medio,
    max(preco_unitario) AS produto_mais_caro,
    min(preco_unitario) AS produto_mais_barato
FROM 
    produto;

-- Q32 - INNER JOIN + COUNT: Quantos produtos por categoria?
SELECT 
    c.nome AS nome_categoria,
    count(p.idproduto) AS qtd_produtos
FROM 
    produto p 
INNER JOIN categoria c ON
    c.idcategoria = p.categoria_id
GROUP BY 
    c.nome;

-- Q33 - INNER JOIN + SUM: Faturamento total por categoria (vendas reais)
SELECT
	c.nome,
	SUM(i.preco_unitario * i.quantidade) as faturamento_total
FROM
	categoria c
INNER JOIN produto p ON
	p.categoria_id = c.idcategoria
INNER JOIN itempedido i ON
	i.produto_id = p.idproduto
GROUP BY
	c.nome
ORDER BY
	faturamento_total DESC;

-- Q34 - INNER JOIN + AVG: Ticket médio por cliente
SELECT
    c.nome AS cliente,
    AVG(p.total_pedido) AS ticket_medio
FROM
    cliente c
INNER JOIN pedido p ON 
    p.cliente_id = c.idcliente
GROUP BY
    c.nome
ORDER BY 
    ticket_medio DESC;

-- Q35 - INNER JOIN + MAX/MIN: Produto mais caro e mais barato vendido
SELECT
    MAX(pr.preco_unitario) AS produto_mais_caro,
    MIN(pr.preco_unitario) AS produto_mais_barato
FROM
    produto pr  
INNER JOIN itempedido i ON
    pr.idproduto = i.produto_id
WHERE
    i.pedido_id IS NOT NULL;

-- Q36 - JOIN 4 TABELAS + SUM: Total vendido por vendedor

-- Q37 - LEFT JOIN + COUNT: Todas categorias + qtd produtos (mesmo com 0)

-- Q38 - LEFT JOIN + SUM: Todos produtos + total vendido (inclui nunca vendidos com 0)

-- Q39 - LEFT JOIN + COUNT: Todos vendedores + qtd vendas (inclui gerentes sem venda)

-- Q40 - LEFT JOIN + IS NULL (ANTI-JOIN): Vendedores que nunca venderam

-- Q41 - RIGHT JOIN: Todas categorias mesmo sem produto (inverso do LEFT)

-- Q42 - RIGHT JOIN + COUNT: Conta produtos por categoria usando RIGHT (mesmo resultado do LEFT invertido)

-- Q43 - SELF JOIN Básico: Vendedor + Nome do seu Gerente

-- Q44 - SELF JOIN + COUNT: Quantos subordinados cada gerente tem?

-- Q45 - SELF JOIN + SUM: Faturamento por gerente (soma das vendas da equipe)

-- Q46 - SELF JOIN com 2 níveis: Hierarquia completa Diretor -> Gerente -> Vendedor

-- Q47 - SELF JOIN para achar quem não é gerente de ninguém (folhas da árvore)

-- Q48 - HAVING: Vendedores que venderam mais de R$ 1000 no total

-- Q49 - HAVING + COUNT: Clientes que fizeram mais de 1 pedido

-- Q50 - JOIN + CASE WHEN + SUM: Faturamento por faixa de preço

-- Q51 - RELATÓRIO GERENCIAL COMPLETO COM VENDEDOR

-- Q52 - DESAFIO FINAL: Ranking de Vendedores com AVG, MAX, MIN

-- Q53 - FULL OUTER SIMULADO com VENDEDOR (MySQL não tem FULL)
-- Todos vendedores + todos pedidos (mesmo sem correspondência)