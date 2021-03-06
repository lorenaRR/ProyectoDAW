USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Autores_Libros_INS_InsertarAutorLibro]    Script Date: 09/03/2022 15:25:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 19/12/2021
-- Description: crea un nuevo autor_libro
-- =============================================

ALTER PROCEDURE [dbo].[up_Autores_Libros_INS_InsertarAutorLibro]
       @id_autor		 AS uniqueidentifier,
       @isbn			 AS nvarchar(50),
       @Estado			 AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
            INSERT INTO Autores_Libros 
			(id_autor,isbn)
			VALUES
			(@id_autor,@isbn)
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'La relación Autores-Libros se ha creado correctamente'
                    SELECT 1
                    RETURN 1    
       END TRY

       BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION;
				END
                    SET @Estado = 'No se ha podido crear relación Autores-Libros'
                    SELECT 0
                    RETURN 0
       END CATCH    
END