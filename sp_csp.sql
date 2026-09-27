USE Uvv
GO

select * from Pagar
select * from Empresa
select * from uf

ALTER PROC Totais_Pagos
(@datainicial Date,
@datafinal Date,
@uf varchar(2),
@valor varchar(100)
) 
AS
SELECT
	Ram_Descricao as Ramo,
	uf.descricao as uf,
	sum(pag_valor) as Total_Pago
FROM
	pagar,
	empresa,
	ramo,
	cidade,
	uf
WHERE
	fkempresa = idempresa
	and fkramo = idramo
	and fkcidade = idcidade
	and fkuf = iduf
	and pag_datapagto is not null
	and pag_datapagto >= @datainicial
	and pag_datapagto <= @datafinal
	and Descricao = isnull(@uf, descricao)
GROUP BY ram_descricao, descricao
HAVING sum(pag_valor) > @valor
RETURN

exec Totais_Pagos '25-01-2019','25-02-2019', '', 356.00

-- Tabela temporaria (como criar?)

select * into ##tab_temp from pagar

select * from ##tab_temp

-- Relatório

select
	emp_razaosocial as Empresa,
	idPagar as ID_Fatura,
	pag_fatura as Fatura,
	pag_descricao as Descricao,
	pag_valor as debito,
	pag_datavencimento as Vencimento,
	pag_datapagto as pagamento,
	case 
		when Pag_datapagto is null and datediff(dd, pag_datavencimento, getdate()) > 0 then datediff(dd, pag_datavencimento, getdate())
		else 0 end as atraso
from pagar,
	empresa
where fkempresa = idempresa
order by atraso

select * from empresa
select * from pagar

-- questão 1

select
	idempresa as ID_Empresa,
	Emp_razaosocial as Nome_Empresa,
	sum(pag_valor) as Total_Recebido,
	count(pag_fatura) as Faturas_Recebidas,
	case
		when sum(pag_valor) >= 10000 then 'Cliente Ouro'
		when sum(pag_valor) >= 5000 then 'Cliente Prata'
		when sum(pag_valor) >= 1000 then 'Cliente Bronze'
		else 'Cliente Eventual'
	end as Classificacao
from empresa join pagar 
on idempresa = fkempresa
group by idempresa, emp_razaosocial

-- questão 2

select idempresa as IdEmpresa,
	Emp_razaosocial as Nome_Empresa,
	case
		when datediff(mm, pag_datavencimento, getdate()) <= 12 then 'ATIVO'
		else 'INATIVO'
	end as StatusCliente
from Empresa
join Pagar on idempresa = fkempresa
order by idempresa, emp_razaosocial

-- questão 3

alter procedure relatorio_cliente
(@datainicial date,
@datafinal date)
as
select emp_razaosocial as Empresa,
	pag_fatura as Fatura,
	pag_valor as Valor,
	pag_datavencimento as Data_Vencimento,
	pag_datapagto as Data_Pagamento,
	datename(weekday, pag_datavencimento) as Dia,
	case
		when pag_Datapagto is null then 'Em aberto'
		else 'Já paga'
	end as Status
from Empresa
join Pagar on idempresa = fkempresa
where pag_datavencimento >= @datainicial
and pag_datavencimento <= @datafinal

exec relatorio_cliente '2025-09-02 00:00:00.000', '2025-11-02 00:00:00.000'

-- questao 4

update empresa
set emp_razaosocial = 'Não informado'
where emp_razaosocial is null and idempresa in (select fkempresa from pagar)
