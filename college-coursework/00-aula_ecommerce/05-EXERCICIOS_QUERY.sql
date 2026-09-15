-- ------------------------------------------------------
-- PARTE A - AGREGAÇÃO SIMPLES (Revisão)
-- ------------------------------------------------------
-- Q30 - COUNT: Quantos produtos cadastrados?
select count(idproduto) as qtd_produtos from produto;

-- Q31 - SUM, AVG, MAX, MIN: Estatísticas de preço
SELECT sum(preco_unitario) as soma_total, 
	avg(preco_unitario) as preco_medio,
    max(preco_unitario) as produto_mais_caro,
    min(preco_unitario) as produto_mais_barato
FROM produto;

-- Q32 - INNER JOIN + COUNT: Quantos produtos por categoria?
select c.nome as nome_categoria,
 count(p.idproduto) as qtd_produtos
from produto p inner join categoria c on c.idcategoria = p.categoria_id
group by c.nome;

-- teste: select p.* from produto p join categoria c on c.idcategoria = p.categoria_id where c.nome = "Periféricos";
-- Q33 - INNER JOIN + SUM: Faturamento total por categoria (vendas reais)

-- Q34 - INNER JOIN + AVG: Ticket médio por cliente

-- Q35 - INNER JOIN + MAX/MIN: Produto mais caro e mais barato vendido

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