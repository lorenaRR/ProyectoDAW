USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Autores_DEL_BorrarAutor]    Script Date: 09/03/2022 15:20:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 12/01/2022
-- Description: borra un autor
-- =============================================

ALTER PROCEDURE [dbo].[up_Autores_DEL_BorrarAutor]
       @id_autor           AS nvarchar(50),
       @Estado             AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF EXISTS(SELECT 1 FROM Autores_Libros WHERE id_autor = @id_autor)
				BEGIN
					SET @Estado = 'El autor tiene libros'
					SELECT 0
                    RETURN 0
				END

            DELETE FROM Autores 
			WHERE
			(@id_autor = Autores.id_autor)

			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END

            SET @Estado = 'Autor eliminado correctamente'
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