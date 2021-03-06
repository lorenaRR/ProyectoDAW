USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Categorias_Libros_SEL_SeleccionarCategoriaLibro]    Script Date: 09/03/2022 15:28:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 15/01/2022
-- Description: selecciona una categoria_libro
-- =============================================

ALTER PROCEDURE[dbo].[up_Categorias_Libros_SEL_SeleccionarCategoriaLibro]
	@isbn			AS varchar(50),
	@id_categoria	AS varchar(150)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT
	C.id_categoria,
	C.categoria
	FROM Categorias C
	INNER JOIN Categorias_Libros CL 
	ON (C.id_categoria = CL.id_categoria)
	WHERE (CL.isbn = @isbn OR @isbn = '')
	AND (CAST( CL.id_categoria AS varchar (150)) = @id_categoria OR @id_categoria = '')
	ORDER BY C.categoria
END