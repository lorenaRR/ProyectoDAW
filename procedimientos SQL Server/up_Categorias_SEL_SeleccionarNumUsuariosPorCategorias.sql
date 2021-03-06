USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Categorias_SEL_SeleccionarNumUsuariosPorCategorias]    Script Date: 09/03/2022 15:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 10/02/2022
-- Description: devuelve el numero de usuarios por categoria
-- =============================================
ALTER PROCEDURE[dbo].[up_Categorias_SEL_SeleccionarNumUsuariosPorCategorias]
AS
BEGIN

	SET NOCOUNT ON;

	SELECT C.categoria, COUNT(1) AS Total 
	FROM Prestamos P
	INNER JOIN Categorias_Libros CL ON CL.isbn = P.isbn
	INNER JOIN Categorias C ON CL.id_categoria = C.id_categoria
	GROUP BY categoria
	ORDER BY Total DESC

END