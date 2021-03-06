USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Categorias_SEL_SeleccionarNumLibrosPorCategorias]    Script Date: 09/03/2022 15:29:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 10/02/2022
-- Description: devuelve el numero de libros en cada categoria
-- =============================================
ALTER PROCEDURE[dbo].[up_Categorias_SEL_SeleccionarNumLibrosPorCategorias]
AS
BEGIN

	SET NOCOUNT ON;

	SELECT C.categoria, COUNT(1) AS Total 
	FROM Categorias_Libros CL
	INNER JOIN Categorias C ON CL.id_categoria = C.id_categoria
	GROUP BY categoria
	ORDER BY Total DESC

END