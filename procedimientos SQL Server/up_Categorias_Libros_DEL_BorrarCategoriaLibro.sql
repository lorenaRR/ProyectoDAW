USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Categorias_Libros_DEL_BorrarCategoriaLibro]    Script Date: 09/03/2022 15:28:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 12/01/2022
-- Description: borra una relación autor-libro
-- =============================================

ALTER PROCEDURE [dbo].[up_Categorias_Libros_DEL_BorrarCategoriaLibro]
       @id_categoria     AS nvarchar(150),
	   @isbn			   AS nvarchar(150),
       @Estado			   AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
            DELETE FROM Categorias_Libros 
			WHERE
			(@id_categoria = (CAST( Categorias_Libros.id_categoria AS varchar (150))))
			AND (@isbn = (CAST( Categorias_Libros.isbn AS varchar (150))))

			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'Relación Categoria-Libro eliminada correctamente'
                    SELECT 1
                    RETURN 1    
       END TRY

       BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION;
				END
                    --SET @Estado = 'No se ha podido eliminar el usario'
					SET @Estado = ERROR_MESSAGE()
                    SELECT 0
                    RETURN 0
       END CATCH    
END