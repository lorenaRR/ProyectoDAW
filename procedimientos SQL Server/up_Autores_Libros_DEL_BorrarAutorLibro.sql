USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Autores_Libros_DEL_BorrarAutorLibro]    Script Date: 09/03/2022 15:24:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 12/01/2022
-- Description: borra una relación autor-libro
-- =============================================

ALTER PROCEDURE [dbo].[up_Autores_Libros_DEL_BorrarAutorLibro]
       @id_autor       AS varchar(150),
	   @isbn		   AS varchar(150),
       @Estado		   AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
            DELETE FROM Autores_Libros 
			WHERE
			(@id_autor = (CAST( Autores_Libros.id_autor AS varchar (150))))
			AND (@isbn = Autores_Libros.isbn)
			
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'Relación Autor-Libro eliminada correctamente'
                    SELECT 1
                    RETURN 1    
       END TRY

       BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION;
				END
                    --SET @Estado = 'No se ha podido eliminar la relacion Autor-Libro'
					SET @Estado = ERROR_MESSAGE()
                    SELECT 0
                    RETURN 0
       END CATCH    
END