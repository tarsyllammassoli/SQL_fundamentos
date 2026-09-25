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
