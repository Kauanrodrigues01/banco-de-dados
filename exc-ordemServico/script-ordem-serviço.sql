create database if not exists exc_ordemdeservico
default character set utf8 
default collate utf8_general_ci;

use exc_ordemdeservico;

create table if not exists clientes (
	id_cliente int primary key auto_increment,
    nome varchar(30) not null,
    telefone varchar(14) not null unique
) default charset = utf8;

create table if not exists tecnicos (
	id_tecnico int primary key auto_increment,
    nome varchar(50)
) default charset = utf8;

create table if not exists finalizacao (
	id_final int primary key auto_increment,
    valor_total decimal(7,2) not null,
    data_recebeu date not null,
    data_entrega date not null
) default charset = utf8;

create table if not exists servico (
	id_servico int primary key auto_increment,
    servico varchar(70) not null
) default charset = utf8;

create table if not exists ordem_de_servico (
	id_ordemDeServico int primary key auto_increment,
    data_ordemDeServico date not null,
    defeito varchar(80) not null,
    equipamento varchar(80) not null,
    id_cliente int,
    id_tecnico int,
    id_final int,
    foreign key (id_cliente) references clientes(id_cliente)
    on update cascade
    on delete set null,
    foreign key (id_tecnico) references tecnicos(id_tecnico)
    on update cascade
    on delete set null,
    foreign key (id_final) references finalizacao(id_final)
    on update cascade
    on delete set null
) default charset = utf8;

create table if not exists ordemDeServivo_servico(
	id_ordemDeServico int,
    id_servico int,
    foreign key (id_ordemDeServico) references ordem_de_servico(id_ordemDeServico)
    on update cascade
    on delete set null,
    foreign key (id_servico) references servico(id_servico)
    on update cascade
    on delete set null
) default charset = utf8;

select * from ordem_de_servico;
select c.nome as cliente, 
c.telefone as tel_cliente, 
t.nome as tecnico, 
ods.equipamento as aparelho, 
s.servico, 
ods.defeito, 
f.valor_total, 
f.data_recebeu as recebimento, 
f.data_entrega as entrega
from ordem_de_servico ods
inner join clientes c on c.id_cliente = ods.id_cliente
inner join tecnicos t on t.id_tecnico = ods.id_tecnico
inner join ordemdeservivo_servico ods_s on ods_s.id_ordemDeServico = ods.id_ordemDeServico
inner join servico s on s.id_servico = ods_s.id_servico
inner join finalizacao f on f.id_final = ods.id_final;