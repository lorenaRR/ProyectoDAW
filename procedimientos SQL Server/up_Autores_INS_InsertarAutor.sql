USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Autores_INS_InsertarAutor]    Script Date: 09/03/2022 15:24:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 19/12/2021
-- Description: crea un nuevo autor
-- =============================================

ALTER PROCEDURE [dbo].[up_Autores_INS_InsertarAutor]
       @nombre			 AS nvarchar(50),
       @apellidos		 AS nvarchar(50),
       @Estado			 AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
            INSERT INTO Autores 
			(nombre,apellidos)
			VALUES
			(@nombre,@apellidos)
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'Autor creado correctamente'
                    SELECT 1
                    RETURN 1    
       END TRY

       BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION;
				END
                    SET @Estado = 'No se ha podido crear el autor'
                    SELECT 0
                    RETURN 0
       END CATCH    
END