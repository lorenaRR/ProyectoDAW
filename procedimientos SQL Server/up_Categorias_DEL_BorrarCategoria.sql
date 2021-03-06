USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Categorias_DEL_BorrarCategoria]    Script Date: 09/03/2022 15:27:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 12/01/2022
-- Description: borra una categoria
-- =============================================

ALTER PROCEDURE [dbo].[up_Categorias_DEL_BorrarCategoria]
       @id_categoria       AS nvarchar(50),
       @Estado             AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF EXISTS(SELECT 1 FROM Categorias_Libros WHERE id_categoria = @id_categoria)
				BEGIN
					SET @Estado = 'La categoría está relacionada con un libro'
					SELECT 0
                    RETURN 0
				END
            DELETE FROM Categorias 
			WHERE
			(@id_categoria = Categorias.id_categoria)
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'Categoria eliminada correctamente'
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