- Query C: Mapeamento de Inadimplência por Segmento
-- Objetivo: Analisar clientes inadimplentes segmentados por Atacado, Varejo e Bancos

SELECT
    Segmento,
    COUNT(DISTINCT CNPJ) AS clientes_inadimplentes,
    SUM(Valor_do_Boleto) AS valor_total_inadimplente,
    ROUND(AVG(Valor_do_Boleto), 2) AS ticket_medio_inadimplente
FROM DB_Cobranca_Financeiro
WHERE Vencimento_do_Boleto = '2025-05-15'
    AND Situacao_Pagamento_Boleto NOT IN ('Pago', 'Cancelado')
    AND Data_de_pagamento_do_Boleto IS NULL
    AND Segmento IN ('Atacado', 'Varejo', 'Bancos')
GROUP BY Segmento
ORDER BY clientes_inadimplentes DESC;
