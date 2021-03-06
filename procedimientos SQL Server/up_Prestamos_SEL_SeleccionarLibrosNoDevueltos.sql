USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Prestamos_SEL_SeleccionarLibrosNoDevueltos]    Script Date: 09/03/2022 15:32:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 08/02/2022
-- Description: selecciona libros no devueltos
-- =============================================

ALTER PROCEDURE[dbo].[up_Prestamos_SEL_SeleccionarLibrosNoDevueltos]

AS
BEGIN
	
	SET NOCOUNT ON;
	SELECT
	L.isbn,
	L.titulo,
	L.subtitulo,
	P.fechaEntrega
	FROM Libros L
	INNER JOIN Prestamos P
	ON (L.isbn = P.isbn)
	AND (P.fechaDevolucion IS NULL)
	ORDER BY P.fechaDevolucion

END