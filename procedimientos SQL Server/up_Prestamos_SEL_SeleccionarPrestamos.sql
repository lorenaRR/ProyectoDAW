USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Prestamos_SEL_SeleccionarPrestamos]    Script Date: 09/03/2022 15:32:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 23/01/2022
-- Description: crea un nuevo prestamo
-- =============================================

ALTER PROCEDURE[dbo].[up_Prestamos_SEL_SeleccionarPrestamos]
	@isbn		 AS varchar(50),
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
	END AS fechaInvalida
	FROM Prestamos P
	WHERE (P.dni = @dni OR @dni='')
	AND (P.isbn = @isbn OR @isbn = '')
	ORDER BY P.fechaPrestamo

END