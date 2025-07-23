- Query A: Análise de Adimplência de Fevereiro
-- Objetivo: Calcular quantos clientes pagaram os boletos de fevereiro e o percentual de adimplência

SELECT
    COUNT(DISTINCT CNPJ) AS clientes_totais_fev,
    COUNT(DISTINCT CASE
        WHEN Situacao_Pagamento_Boleto = 'Pago'
        THEN CNPJ
    END) AS clientes_adimplentes_fev,
    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN Situacao_Pagamento_Boleto = 'Pago'
            THEN CNPJ
        END) / COUNT(DISTINCT CNPJ), 2
    ) AS percentual_adimplentes
FROM DB_Cobranca_Financeiro
WHERE Vencimento_do_Boleto = '2025-03-15';
