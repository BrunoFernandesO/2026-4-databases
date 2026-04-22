/*
    ---------------DELETE SYNTAX-----------------
    DELETE FROM table_name
    WHERE condition
    ------------Keep in mind-------------------
    - Delete commands remove existing rows from a table.
    - BE CAREFUL!!! If you forget the WHERE clause, EVERY SINGLE ROW in the table will be DELETED (ctrl + z will NOT save you)
    - You cannot delete a row that is related to another table. You must delete the child before deleting the parent row
        - You actually can do so by using the CASCADE command, but that will affect other rows in other tables, so BE CAREFUL, once again.
    
*/

-- Delete a specific user
DELETE FROM usuario CASCADE 
--> CASCADE keyword will delete every row in pedido and avaliacao (children tables) that are contain id_usuario = 3
WHERE id = 3;

-- Delete all products with no stock
DELETE FROM produto
WHERE estoque = 0;

-- Delete cancelled orders
DELETE FROM pedido
WHERE status = 'CANCELADO';

-- Delete ratings with empty comments
DELETE FROM avaliacao
WHERE comentario = '';
