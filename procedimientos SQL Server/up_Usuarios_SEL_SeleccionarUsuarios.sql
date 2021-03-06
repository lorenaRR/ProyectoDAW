USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Usuarios_SEL_SeleccionarUsuarios]    Script Date: 09/03/2022 15:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 17/11/2021
-- Description: devuelve los datos del usuario que accede a la aplicación
-- =============================================
ALTER PROCEDURE[dbo].[up_Usuarios_SEL_SeleccionarUsuarios]
	@dni AS varchar(50),
	@admin AS tinyint,
	@nombre AS varchar(50),
	@apellidos AS varchar(50)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT
	U.dni,
	U.nombre,
	U.apellidos,
	U.direccion,
	U.telefono,
	U.email,
	U.usuario,
	U.[admin],
	U.fechaNacimiento
	FROM Usuarios U 
	WHERE (U.dni = @dni OR @dni= '')
	AND (U.[admin] = @admin OR @admin=99)
	AND (U.nombre LIKE '%'+@nombre+'%' OR @nombre= '')
	AND (U.apellidos LIKE '%'+@apellidos+'%' OR @apellidos = '' )
	ORDER BY U.nombre, U.apellidos

END