USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Libros_SEL_SeleccionarNumLectores]    Script Date: 09/03/2022 15:31:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 17/02/2022
-- Description: devuelve el numero de lectores por libro
-- =============================================
ALTER PROCEDURE[dbo].[up_Libros_SEL_SeleccionarNumLectores]
AS
BEGIN

	SET NOCOUNT ON;

	SELECT L.titulo, COUNT(1) AS Total 
	FROM Prestamos P
	INNER JOIN Libros L ON P.isbn = L.isbn
	GROUP BY titulo
	ORDER BY Total DESC

END