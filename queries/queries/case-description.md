 Descrição do Case - Equifax

## Contexto
Case técnico para posição de Inside Sales Analyst focado em análise de inadimplência e estratégias de cobrança.

## Desafio Proposto

### Query A - Adimplência de Fevereiro
Calcular o número de clientes que pagaram os boletos de fevereiro (vencimento 15/03/2025) e o percentual de adimplência.

### Query B - Lembretes Preventivos  
Identificar clientes que ainda não pagaram no dia 11/05 para envio de lembretes antes do vencimento (15/05/2025).

### Query C - Inadimplência por Segmento
Analisar clientes inadimplentes no dia 16/05 segmentados por Atacado, Varejo e Bancos para ações direcionadas.

## Bases de Dados Disponíveis
- `DB_Cobranca_Financeiro` - Dados financeiros e de cobrança
- `DB_Contatos_BB` - Base de contatos dos clientes

## Critérios
- Respeitar rigorosamente as datas especificadas
- Focar em clientes únicos (CNPJ)
- Considerar diferentes status de pagamento
- Pensar na aplicabilidade operacional das queries
