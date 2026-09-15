
-- ======================================================
-- 2. ALTER TABLE - CONSTRAINTS
-- ======================================================
ALTER TABLE PRODUTO ADD CONSTRAINT produto_pk PRIMARY KEY (idproduto);
ALTER TABLE PRODUTO ADD CONSTRAINT produto_preco_unitario_ck CHECK (preco_unitario > 0);
ALTER TABLE PRODUTO ADD CONSTRAINT produto_estoque_ck CHECK (estoque >=0);
ALTER TABLE PRODUTO ADD CONSTRAINT categoria_produto_fk FOREIGN KEY (categoria_id) REFERENCES CATEGORIA(idcategoria);

ALTER TABLE CLIENTE ADD CONSTRAINT cliente_pk PRIMARY KEY (idcliente);
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_cpf_uq UNIQUE (cpf);
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_email_uq UNIQUE (email);
ALTER TABLE CLIENTE ADD status varchar(10) DEFAULT 'Ativo';
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_status_ck CHECK (status IN ('Ativo','Inativo'));

ALTER TABLE PEDIDO ADD CONSTRAINT cliente_pedido_fk FOREIGN KEY (cliente_id) REFERENCES CLIENTE(idcliente);
ALTER TABLE PEDIDO ADD CONSTRAINT vendedor_pedido_fk FOREIGN KEY (vendedor_id) REFERENCES VENDEDOR(idvendedor);

ALTER TABLE ITEMPEDIDO ADD CONSTRAINT pedido_produto_pk PRIMARY KEY (pedido_id, produto_id);
ALTER TABLE ITEMPEDIDO ADD CONSTRAINT pedido_itempedido_fk FOREIGN KEY (pedido_id) REFERENCES PEDIDO(idpedido);
ALTER TABLE ITEMPEDIDO ADD CONSTRAINT produto_itempedido_fk FOREIGN KEY (produto_id) REFERENCES PRODUTO(idproduto);
ALTER TABLE ITEMPEDIDO ADD CONSTRAINT itempedido_quantidade_ck CHECK (quantidade > 0);
ALTER TABLE ITEMPEDIDO ADD CONSTRAINT itempedido_preco_unitario_ck CHECK (preco_unitario > 0);