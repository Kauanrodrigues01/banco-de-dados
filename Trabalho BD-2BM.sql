create database trabalho_Kauan_rodrigues 
default character set utf8 
default collate utf8_general_ci;
use trabalho_Kauan_rodrigues;

-- 1.Criação de tabelas e estrutura do banco de dados
create table if not exists tbSala(
	num_sala int primary key auto_increment,
    desc_sala varchar(20) not null,
    capacidade int not null
) default charset = utf8;

create table if not exists tbDiretor(
	codigo_diretor int primary key auto_increment,
    nome_diretor varchar(20) not null
) default charset = utf8;

create table if not exists tbFilme(
	codigo_filme int primary key auto_increment,
    nome_filme varchar(50) not null,
    ano_lançamento int not null,
    categoria_filme varchar(20) not null,
    codigo_diretor int,
    foreign key(codigo_diretor) references tbDiretor(codigo_diretor)
    on update cascade
    on delete set null
) default charset = utf8;

create table if not exists tbPremio(
	codigo_premio int primary key auto_increment,
    nome_premio varchar(20) not null,
    ano_premiação smallint not null,
    codigo_filme int,
    foreign key(codigo_filme) references tbFilme(codigo_filme)
) default charset = utf8;


create table if not exists tbSalaFilme(
	id int primary key auto_increment,
	data_filme date,
    horario time not null,
    num_sala int,
    codigo_filme int,
    foreign key(num_sala) references tbSala(num_sala)
    on update cascade
    on delete set null,
    foreign key(codigo_filme) references tbFilme(codigo_filme)
    on update cascade
    on delete set null
);

-- 2.Inserindo 3 registros para cada tabela
insert into tbsala (num_sala, desc_sala, capacidade) values 
('1', 'sala normal', '120'), ('2', 'sala normal', '180'), 
('3', 'sala normal', '250'), ('4', 'sala normal', '250'), 
('5', 'sala normal', '220'), ('6', 'sala normal', '220'), 
('7', 'sala normal', '190'), ('8', 'sala normal', '150');

insert into tbdiretor (codigo_diretor, nome_diretor) values 
('1', 'Pedro Paulo Matos'), ('2', 'Jorge da penha'), 
('3', 'Christopher Nolan'), ('4', 'Greta Gerwig');
insert into tbdiretor (codigo_diretor, nome_diretor) values 
('5', 'James Cameron');

insert into tbfilme (codigo_filme, nome_filme, ano_lançamento, categoria_filme, codigo_diretor) values 
(null, 'Titanic', '1998', 'Romance', '5'), (null, 'Interstellar', '2014', 'Ficção científica', '3'), 
(null, 'Dunkirk', '2017', 'Ficção científica', '3'), (null, 'Barbie', '2023', 'Comédia ', '4'), 
(null, 'Avatar', '2009', 'Ficção científica', '5'), (null, 'Caminhos do Destino', '2015', 'Drama / Romance', '1'), 
(null, 'O Último Refúgio', '2014', 'Ação ', '2');
insert into tbfilme (codigo_filme, nome_filme, ano_lançamento, categoria_filme, codigo_diretor) values  
(null, 'A Jornada das Sombras', '2018', 'Terror', '1');

insert into tbpremio (codigo_premio, nome_premio, ano_premiação, codigo_filme) values 
(null, 'Melhor Filme', '2016', '6'), (null, 'Melhor Diretor', '2019', '8'), 
(null, 'Melhor Edição', '2015', '7'), (null, 'Melhores Efeitos Visuais', '2015', '2'), 
(null, 'Melhor Edição', '2018', '3'), (null, 'Melhor Mixagem de Som', '2018', '3'), 
(null, 'Melhor Edição de Som', '2018', '3'), (null, 'Melhor Diretor', '1998', '1'), 
(null, 'Melhor Filme', '1998', '1'), (null, 'Melhores Efeitos Visuais', '2012', '5');

insert into tbSalaFilme (data_filme, horario, num_sala, codigo_filme) values 
('2010-11-15', '10:00:00', '12', '8'), ('2010-11-15', '10:00:00', '12', '3'), 
('2010-11-15', '10:00:00', '12', '1'), ('2010-04-20', '10:00:00', '9', '4'), 
('2010-05-14', '10:00:00', '8', '6'), ('2010-05-16', '10:00:00', '5', '5');

-- 3.
select nome_diretor as diretor from tbDiretor;

-- 4.
select nome_filme as filme from tbFilme 
where categoria_filme = 'Terror';

-- 5.
update tbSala set capacidade = '200' where tbSala.num_sala = 8;

-- 6.
update tbSalaFilme set num_sala = 8 
where num_sala = 12 and data_filme = '2010-11-15';

-- 7. 
delete from tbDiretor where tbdiretor.codigo_diretor = 1;

-- 8. 
select f.nome_filme as filme
from tbFilme f
inner join tbDiretor d on f.codigo_diretor = d.codigo_diretor
where nome_diretor = 'Jorge da penha';

-- 9.
select f.nome_filme as filme
from tbFilme f
inner join tbSalaFilme sf on f.codigo_filme = sf.codigo_filme
where sf.data_filme = '2010-04-20';

-- 10. 
select p.nome_premio as premio
from tbPremio p 
inner join tbFilme f on  p.codigo_filme = f.codigo_filme
where f.nome_filme = 'Titanic';

-- 11.
select f.nome_filme as filme 
from tbFilme f 
inner join tbSalaFilme sf on  f.codigo_filme = sf.codigo_filme
inner join tbSala s on sf.num_sala = s.num_sala
where s.capacidade > 200;

-- 12. 
select f.nome_filme as filme, s.num_sala as número_da_sala, sf.horario as horário_de_exibição
from tbFilme f
inner join tbSalaFilme sf on  f.codigo_filme = sf.codigo_filme
inner join tbSala s on sf.num_sala = s.num_sala
where sf.data_filme like '2010-05___';

-- 13.
select f.nome_filme as filme
from tbFilme f
inner join tbPremio p on p.codigo_filme = f.codigo_filme
where p.nome_premio like '_Melhor diretor_' 
and p.ano_premiação > 2006 and p.ano_premiação < 2010;

-- 14. 
select f.nome_filme as filme
from tbFilme f
inner join tbSalaFilme sf on  f.codigo_filme = sf.codigo_filme
where f.categoria_filme like '_Comédia_' and sf.data_filme like '2010-06___';

-- 15. 
select s.desc_sala as descrição_sala, f.categoria_filme, f.nome_filme
from tbFilme f 
inner join tbDiretor d on d.codigo_diretor = f.codigo_diretor
inner join tbSalaFilme sf on  f.codigo_filme = sf.codigo_filme
inner join tbSala s on sf.num_sala = s.num_sala
where d.nome_diretor like '_Severino Juca_';