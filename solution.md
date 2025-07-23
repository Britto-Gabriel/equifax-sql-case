Resolução do Case SQL - Equifax

Minha Abordagem
Para resolver os desafios de inadimplência apresentados, estruturei as queries pensando no dia a dia operacional do time: primeiro entendendo nossa performance histórica, depois identificando oportunidades de prevenção, e por fim mapeando onde precisamos agir com mais urgência.

Query A
O que preciso descobrir:
Quantos clientes pagaram os boletos de fevereiro e qual foi nosso percentual de sucesso.
Por que é importante:
Precisamos de uma baseline para entender se estamos melhorando ou piorando na cobrança.
sqlSELECT
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

Query B
O que preciso descobrir:
Clientes com boletos vencendo em 4 dias que ainda não pagaram.
Por que é importante:
É muito mais fácil (e barato) prevenir inadimplência do que correr atrás depois.
sqlSELECT DISTINCT
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

Query C
O que preciso descobrir:
Quais segmentos têm mais inadimplentes e quanto dinheiro está em risco em cada um.
Por que é importante:
Cada segmento tem um perfil diferente. Dados na mão, decisão mais assertiva.
sqlSELECT
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

Considerações Finais
Com essas informações em mãos, o time consegue entender tendências (estamos melhorando?), agir preventivamente (lembretes antes do vencimento) e priorizar esforços (focar nos segmentos com maior risco).
Incluí métricas complementares como "valor total" e "ticket médio" para enriquecer a análise, permitindo uma visão mais completa do impacto financeiro da inadimplência por segmento.
Apesar de ser um case, tentei pensar como seria no dia a dia do time - queries que realmente façam diferença na operação. Espero que a abordagem tenha feito sentido! Qualquer dúvida ou ajuste, me avisa que conversamos. Ansioso para os próximos passos!
