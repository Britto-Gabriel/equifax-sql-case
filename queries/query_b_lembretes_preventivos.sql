-- Query B: Lembretes Preventivos
-- Objetivo: Identificar clientes que ainda não pagaram para envio de lembretes antes do vencimento

SELECT DISTINCT
    f.CNPJ,
    c.NM_Cliente,
    c.Email_Socio_1,
    c.Email_Socio_2,
    c.Email_Socio_3,
    f.Valor_do_Boleto
FROM DB_Cobranca_Financeiro f
JOIN DB_Contatos_BB c ON f.CNPJ = c.CNPJ
WHERE f.Vencimento_do_Boleto = '2025-05-15'
    AND f.Situacao_Pagamento_Boleto IN ('Em aberto', 'Pendente')
    AND f.Data_de_pagamento_do_Boleto IS NULL;
