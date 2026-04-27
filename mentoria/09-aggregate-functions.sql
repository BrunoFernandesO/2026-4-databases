/* Aggregate functions collapse multiple rows into a single value
There are different ways of collapsing, you can count how many rows you collapsed, or maybe sum, etc...
------------------- TYPES OF AGGREGATE FUNCTIONS --------------------
COUNT(column) ---> Returns the amount of rows (NOT NULL) that were collapsed
COUNT(*)      ---> Returns total amount of rows, independently of value.        
SUM(column)   ---> Returns the total sum of values collapsed
AVG(column)   ---> Returns the average of every value collapsed
MAX(column)   ---> Returns the highest value of the collapsed rows
MIN(column)   ---> Returns the lowest value of the collapsed rows
---------------------------------------------------------------------

--------------------------- CAREFUL! --------------------------------
You cannot mix an aggregate function with a normal column without GROUP BY 
because the server doesn't know what to show next to the collapsed value. 
If you have to mix both a normal column and an aggregate function, you must use 
GROUP BY in the normal column. There will be more examples below.
And the explanation of GROUP BY is in the next file! (10-group-by-having.sql)
----------------------------------------------------------------------
*/

-- 1. Count how many pedidos each usuario made (show username and count)
SELECT u.username, COUNT(pe.id) AS qtd_pedidos
FROM pedido pe
JOIN usuario u ON u.id = pe.id_usuario
GROUP BY u.username

-- 2. Show the average nota for each product (show product name and average)
SELECT pr.nome, AVG(a.nota) AS media
FROM produto pr
LEFT JOIN avaliacao a ON a.id_produto = pr.id
GROUP BY pr.nome