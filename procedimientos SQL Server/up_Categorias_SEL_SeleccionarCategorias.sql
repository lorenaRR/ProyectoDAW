USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Categorias_SEL_SeleccionarCategorias]    Script Date: 09/03/2022 15:28:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 28/12/2021
-- Description: devuelve todas las categorias de libros
-- =============================================
ALTER PROCEDURE[dbo].[up_Categorias_SEL_SeleccionarCategorias]
	@id_categoria		AS varchar(150),
	@categoria			AS varchar(50)
AS
BEGIN

	SET NOCOUNT ON;

	
	SELECT
	C.id_categoria,
	C.categoria
	FROM Categorias C
	WHERE (CAST( C.id_categoria AS varchar (150)) = @id_categoria OR @id_categoria = '')
	AND (C.categoria LIKE '%'+@categoria+'%' OR @categoria = '' )
	ORDER BY C.categoria

END