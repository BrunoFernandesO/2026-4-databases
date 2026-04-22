/* I forgot to add NOT NULL to some columns. 
Since the tables were already created I will use ALTER TABLE. */

ALTER TABLE usuario ALTER COLUMN data_criacao SET NOT NULL
ALTER TABLE pedido ALTER COLUMN id_usuario SET NOT NULL