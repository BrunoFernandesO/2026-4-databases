-- ------------------------------------------------------
-- PARTE A - AGREGAÇÃO SIMPLES (Revisão)
-- ------------------------------------------------------
-- Q30 - COUNT: Quantos produtos cadastrados?
SELECT 
    COUNT(idproduto) AS qtd_produtos 
FROM 
    produto;

-- Q31 - SUM, AVG, MAX, MIN: Estatísticas de preço
SELECT 
    SUM(preco_unitario) AS soma_total, 
	AVG(preco_unitario) AS preco_medio,
    MAX(preco_unitario) AS produto_mais_caro,
    MIN(preco_unitario) AS produto_mais_barato
FROM 
    produto;

-- Q32 - INNER JOIN + COUNT: Quantos produtos por categoria?
SELECT 
    c.nome AS nome_categoria,
    COUNT(p.idproduto) AS qtd_produtos
FROM 
    produto p 
INNER JOIN categoria c ON
    c.idcategoria = p.categoria_id
GROUP BY 
    c.nome;

-- Q33 - INNER JOIN + SUM: Faturamento total por categoria (vendas reais)
SELECT
	c.nome,
	SUM(i.preco_unitario * i.quantidade) AS faturamento_total
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
/* SELECT
    MAX(pr.preco_unitario) AS produto_mais_caro,
    MIN(pr.preco_unitario) AS produto_mais_barato
FROM
    produto pr  
INNER JOIN itempedido i ON
    pr.idproduto = i.produto_id
WHERE
    i.pedido_id IS NOT NULL;
---------------------------------------------------------------------
 CORREÇÃO: Errei nas seguintes coisas:
    1- Puxei os preços da tabela produtos, isso me mostra qual é o produto
    mais caro/barato ATUALMENTE. Se quiser pegar qual foi o produto mais caro VENDIDO
    deveria puxar da tabela itempedido, pois é ela quem salva o preço pelo qual certo 
    produto foi vendido.
    
    2- A minha query puxa apenas os PREÇOS dos produtos. O enunciado pede o PRODUTO, não o seu preço.

    O segredo é fazer SUBQUERY (Uma query dentro de outra)
-------------------------------------------------------------------- */
SELECT
	DISTINCT -- Como estou puxando de itempedido, se um produto estiver em mais de um pedido ele aparecerá duas vezes, o DISTINCT serve para eliminar linhas duplicadas.
    pr.nome,
	i.preco_unitario
FROM
	produto pr
INNER JOIN itempedido i ON
	i.produto_id = pr.idproduto
WHERE
	i.preco_unitario = (
	SELECT
		MAX(i.preco_unitario)
	FROM
		itempedido i) -- Essa subquery retorna o preco maximo, e compara com i.preco_unitario
	OR i.preco_unitario = (
	SELECT
		MIN(i.preco_unitario)
	FROM
		itempedido i) -- Essa subquery retorna o preco minimo, e compara com i.preco_unitario
ORDER BY
	i.preco_unitario DESC;

-- Q35b - SUBQUERIES: Encontre os produtos cujo estoque esta acima da media
SELECT
	p.nome,
	p.estoque
FROM
	produto p
WHERE
	p.estoque > (
	SELECT
		AVG(p.estoque)
	FROM
		produto p);

-- Q36 - JOIN 4 TABELAS + SUM: Total vendido por vendedor
SELECT
	v.nome,
	SUM(ip.preco_unitario * ip.quantidade) AS total_vendido
FROM
	pedido p --tabela 1
INNER JOIN vendedor v ON --tabela 2
	v.idvendedor = p.vendedor_id
INNER JOIN itempedido ip ON --tabela 3
	ip.pedido_id = p.idpedido
INNER JOIN produto pr ON --tabela 4 (requisito do exercicio)
	pr.idproduto = ip.produto_id
WHERE
	ip.pedido_id IS NOT NULL
GROUP BY
	v.nome;

-- Q36b - Metodo alternativo
SELECT
	v.nome AS nome_vendedor,
	SUM(p.total_pedido) AS total_vendas
FROM
	pedido p
INNER JOIN vendedor v ON
	v.idvendedor = p.vendedor_id
