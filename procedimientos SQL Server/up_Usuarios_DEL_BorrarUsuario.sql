USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Usuarios_DEL_BorrarUsuario]    Script Date: 09/03/2022 15:34:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 09/12/2021
-- Description: borra un usuario
-- =============================================

ALTER PROCEDURE [dbo].[up_Usuarios_DEL_BorrarUsuario]
       @dni                AS nvarchar(50),
       @Estado             AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF EXISTS(SELECT 1 FROM Reservas WHERE dni = @dni)
				BEGIN
					SET @Estado = 'El usuario tiene reservas'
					SELECT 0
                    RETURN 0
				END
			IF EXISTS(SELECT 1 FROM Prestamos WHERE dni = @dni)
				BEGIN
					SET @Estado = 'El usuario tiene prestamos'
					SELECT 0
                    RETURN 0
				END
            DELETE FROM Usuarios 
			WHERE
			(@dni = Usuarios.dni)
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'Usuario eliminado correctamente'
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