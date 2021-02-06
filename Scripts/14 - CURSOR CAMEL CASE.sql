CREATE PROCEDURE CAMEL_CASE AS
DECLARE C_NOMES CURSOR FOR
SELECT IDPRODUTO, NOME
FROM ST_PRODUTO

DECLARE @IDPRODUTO INT,
		@PALAVRA VARCHAR(50),
	    @STRINGTOTAL VARCHAR(5000),
		@INICIO INT,
		@FIM INT	

OPEN C_NOMES
FETCH NEXT FROM C_NOMES INTO
@IDPRODUTO,@PALAVRA

WHILE @@FETCH_STATUS = 0

BEGIN
	  -- transformando toda a palavra em minuscula
	  SET @PALAVRA = LOWER(@PALAVRA)
	  --pegando a primeira letra da palavra e colocando em maiuscula e tacando na string de saida
	  -- dai começa a partir da segunda letra, pq a primeira já foi
      SET @INICIO = 2
	  --pegando o tamanho total da palavra
      SET @FIM = LEN(@PALAVRA)
	  -- colocando a primeira letra (já maiuscula na saida)
      SET @STRINGTOTAL = UPPER(LEFT(@PALAVRA,1))
	  
	  --iterando a palavra do inicio ao fim letra a letra
	  WHILE @INICIO <= @FIM
		
		BEGIN
				-- se encontrar um espaço em branco
				-- vai pegar a proxima letra por em maiuscula e concatenar na string de saida
				IF SUBSTRING(@PALAVRA,@INICIO,1) = ' '
				BEGIN 
					SELECT @INICIO = @INICIO + 1
					SELECT @STRINGTOTAL = @STRINGTOTAL + ' ' + 
					UPPER(SUBSTRING(@PALAVRA,@INICIO,1))
				END
				ELSE
				BEGIN
					-- se nao for um espaço em branco nao faz nada, pq ja tá tudo em minusculo
					SELECT @STRINGTOTAL = @STRINGTOTAL + 
					SUBSTRING(@PALAVRA,@INICIO,1)
				END
				
				SELECT @INICIO = @INICIO + 1
		END
		-- atualizando o campo com a nova string resultante
		-- importante comprar o id, senão ele atualiza a tabela inteira
		UPDATE ST_PRODUTO SET NOME = @STRINGTOTAL
		WHERE IDPRODUTO = @IDPRODUTO

		FETCH NEXT FROM C_NOMES INTO
		@IDPRODUTO,@PALAVRA

END
CLOSE C_NOMES
DEALLOCATE C_NOMES
GO
