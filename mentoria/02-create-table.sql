/*
    -----------CREATE TABLE SYNTAX-------------
    CREATE TABLE table_name(
        column_name1 TYPE CONSTRAINTS,
        column_name2 TYPE CONSTRAINTS,
        [...]
        column_nameN TYPE CONSTRAINTS <-- the last one does NOT have a comma!
    )
    -------------------------------------------
    ---------------- TYPES --------------------
    01- INT           -> 4 bytes integer (from -2,147,483,648 to 2,147,483,647)
    02- SMALLINT      -> 2 bytes integer (from −32,768 to 32,767)
    03- BIGINT        -> 8 bytes integer (from −9,223,372,036,854,775,808 to 9,223,372,036,854,775,807)
    04- DECIMAL(a, b) -> Exact decimal-point number. (a = total digits, b = digits after decimal)
    05- FLOAT         -> Floating point number, faster to compute than DECIMAL at the cost of precision. Not advised for monetary values.
    06- CHAR(n)       -> A length-fixed string. Must be n characters long
    07- VARCHAR(n)    -> A variable-length string. Can be up to n characters
    08- TEXT          -> A string with no predefined limit. Only to be used for very long and variable strings.
    09- BOOLEAN       -> Stores logical truth values (TRUE (1), FALSE (0) or NULL)
    10- SERIAL        -> Auto-incrementing integer (PostgreSQL exclusive).
    11- TIMESTAMP     -> Stores date + time. (Bonus: the now() function returns the current date and time when executed.)
    -------------------------------------------
    ------------- CONSTRAINTS -----------------
    1- NOT NULL                       -> Field cannot be left empty.
    2- UNIQUE                         -> The value cannot repeat in the same column.
    3- DEFAULT value                  -> If left empty, the row will recieve the value stated in default.
    4- PRIMARY KEY                    -> NOT NULL + UNIQUE combo, can only be used once per table.
        4.1- PRIMARY KEY(col1, col2)  -> A composite primary key with two or more parameters.
    5- REFERENCES other_table(column) -> Creates a relationship with another table. The value inserted must exist in the column of the referenced table.
   --------------------------------------------
*/

CREATE TABLE usuario(
id SERIAL PRIMARY KEY,
username VARCHAR(100) NOT NULL,
nome VARCHAR(75) NOT NULL,
data_criacao TIMESTAMP DEFAULT NOW()
);

CREATE TABLE pedido(
id SERIAL PRIMARY KEY,
id_usuario INT REFERENCES usuario(id),
data_pedido TIMESTAMP NOT NULL DEFAULT now(),
status VARCHAR(15) CHECK(status IN ('ENTREGUE', 'CANCELADO', 'EM PROGRESSO', 'ATRASADO'))
);

CREATE TABLE produto(
id SERIAL PRIMARY KEY,
preco DECIMAL(7,2) NOT NULL check(preco>0),
nome VARCHAR(100) UNIQUE NOT NULL,
estoque INT DEFAULT 0 NOT NULL
);

CREATE TABLE item_pedido(
id_pedido INT REFERENCES pedido(id),
id_produto INT REFERENCES produto(id),
quantidade INT DEFAULT 1 NOT NULL CHECK(quantidade>0),
PRIMARY KEY(id_pedido, id_produto) --> This is a composite primary key!
-- This means two different rows cannot have the same id_pedido and id_produto at the same time.
);

CREATE TABLE avaliacao(
id SERIAL PRIMARY KEY,
id_usuario INT REFERENCES usuario(id) NOT NULL,
id_produto INT REFERENCES produto(id) NOT NULL,
nota SMALLINT NOT NULL CHECK(nota between 1 and 5),
comentario TEXT
)