create database exc_cliente_livro 
default character set utf8 
default collate utf8_general_ci;

use exc_cliente_livro;

create table if not exists cliente (
	id_cliente tinyint primary key auto_increment,
    cpf varchar(15) not null unique,
    rg int not null unique,
    nome varchar(70) not null,
    email varchar(40) not null,
    telefone varchar(15) not null
) default charset = utf8;

create table if not exists pedido (
	id_pedido tinyint primary key auto_increment,
    data_ date not null,
    valor_pedido int not null,
    id_cliente tinyint,
    foreign key(id_cliente) references cliente(id_cliente)
) default charset = utf8;

create table if not exists Livro (
	
) default charset = utf8;

create table if not exists cliente () default charset = utf8;

create table if not exists cliente () default charset = utf8;

create table if not exists cliente () default charset = utf8;