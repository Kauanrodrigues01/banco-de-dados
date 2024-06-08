-- Selecionando apenas os registros com as chaves estrangeiras batem
select c.nome as cliente, c.telefone as tel_cliente, t.nome as tecnico, ods.equipamento as aparelho, 
s.servico, ods.defeito, f.valor_total, f.data_recebeu as recebimento, f.data_entrega as entrega
from ordem_de_servico ods
inner join clientes c on c.id_cliente = ods.id_cliente
inner join tecnicos t on t.id_tecnico = ods.id_tecnico
inner join ordemdeservivo_servico ods_s on ods_s.id_ordemDeServico = ods.id_ordemDeServico
inner join servico s on s.id_servico = ods_s.id_servico
inner join finalizacao f on f.id_final = ods.id_final;

-- Selecionando as informações onde a chave estrangeira bate
select c.nome as cliente, c.telefone as tel_cliente, t.nome as tecnico, ods.equipamento as aparelho, 
s.servico, ods.defeito, f.valor_total, f.data_recebeu as recebimento, f.data_entrega as entrega
from ordem_de_servico ods
inner join clientes c on c.id_cliente = ods.id_cliente
inner join tecnicos t on t.id_tecnico = ods.id_tecnico
inner join ordemdeservivo_servico ods_s on ods_s.id_ordemDeServico = ods.id_ordemDeServico
inner join servico s on s.id_servico = ods_s.id_servico
inner join finalizacao f on f.id_final = ods.id_final
-- Continuando no mesmo select
-- Selecionando apenas onde o valor total for igual o maximo valor da tabela finalização
where f.valor_total = (select max(f.valor_total) 
from ordem_de_servico ods
inner join clientes c on c.id_cliente = ods.id_cliente
inner join tecnicos t on t.id_tecnico = ods.id_tecnico
inner join ordemdeservivo_servico ods_s on ods_s.id_ordemDeServico = ods.id_ordemDeServico
inner join servico s on s.id_servico = ods_s.id_servico
inner join finalizacao f on f.id_final = ods.id_final);

-- Selecionando quantos serviços cada tecnico fez
select t.nome as tecnico, count(*) as qnt_serviços
from ordem_de_servico ods
inner join clientes c on c.id_cliente = ods.id_cliente
inner join tecnicos t on t.id_tecnico = ods.id_tecnico
inner join ordemdeservivo_servico ods_s on ods_s.id_ordemDeServico = ods.id_ordemDeServico
inner join servico s on s.id_servico = ods_s.id_servico
inner join finalizacao f on f.id_final = ods.id_final
group by t.nome;

-- Selecionando a soma do valor de todas as ordens de serviço
select sum(f.valor_total)
from ordem_de_servico ods
inner join clientes c on c.id_cliente = ods.id_cliente
inner join tecnicos t on t.id_tecnico = ods.id_tecnico
inner join ordemdeservivo_servico ods_s on ods_s.id_ordemDeServico = ods.id_ordemDeServico
inner join servico s on s.id_servico = ods_s.id_servico
inner join finalizacao f on f.id_final = ods.id_final;

-- selecionando quantas vezes determinado tipo de equipamento foi concertado
select ods.equipamento, count(*)
from ordem_de_servico ods
inner join clientes c on c.id_cliente = ods.id_cliente
inner join tecnicos t on t.id_tecnico = ods.id_tecnico
inner join ordemdeservivo_servico ods_s on ods_s.id_ordemDeServico = ods.id_ordemDeServico
inner join servico s on s.id_servico = ods_s.id_servico
inner join finalizacao f on f.id_final = ods.id_final
group by ods.equipamento;

-- selecionando quantas vezes determinado tipo de equipamento foi concertado e o concerto deu acima de R$100
select ods.equipamento, count(*)
from ordem_de_servico ods
inner join clientes c on c.id_cliente = ods.id_cliente
inner join tecnicos t on t.id_tecnico = ods.id_tecnico
inner join ordemdeservivo_servico ods_s on ods_s.id_ordemDeServico = ods.id_ordemDeServico
inner join servico s on s.id_servico = ods_s.id_servico
inner join finalizacao f on f.id_final = ods.id_final
where f.valor_total > 100
group by ods.equipamento;