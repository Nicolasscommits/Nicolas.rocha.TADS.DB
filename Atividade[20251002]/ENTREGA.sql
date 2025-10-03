--Liste todos os produtos mais caros do que o produto mais barato da categoria "Eletrônicos".

SELECT produto, valor
FROM VENDAS
WHERE valor > (
    SELECT MIN(valor)
    FROM VENDAS
    WHERE categoria = 'Eletrônicos'
);

--Mostre o vendedor que realizou a maior venda registrada na tabela.

SELECT VENDEDOR, PRODUTO,VALOR
FROM VENDAS
WHERE VALOR = (SELECT MAX(VALOR) FROM VENDAS);

--Liste as categorias que têm pelo menos um produto acima do preço médio geral.

SELECT CATEGORIA,PRODUTO,VALOR
FROM VENDAS
WHERE VALOR>(
    SELECT AVG(VALOR) FROM VENDAS
);

--Monte um ranking dos 3 produtos mais caros vendidos por cada vendedor.
SELECT *
FROM (
    SELECT
        vendedor,
        produto,
        valor,
        ROW_NUMBER() OVER (PARTITION BY vendedor ORDER BY valor DESC) AS ranking
    FROM VENDAS
) t
WHERE ranking <= 3; 