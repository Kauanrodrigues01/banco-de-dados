
create table editoras(
	id_categoria smallint primary key,
    categoria varchar (30)
);

create table editoras (
	id_editoras smallint primary key,
    nome_editoras varchar(50) not null
);

 create table autores(
	id_autor smallint primary key,
	nome_autor varchar (30) not null,
	sobrenome_autor varchar (60) not null
    );

create table livro(
	id_livro smallint primary key,
    nome_livro varchar(70) not null,
	id_categoria smallint,
    id_autor smallint ,
    data_pub date not null default '2024-05-03',
    preco_livro decimal (6,2) not null default 50,
    id_editora smallint,
    isbn13 char(13) not null default " ",
    isbn10 char(10) not null default " ",
    foreign key(id_categoria) references categorias(id_categoria) 
    on delete set null on update cascade,
    foreign key(id_autor) references autores(id_autor)
    on delete set null on update cascade,
    foreign key(id_editora) references editoras(id_editoras)
    on delete set null on update cascade
);

insert into livro(id_livro, nome_livro, id_categoria, id_autor, id_editora) values
(1 ,'Menino que inventou o vento', 4, 1, 1),
(2 ,'Plantas verdes', 3, 4, 2),
(3 ,'Pedra filosofal', 4, 2, 1),
(4 ,'Camara secreta', 4, 2, 2),
(5 ,'Prisioneiro de Azkaban', 4, 2, 3),
(6 ,'Titanic', 1, 3, 3),
(7 ,'Inventado', 5, 3, 3);

insert into categorias values 
(1, 'Romance'), (2, 'Terror'), (3, 'Suspense'), (4, 'Ficção'), (5, 'Comédia');

insert into editoras values
(1, 'ROCCO'), (2, 'ROCAMBOLE'), (3, 'AKAMARU');

insert into autores values
(1 ,'José de', 'Alencar'), (2, 'JK', 'Howling'), (3, 'Amanda', 'LoveLance'), (4, 'Roberto', 'Carlos');

select * from livro;

select l.id_livro, l.preco_livro, l.nome_livro, a.nome_autor, a.sobrenome_autor, e.nome_editoras, c.categoria 
from livro l 
inner join autores a on a.id_autor = l.id_autor
inner join editoras e on e.id_editoras = l.id_editora
inner join categorias c on c.id_categoria = l.id_categoria;

