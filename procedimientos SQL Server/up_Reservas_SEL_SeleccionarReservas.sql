USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Reservas_SEL_SeleccionarReservas]    Script Date: 09/03/2022 15:34:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 13/01/2022
-- Description: devuelve reservas de libros
-- =============================================

ALTER PROCEDURE[dbo].[up_Reservas_SEL_SeleccionarReservas]
	@dni	AS varchar(50),
	@isbn	AS varchar (50)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT
	R.dni,
	R.isbn,
	R.fecha_reserva
	FROM Reservas R

	WHERE (R.dni = @dni OR @dni='')
	AND (R.isbn = @isbn OR @isbn='')
	ORDER BY R.fecha_reserva

END