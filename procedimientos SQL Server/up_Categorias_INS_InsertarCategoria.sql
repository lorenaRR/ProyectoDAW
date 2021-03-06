USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Categorias_INS_InsertarCategoria]    Script Date: 09/03/2022 15:27:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 11/01/2022
-- Description: crea una nueva categoria
-- =============================================

ALTER PROCEDURE [dbo].[up_Categorias_INS_InsertarCategoria]
       @categoria		 AS nvarchar(50),
       @Estado			 AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
            INSERT INTO Categorias 
			(categoria)
			VALUES
			(@categoria)
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'Categoría creada correctamente'
                    SELECT 1
                    RETURN 1    
       END TRY

       BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION;
				END
                    SET @Estado = 'No se ha podido crear la categoria'
                    SELECT 0
                    RETURN 0
       END CATCH    
END