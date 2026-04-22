/*
    ---------------UPDATE SYNTAX-----------------
    UPDATE table_name
    SET column_1 = value_1, column_2 = value_2, [...]
    WHERE condition
    -------------------------------------------
    Update commands modify existing rows in a table.
    BE CAREFUL! If you forget the WHERE clause, ALL rows in the table will be updated with NO PREVIOUS WARNING
*/

-- Update a single column for a specific user
UPDATE usuario
SET username = 'bruno.orte'
WHERE id = 1;

-- Update multiple columns at once
UPDATE produto
SET preco = 299.9, estoque = 20
WHERE id = 1;

-- Update rows based on a condition
UPDATE pedido
SET status = 'ENTREGUE'
WHERE status = 'EM PROGRESSO';

-- Update with a calculation
UPDATE produto
SET estoque = estoque - 5
WHERE nome = 'Tênis Nike Air';
