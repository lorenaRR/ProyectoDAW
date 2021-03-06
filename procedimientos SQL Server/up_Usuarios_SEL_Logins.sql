USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Usuarios_SEL_Logins]    Script Date: 09/03/2022 15:35:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 31/12/2021
-- Description: devuelve los datos del usuario que accede a la aplicación
-- =============================================
ALTER PROCEDURE[dbo].[up_Usuarios_SEL_Logins]
	@user	 AS varchar(50),
	@pass	 AS varchar(50)

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
	U.[password]
	FROM Usuarios U 
	WHERE (U.usuario = @user)
	AND (U.[password] = @pass)  

END