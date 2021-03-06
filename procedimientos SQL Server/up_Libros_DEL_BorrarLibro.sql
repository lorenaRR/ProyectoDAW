USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Libros_DEL_BorrarLibro]    Script Date: 14/03/2022 9:01:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 12/01/2022
-- Description: borra un libro
-- =============================================

CREATE PROCEDURE [dbo].[up_Libros_DEL_BorrarLibro2]
       @isbn               AS nvarchar(50),
       @Estado             AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF EXISTS(SELECT 1 FROM Reservas WHERE isbn = @isbn)
				BEGIN
					DELETE FROM Reservas 
					WHERE
				   (@isbn = Reservas.isbn)
				END
			IF EXISTS(SELECT 1 FROM Prestamos WHERE isbn = @isbn)
				BEGIN
					DELETE FROM Prestamos 
					WHERE
				   (@isbn = Prestamos.isbn)
				END
			IF EXISTS(SELECT 1 FROM Autores_Libros WHERE isbn = @isbn)
				BEGIN
					DELETE FROM Autores_Libros 
					WHERE
				   (@isbn = Autores_Libros.isbn)
				END
			IF EXISTS(SELECT 1 FROM Categorias_Libros WHERE isbn = @isbn)
				BEGIN
					DELETE FROM Categorias_Libros
					WHERE
				   (@isbn = Categorias_Libros.isbn)
				END
			DELETE FROM Libros 
			WHERE
			(@isbn = Libros.isbn)
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'Libro eliminado correctamente'
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