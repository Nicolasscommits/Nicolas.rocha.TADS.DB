-----   EXERCICIO A  --------

SELECT PRODUTO,DATA_VENDA,VENDEDOR FROM VENDAS
WHERE VENDEDOR = 'Ana'
ORDER BY DATA_VENDA

-----   EXERCICIO B  ---------

SELECT SUM(VALOR) AS total_eletronicos_vendidos
FROM VENDAS
WHERE CATEGORIA ='Eletrônicos';

-----   EXERCICIO C  ---------

SELECT PRODUTO,VALOR 
FROM VENDAS
WHERE VALOR BETWEEN 200 AND 1000;

-----   EXERCICIO D  ---------

SELECT
    vendedor,
    COUNT(*) AS qtd_vendas,
    SUM(valor) AS total_vendido
FROM VENDAS
GROUP BY vendedor
ORDER BY total_vendido DESC;

