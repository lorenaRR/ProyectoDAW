USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Usuarios_UPD_ActualizarUser]    Script Date: 09/03/2022 15:36:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 13/02/2022
-- Description: modifica el user
-- =============================================

ALTER PROCEDURE [dbo].[up_Usuarios_UPD_ActualizarUser]

	   @dni				   AS nvarchar(50),
	   @usuario			   AS nvarchar(50),
       @Estado             AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
            UPDATE  Usuarios SET 
			usuario=@usuario
			WHERE 
			@dni=dni
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'Nombre de usuario modificado correctamente'
                    SELECT 1
                    RETURN 1    
       END TRY

       BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION;
				END
                    SET @Estado = 'No se ha podido modificar el nombre de usuario'
                    SELECT 0
                    RETURN 0
       END CATCH    
END