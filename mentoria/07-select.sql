/*
    The SELECT command will retrieve data from one or more tables in a database
    Used for querying and viewing the database.

    ---------------SELECT SYNTAX-----------------
    SELECT column_1, column_2, [...]  -> Returns only specified columns (use * if you want to retrieve every column)
    FROM table_name t                 -> Specifies which table to retrieve data from (t is an alias of the table, instead of table_name.column, you can use t.column)
    WHERE condition                   -> Filters rows based on conditions
    ORDER BY column_name [ASC | DESC] -> Sorts the result ASCending or DESCending
    -------------------------------------------

    --------ORDERING RESULTS-----------
    - ORDER BY column_name ASC sorts in ascending order (default)
    - ORDER BY column_name DESC sorts in descending order
    - Can order by multiple columns (e.g: ORDER BY col1 ASC, col2 DESC)
    -----------------------------------

    Learn from the exercises below!
*/

-- 1. List all usernames and names from usuario, ordered alphabetically by name.
SELECT u.username, u.nome
FROM usuario u
ORDER BY u.nome --> since ascending is default, there is no need to put ASC

-- 2. List all products that cost more than R$150, ordered by price descending.
SELECT * 
FROM produto prod
WHERE prod.preco > 150
ORDER BY prod.preco DESC

-- 3. List all pedidos with status 'ENTREGUE', showing the pedido id and the date.
SELECT p.id, p.data_pedido
FROM pedido p
WHERE p.status = 'ENTREGUE' --> Don't forget that strings in SQL use single quotes

-- 4. List all products with estoque below 20.
SELECT *
FROM produto pr --> I'm using a different alias from excercise 2 here so you see that I can name the alias whatever I want.
WHERE pr.estoque < 20

--------------------------------------------- Challenge! --------------------------------------------------------------

-- 5. Show each pedido id alongside the usuario's name who made it.
SELECT p.id, u.nome 
FROM pedido p
JOIN usuario u ON u.id = p.id_usuario --> We'll learn about JOIN later! Don't worry if you don't know it yet.

-- 6. List all produtos that appear in at least one item_pedido, showing the product name and quantity ordered.
SELECT prod.nome, SUM(ip.quantidade) --> SUM(column) will return the sum of the values retrieved of the grouped columns (Must use GROUP BY later!). 
FROM item_pedido ip
JOIN produto prod ON prod.id = ip.id_produto
GROUP BY prod.nome --> Groups columns with the same name. SUM(ip.quantidade) above will sum every row that was grouped.
-->GROUP BY must have one of the columns from SELECT

-- 7. Show each usuario's name and the total number of pedidos they made.
SELECT u.nome, COUNT(p.id)
FROM usuario u
LEFT JOIN pedido p ON p.id_usuario = u.id
GROUP BY u.nome

-- 8. List all usuarios who have never made a pedido.
SELECT u.username, COUNT(p.id)
FROM usuario u
JOIN pedido p ON p.id_usuario = u.id
GROUP BY u.username
HAVING COUNT(p.id) = 0

-- 9. Show each produto's name alongside its average rating (nota), only for products that have been rated. Order by average rating descending.
SELECT prod.nome, AVG(a.nota)
FROM produto prod
JOIN avaliacao a ON a.id_produto = prod.id
GROUP BY prod.nome
HAVING COUNT(a.id_produto) > 0
ORDER BY AVG(a.nota) DESC

-- 10. Show the name of the usuario, the product name, the quantity, and the total value (preco × quantidade) for every item in every ENTREGUE pedido.
SELECT u.nome, prod.nome, ip.quantidade, prod.preco*(ip.quantidade)
FROM usuario u
JOIN pedido p ON u.id = p.id_usuario
JOIN item_pedido ip ON ip.id_pedido = p.id
JOIN produto prod ON ip.id_produto = prod.id
WHERE p.status = 'ENTREGUE'
