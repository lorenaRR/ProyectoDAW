USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Usuarios_INS_InsertarUsuario]    Script Date: 09/03/2022 15:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 01/12/2021
-- Description: crea un nuevo usuario
-- =============================================

ALTER PROCEDURE [dbo].[up_Usuarios_INS_InsertarUsuario]
       @dni                AS nvarchar(50),
       @nombre             AS nvarchar(50),
       @apellidos          AS nvarchar(50),
       @direccion          AS nvarchar(50),
       @telefono           AS nvarchar(50),
       @email              AS nvarchar(50),
	   @usuario			   AS nvarchar(50),
	   @password		   AS nvarchar(50),
	   @admin			   AS bit,
	   @fechaNacimiento	   AS date,
       @Estado             AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY	
		BEGIN TRAN
			INSERT INTO Usuarios 
			(dni, nombre, apellidos, direccion, telefono, email, usuario, [password], [admin],fechaNacimiento)
			VALUES
			(@dni, @nombre, @apellidos, @direccion, @telefono, @email, @usuario, @password, @admin, @fechaNacimiento)
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
				SET @Estado = 'Usuario creado correctamente'
				SELECT 1
				RETURN 1    
    END TRY

    BEGIN CATCH
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION;
			END
            SET @Estado = 'No se ha podido crear el usario'
            SELECT 0
            RETURN 0
    END CATCH    
END