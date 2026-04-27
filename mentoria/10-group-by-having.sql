/* 
--------------------------- GROUP BY ----------------------------------
GROUP BY splits rows into groups, then runs the aggregate inside each group.
Instead of one result for the whole table, you get one result per group.

---------------------------- CAREFUL! ------------------------------
Every column in SELECT that is NOT an aggregate MUST be in GROUP BY.

Fun fact: You can alias aggregate results with AS (If you dont, the column name
will come as the function name)


------------------------ HAVING -------------------------------
HAVING works just like WHERE, but the problem of WHERE is that it only works
BEFORE collapsing rows (GROUP BY / Aggregate functions), here is where HAVING joins us!

HAVING sets a condition for aggregate functions / collapsed rows.

So basically:
- WHERE filters ROWS
- HAVING filters GROUPS

Some examples and exercises below:
*/

-- 1. Show the average nota per product, but only products with average nota above 3.
SELECT pr.nome, AVG(a.nota) AS nota_media
FROM produto pr
JOIN avaliacao a ON a.id_produto = pr.id
GROUP BY pr.nome
HAVING AVG(a.nota) > 3

-- 2. Count pedidos per status.
SELECT pe.status, COUNT(pe.id) AS qt_pedidos
FROM pedido pe
GROUP BY pe.status

-- 3. Show username and total amount spent (preco × quantidade) across all their pedidos.
-- Only show usuarios who spent more than R$300.
SELECT u.username, SUM(pr.preco*ip.quantidade) AS total_gasto
FROM usuario u
JOIN pedido pe ON u.id = pe.id_usuario
JOIN item_pedido ip ON ip.id_pedido = pe.id
JOIN produto pr ON pr.id = ip.id_produto
GROUP BY (u.username)
HAVING SUM(pr.preco*ip.quantidade) > 300