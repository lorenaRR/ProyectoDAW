USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Categorias_Libros_INS_InsertarCategoriaLibro]    Script Date: 09/03/2022 15:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 03/01/2022
-- Description: crea un nuevo categoria_libro
-- =============================================

ALTER PROCEDURE [dbo].[up_Categorias_Libros_INS_InsertarCategoriaLibro]
       @id_categoria	 AS uniqueidentifier,
       @isbn			 AS nvarchar(50),
       @Estado			 AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
            INSERT INTO Categorias_Libros
			(id_categoria,isbn)
			VALUES
			(@id_categoria,@isbn)
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'La relación Categorías-Libros se ha creado correctamente'
                    SELECT 1
                    RETURN 1    
       END TRY

       BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION;
				END
                    SET @Estado = 'No se ha podido crear relación Categorías-Libros'
                    SELECT 0
                    RETURN 0
       END CATCH    
END