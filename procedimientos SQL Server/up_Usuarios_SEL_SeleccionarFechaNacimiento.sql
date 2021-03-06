USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Usuarios_SEL_SeleccionarFechaNacimiento]    Script Date: 09/03/2022 15:35:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 08/02/2022
-- Description: devuelve los usuarios nacidos entre dos fechas
-- =============================================
ALTER PROCEDURE[dbo].[up_Usuarios_SEL_SeleccionarFechaNacimiento]
	@fecha1 AS date,
	@fecha2 AS date

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
	WHERE U.fechaNacimiento BETWEEN @fecha1 AND @fecha2
	ORDER BY U.fechaNacimiento

END