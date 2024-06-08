create database if not exists exercio_olegario_livro
default character set utf8 
default collate utf8_general_ci;

create table categorias(
	id_categoria tinyint primary key auto_increment,
    nome_categoria varchar(30) not null
) default charset = utf8;

create table autores(
	id_autor tinyint primary key auto_increment,
    nome_autor varchar(30) not null,
    sobrenome_autor varchar(70) not null
) default charset = utf8;

create table editoras(
	id_editora tinyint primary key auto_increment,
    nome_editora varchar(30) not null
) default charset = utf8;

create table livros(
	id_livro tinyint primary key auto_increment,
    nome_livro varchar(70) not null,
    preco decimal(7,2) not null,
    data_pub date not null
) default charset = utf8;
alter table livros add column id_editora tinyint;
alter table livros add constraint fk_id_editora foreign key(id_editora) references editoras(id_editora);

create table livros_categorias(
	id_categoria tinyint,
    id_livro tinyint,
    foreign key(id_categoria) references categorias(id_categoria)
    on update cascade
    on delete set null,
    foreign key(id_livro) references livros(id_livro)
    on update cascade
    on delete set null
) default charset = utf8;

create table livros_autores(
	id_autor tinyint,
    id_livro tinyint,
    foreign key(id_autor) references autores(id_autor)
    on update cascade
    on delete set null,
    foreign key(id_livro) references livros(id_livro)
    on update cascade
    on delete set null
) default charset = utf8;

insert into categorias(nome_categoria) values
('Ficção'), ('Ficção Distópica'), ('Romance Juvenil'), 
('Desenvolvimento Pessoal'), ('Fantasia '), ('Ciências Naturais'),
('Romance Clássico'), ('Estratégia e Liderança'), ('Ficção Política'),
('Ficção Contemporânea'), ('Ficção Clássica'), ('Ficção Científica'),
('Romance Histórico'), ('Mistério e Suspense'), ('Terror'),
('Policial e Crime'), ('Drama'), ('Poesia');
select * from categorias;

insert into autores(nome_autor, sobrenome_autor) values
('Gabriel', 'García Márquez'),
('George', 'Orwell'),
('John', 'Green'),
('Charles', 'Duhigg'),
('J.K.', 'Rowling'),
('Charles', 'Darwin'),
('Machado', 'de Assis'),
('J.R.R.', 'Tolkien'),
('Sun', 'Tzu'),
('Rick', 'Riordan');
select * from autores;

insert into editoras(nome_editora) values
('Editora Record'), ('Companhia das Letras'), ('Intrínseca'),
('Objetiva'), ('Rocco'), ('Editora Globo'),
('Martins Fontes'), ('Editora Martin Claret');
select * from editoras;

insert into livros(nome_livro, preco, data_pub) values
('Cem Anos de Solidão', 50, '1967-05-30'),
('1984','45','1949-06-08'),
('A Culpa é das Estrelas',35,'2012-01-10'),
('O Poder do Hábito', 40, '2012-02-28'),
('Harry Potter e a Pedra Filosofal', 55, '1997-06-26'),
('Harry Potter e a Câmara Secreta', 54.90, '1998-06-02'),
('Harry Potter e o Prisioneiro de Azkaban', 59.90, '1999-07-08'),
('O Ladrão de Raios', 39.90, '2005-06-28'),
('O Mar de Monstros', 42.90, '2006-04-01'),
('A Maldição do Titã', 45.90, '2007-05-02');
select * from livros;

insert into livros_categorias values
(1 ,1), (2 ,2), (3, 3), (4 ,4), (5, 5), (6, 6), (7, 7), 
(5, 8), (9, 9), (5 ,10), (5 ,11), (5, 12), (5, 13), (5, 14);
select * from livros_categorias;

insert into livros_autores values 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (2, 9),
(5, 10), (5,11), (10, 12), (10, 13), (10, 14);
select * from livros_autores;

select 
l.nome_livro, l.preco, l.data_pub, c.nome_categoria, 
a.nome_autor, a.sobrenome_autor, e.nome_editora
from livros l
inner join livros_categorias lv_ctg on l.id_livro = lv_ctg.id_livro
inner join categorias c on lv_ctg.id_categoria = c.id_categoria
inner join livros_autores lv_aut on l.id_livro = lv_aut.id_livro
inner join autores a on lv_aut.id_autor = a.id_autor
inner join editoras e on e.id_editora = l.id_editora
order by l.data_pub;

select e.nome_editora, count(*)
from livros l
inner join editoras e on e.id_editora = l.id_editora
group by e.nome_editora
order by e.nome_editora desc;