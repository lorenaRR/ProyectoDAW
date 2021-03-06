USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Reservas_SEL_SeleccionarReservasUsuarios]    Script Date: 09/03/2022 15:34:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 13/01/2022
-- Description: devuelve reservas de libros con datos usuario y libro
-- =============================================

ALTER PROCEDURE[dbo].[up_Reservas_SEL_SeleccionarReservasUsuarios]
	@dni	AS varchar(50),
	@isbn	AS varchar (50),
	@titulo AS varchar (50)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT
	R.dni,
	R.isbn,
	R.fecha_reserva,
	U.nombre,
	U.apellidos,
	L.titulo
	FROM  ((Reservas R
	INNER JOIN Usuarios U ON U.dni = R.dni)
	INNER JOIN Libros L ON L.isbn = R.isbn)
	WHERE (R.dni = @dni OR @dni='')
	AND (R.isbn = @isbn OR @isbn='')
	AND (@titulo= '' OR L.titulo LIKE '%' + @titulo + '%')

	ORDER BY R.fecha_reserva
END