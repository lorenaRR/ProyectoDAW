USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Libros_SEL_SeleccionarLibros]    Script Date: 09/03/2022 15:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 17/11/2021
-- Description: devuelve los datos del usuario que accede a la aplicación
-- =============================================
ALTER PROCEDURE[dbo].[up_Libros_SEL_SeleccionarLibros]
	@isbn AS varchar(50),
	@titulo AS varchar(50),
	@subtitulo AS varchar(50),
	@editorial AS varchar(50)

AS
BEGIN

	SET NOCOUNT ON;

	SELECT
	L.isbn,
	ISNULL(L.titulo, '') AS titulo,
	ISNULL(L.subtitulo, '') AS subtitulo,
	ISNULL(L.fechaPublicacion, '01/01/1900') AS fechaPublicacion,
	ISNULL(L.editorial, '') AS editorial,
	ISNULL(L.descripcion, '') AS descripcion,
	ISNULL(L.nPaginas, 0) AS nPaginas,
	ISNULL(L.imagen, '') AS imagen,
	ISNULL(L.stock, 0) AS stock
	FROM Libros L
	WHERE (L.isbn = @isbn OR @isbn= '')
	AND (@titulo= '' OR L.titulo LIKE '%' + @titulo + '%')
	AND (@subtitulo= '' OR L.subtitulo LIKE '%' + @subtitulo + '%')
	AND (@editorial= '' OR L.editorial LIKE '%' + @editorial + '%')
	ORDER BY L.titulo

END