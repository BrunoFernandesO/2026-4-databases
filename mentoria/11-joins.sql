/* You must have already seen me use JOIN several times, now it's time to learn
what does each JOIN do. Basically JOINs combine rows from two tables based on a condition. 
The difference between them is what happens when there's no match.

----------------------- INNER JOIN -------------------------
Also known as JOIN, Returns only rows that have a match on both sides
You must use ON to declare which columns should match.

Syntax:
SELECT t1.col, t2.col
FROM table_1 t1 
JOIN table_2 t2 ON t1.col2 = t2.col2

The SELECT above will return only rows where t1.col2 match t2.col2
------------------------------------------------------------

------------------------ LEFT JOIN --------------------------
Returns all rows from the left table, plus matching rows from the right. 
If there is no match on the right, returns NULL

By "Left table" I mean the table that is right after FROM statement.

Syntax:
SELECT t1.col, t2.col
FROM table_1 t1 --> table_1 is the Left table
LEFT JOIN table_2 t2 --> table_2 is the Right table
ON t1.col2 = t2.col2

The SELECT above will return every t1.col, if any value in t1.col2 does not match with
t2.col2 the query will return NULL
-------------------------------------------------------------

------------------------- RIGHT JOIN ---------------------------
The mirror of LEFT JOIN. Returns all rows from the right table, NULLs on the left where no match.
This is barely used, since you can always rewrite a RIGHT JOIN as a LEFT JOIN by just swapping the tables.

Syntax:
SELECT t1.col, t2.col
FROM table_1 t1 --> table_1 is the Left table
RIGHT JOIN table_2 t2 --> table_2 is the Right table
ON t1.col2 = t2.col2

The SELECT above will return every t2.col, if any value in t2.col2 does not match with
t1.col2 the query will return NULL
----------------------------------------------------------------

-------------------- FULL OUTER JOIN ---------------------------
Returns EVERY ROW from both tables. NULLs fill in wherever there's no match on either side.

Example with our database:
SELECT u.nome, p.status
FROM usuario u
FULL OUTER JOIN pedido p
ON p.id_usuario = u.id

Usuarios with no pedidos appear. Pedidos with no usuario appear. Everything shows up.
---------------------------------------------------------------

------------------------- CROSS JOIN ---------------------------
Returns every combination of rows from both tables.
Careful: No ON condition.

Syntax: 
SELECT u.nome, pr.nome
FROM usuario u
CROSS JOIN produto pr

If there are 5 usuarios and 7 produtos, this query will return 35 rows (5 x 7 = 35)
----------------------------------------------------------------

------------------------- SELF JOIN ---------------------------
A table joined with itself. 
It's useful when rows in a table reference other rows in the same table
e.g: An employee table where each employee has a manager who is also an employee.

Example:
SELECT a.nome AS funcionario, b.nome AS gerente
FROM funcionario a
JOIN funcionario b ON a.id_gerente = b.id;

Self join doesn't make sense with this current schema, since there is 
no table referencing itself. But it's always good to know.
--------------------------------------------------------------

Let's go with some exercises!
*/

-- 1. List all usuarios and how many pedidos each one made, including usuarios with zero pedidos.
SELECT u.username, COUNT(pe.id) AS qt_pedidos
FROM pedido pe
RIGHT JOIN usuario u ON u.id = pe.id_usuario
GROUP BY u.username

-- 2. List all products that have never been rated.
SELECT pr.nome, COUNT(a.id_produto) AS qt_avaliacoes
FROM produto pr
LEFT JOIN avaliacao a ON a.id_produto = pr.id
GROUP BY pr.nome
HAVING COUNT(a.id_produto) = 0

-- 3. Show each produto's name and its average nota. Products with no ratings should appear with NULL.
SELECT pr.nome, AVG(a.nota) AS nota_media
FROM produto pr
LEFT JOIN avaliacao a ON a.id_produto = pr.id
GROUP BY pr.nome

-- 4. Show all pedidos and the total value of each one (preco × quantidade). Order by total value descending.
SELECT pe.id, SUM(ip.quantidade*pr.preco) AS valor_total
FROM pedido pe
JOIN item_pedido ip ON ip.id_pedido = pe.id
JOIN produto pr ON pr.id = ip.id_produto
GROUP BY pe.id
ORDER BY SUM(ip.quantidade*pr.preco) DESC

-- 5. List usuarios who have made at least one pedido with status 'ENTREGUE', showing their name and how many ENTREGUE pedidos they have.
SELECT u.nome, COUNT(pe.status) AS pedidos_entregues
FROM usuario u
JOIN pedido pe ON pe.id_usuario = u.id
GROUP BY u.nome