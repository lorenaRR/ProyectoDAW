USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Usuarios_UPD_ActualizarUsuario]    Script Date: 09/03/2022 15:36:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 01/12/2021
-- Description: modifica un usuario
-- =============================================

ALTER PROCEDURE [dbo].[up_Usuarios_UPD_ActualizarUsuario]
	   @dni				   AS nvarchar(50),
       @nombre             AS nvarchar(50),
       @apellidos          AS nvarchar(50),
       @direccion          AS nvarchar(50),
       @telefono           AS nvarchar(50),
       @email              AS nvarchar(50),
	   @admin			   AS bit,
	   @fechaNacimiento	   AS Date,
       @Estado             AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
            UPDATE  Usuarios SET
			nombre=@nombre,
			apellidos=@apellidos, 
			direccion=@direccion, 
			telefono=@telefono, 
			email=@email, 
			[admin]=@admin,
			fechaNacimiento=@fechaNacimiento
			WHERE 
			@dni=dni
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'Usuario modificado correctamente'
                    SELECT 1
                    RETURN 1    
       END TRY

       BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION;
				END
                    SET @Estado = 'No se ha podido modificar el usario'
                    SELECT 0
                    RETURN 0
       END CATCH    
END