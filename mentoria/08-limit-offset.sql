/* 
LIMIT and OFFSET are very simple commands that limit how many data the server returns

-------------- LIMIT and OFFSET syntax -----------------
LIMIT n  --> returns only first n results.
OFFSET m --> skips first m results
---------------------------------------------------------
Some examples below:
*/

-- 1. Get the 3 cheapest products
SELECT pr.nome, pr.preco
FROM produto pr
ORDER BY pr.preco
LIMIT 3

-- 2. Get the 2nd and 3rd most recently created usuarios (skip the first, take two)
SELECT u.username, u.data_criacao
FROM usuario u
ORDER BY u.data_criacao
LIMIT 2
OFFSET 1

-- 3. Simulate page 2 of a product listing with 2 items per page
SELECT pr.nome, pr.preco, pr.estoque
FROM produto pr
ORDER BY pr.nome
LIMIT 2
OFFSET 2