GROUP BY
	v.nome;

-- Q36c - Metodo alternativo 2
SELECT
	v.nome AS nome_vendedor,
	SUM(ip.preco_unitario * ip.quantidade) AS total_vendido
FROM
	pedido p
INNER JOIN vendedor v ON
	v.idvendedor = p.vendedor_id
INNER JOIN itempedido ip ON
	ip.pedido_id = p.idpedido
GROUP BY
	v.nome;

-- Q37 - LEFT JOIN + COUNT: Todas categorias + qtd produtos (mesmo com 0)
SELECT
	c.nome AS nome_categoria,
	COUNT(p.idproduto) AS qtd_produtos
FROM
	categoria c
left join produto p ON
	c.idcategoria = p.categoria_id
GROUP BY
	c.nome
ORDER BY
	COUNT(p.idproduto) DESC;

-- Q38 - LEFT JOIN + SUM: Todos produtos + total vendido (inclui nunca vendidos com 0)
SELECT
	p.nome AS nome_produto,
	COALESCE(SUM(ip.quantidade), 0) AS qtd_vendida, -- se SUM() for NULL, coalesce torna o valor 0
	COALESCE(SUM(ip.preco_unitario * ip.quantidade), 0) AS total_vendido
FROM
	produto p
LEFT JOIN itempedido ip ON
	ip.produto_id = p.idproduto
GROUP BY
	p.idproduto, p.nome
ORDER BY
	p.nome ASC;

-- Q39 - LEFT JOIN + COUNT: Todos vendedores + qtd vendas (inclui gerentes sem venda)

-- Q40 - LEFT JOIN + IS NULL (ANTI-JOIN): Vendedores que nunca venderam

-- Q41 - RIGHT JOIN: Todas categorias mesmo sem produto (inverso do LEFT)

-- Q42 - RIGHT JOIN + COUNT: Conta produtos por categoria usando RIGHT (mesmo resultado do LEFT invertido)

-- Q43 - SELF JOIN Básico: Vendedor + Nome do seu Gerente
SELECT
	v.nome AS nome_vendedor,
	g.nome AS nome_gerente
FROM
	vendedor v
INNER JOIN vendedor g ON
	g.idvendedor = v.gerente_id
ORDER BY
	v.nome ASC;

-- Q44 - SELF JOIN + COUNT: Quantos subordinados cada gerente tem?
SELECT
	g.nome,
	COUNT(s.gerente_id) AS qtd_subordinados
FROM
	vendedor g
INNER JOIN vendedor s ON
	g.idvendedor = s.gerente_id
GROUP BY
	g.nome;

-- Q45 - SELF JOIN + SUM: Faturamento por gerente (soma das vendas da equipe)
SELECT
	g.nome,
	SUM(p.total_pedido) AS total_equipe
FROM
	vendedor g
INNER JOIN vendedor v ON
	g.idvendedor = v.gerente_id
LEFT JOIN pedido p ON
	p.vendedor_id = v.idvendedor
GROUP BY
	g.nome;

-- Q46 - SELF JOIN com 2 níveis: Hierarquia completa Diretor -> Gerente -> Vendedor

-- Q47 - SELF JOIN para achar quem não é gerente de ninguém (folhas da árvore)

-- Q48 - HAVING: Vendedores que venderam mais de R$ 1000 no total
SELECT
	v.nome,
	SUM(p.total_pedido) AS total_vendido
FROM
	vendedor v
INNER JOIN pedido p ON
	p.vendedor_id = v.idvendedor
GROUP BY
	v.nome
HAVING
	SUM(p.total_pedido) > 1000;

-- Q49 - HAVING + COUNT: Clientes que fizeram mais de 1 pedido

-- Q50 - JOIN + CASE WHEN + SUM: Faturamento por faixa de preço

-- Q51 - RELATÓRIO GERENCIAL COMPLETO COM VENDEDOR

-- Q52 - DESAFIO FINAL: Ranking de Vendedores com AVG, MAX, MIN

-- Q53 - FULL OUTER SIMULADO com VENDEDOR (MySQL não tem FULL)
-- Todos vendedores + todos pedidos (mesmo sem correspondência)