---------------------- ATIVIDADE SOBRE TIGGERS E PROCEDURES :-----------------------   

------------------------------------------------------------------ EXERCICIO 1 --------------------------------------------------------------------------

--------------- CRIACAO DA TABELA DE GATILHOS, "FUNCIONA COMO UMA TABELA ASSOCIATIVA MAS ELA PREENCHE SOZINHA AO ALTERAR ALGO NA TABELA VENDAS"----------

CREATE OR REPLACE TRIGGER gatilho_log_vendas
AFTER INSERT ON VENDAS
FOR EACH ROW
BEGIN
    INSERT INTO LOG_VENDAS (
        operacao,
        id_venda,
        produto,
        vendedor,
        valor,
        usuario,
        data_hora,
        observacao
    ) VALUES (
        'INSERT',
        :NEW.id,
        :NEW.produto,
        :NEW.vendedor,
        :NEW.valor,
        USER,
        SYSDATE,
        'Nova venda inserida: ' || :NEW.produto || ' vendido por ' || :NEW.vendedor
    );
END;
/


-----------------SELECT PARA ACIONAR TIGGER ------------------------

INSERT INTO VENDAS (PRODUTO, CATEGORIA, VALOR, DATA_VENDA, VENDEDOR,ID_CLIENTE)
VALUES('Mochila Dell elite', 'Acessorios', '680', SYSDATE, 'Nicolas', 1);


SELECT * from LOG_VENDAS




------------------------------------------------------------------   EXERCICIO 2 -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE total_vendas_vendedor (
    nome_vendedor IN VARCHAR2,
    total_vendas OUT NUMBER
)
IS
BEGIN
    -- Inicializa o total
    total_vendas := 0;

    -- Soma todas as vendas do vendedor informado
    SELECT NVL(SUM(VALOR), 0)
    INTO total_vendas
    FROM vendas
    WHERE vendedor = nome_vendedor;

    -- Exibe o resultado no console (opcional)
    DBMS_OUTPUT.PUT_LINE('Total de vendas do vendedor ' || nome_vendedor || ': ' || total_vendas);
END total_vendas_vendedor;
/




DECLARE
    v_total NUMBER;
BEGIN
    total_vendas_vendedor('Carlos', v_total);
    DBMS_OUTPUT.PUT_LINE('Total retornado: ' || v_total);
END;
/


--------------- A PROCEDURE FOI CRIADA ONDE ELA IRA ME TRAZER O TOTAL DE VENDAS DO VENDEDOR AO CHAMALA, RETIRANDO ESSES DADOS DOS INSERTs FEITOS NA TABELA VENDAS, FAZENDO A SOMA E ME TRAZENDO OS
--------------- RESULTADOS REFERENTES A PESQUISA REALIZADA.







----------------------------------------------------------- EXERCICIO 3 -----------------------------------------

CREATE OR REPLACE TRIGGER trg_validar_valor_venda
BEFORE INSERT ON VENDAS
FOR EACH ROW
BEGIN
    IF :NEW.valor <= 0 THEN
        RAISE_APPLICATION_ERROR(-20007, 'ERRO: O valor da venda deve ser maior que zero. Inserção não permitida.'
        );
    END IF;
END;
/
