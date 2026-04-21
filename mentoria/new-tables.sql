create table usuario(
id SERIAL primary key,
username VARCHAR(100) not null,
nome VARCHAR(75) not null,
data_criacao TIMESTAMP default NOW()
)

create table pedido(
id SERIAL primary key,
id_usuario INT references usuario(id),
data_pedido TIMESTAMP not null default now(),
status VARCHAR(15) CHECK(status in ('ENTREGUE', 'CANCELADO', 'EM PROGRESSO', 'ATRASADO'))
)

create table produto(
id SERIAL primary key,
preco DECIMAL(7,2) not null check(preco>0),
nome VARCHAR(100) unique not null,
estoque INT default 0 not NULL
)

create table item_pedido(
id_pedido INT references pedido(id),
id_produto INT references produto(id),
quantidade INT default 1 not null CHECK(quantidade>0),
primary KEY(id_pedido, id_produto)
)

create table avaliacao(
id SERIAL primary key,
id_usuario INT references usuario(id) not null,
id_produto INT REFERENCES produto(id) not null,
nota SMALLINT not null CHECK(nota between 1 and 5),
comentario TEXT
)