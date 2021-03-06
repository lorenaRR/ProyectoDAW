USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Prestamos_SEL_SeleccionarPrestamosUsuarios]    Script Date: 09/03/2022 15:33:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 05/02/2022
-- Description: selecciona prestamos con datos usuario y libros
-- =============================================

ALTER PROCEDURE[dbo].[up_Prestamos_SEL_SeleccionarPrestamosUsuarios]
	@dni		 AS varchar(50)

AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @fechaHoy AS date
	SET @fechaHoy = GETDATE()

	SELECT
	P.id_prestamo,
	P.isbn,
	P.dni,
	P.fechaPrestamo,
	P.fechaEntrega,
	P.fechaDevolucion,
	CASE
       WHEN @fechaHoy > P.fechaEntrega THEN CAST(1 AS bit)
       ELSE CAST(0 AS bit)
	END AS fechaInvalida,
	U.nombre,
	U.apellidos,
	L.titulo
	FROM  ((Prestamos P
	INNER JOIN Usuarios U ON U.dni = P.dni)
	INNER JOIN Libros L ON L.isbn = P.isbn)
	WHERE (@dni = P.dni OR @dni='')

	ORDER BY P.fechaPrestamo

END