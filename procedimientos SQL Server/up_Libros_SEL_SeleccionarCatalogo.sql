USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Libros_SEL_SeleccionarCatalogo]    Script Date: 09/03/2022 15:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 01/03/2022
-- Description: devuelve los datos del libro con autores y categorias
-- =============================================
ALTER PROCEDURE[dbo].[up_Libros_SEL_SeleccionarCatalogo]
	@isbn AS varchar(50),
	@titulo AS varchar(50),
	@subtitulo AS varchar(50),
	@editorial AS varchar(50),
	@autor AS varchar(50),
	@categoria AS varchar(50)

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
	ISNULL(L.stock, 0) AS stock,
	ISNULL(A.nombre, '') AS nombre,
	ISNULL(A.apellidos, '') AS apellidos,
	ISNULL(C.categoria, '') AS categoria
	FROM Libros L
	INNER JOIN Categorias_Libros CL ON CL.isbn = L.isbn
	INNER JOIN Categorias C ON CL.id_categoria = C.id_categoria
	INNER JOIN Autores_Libros AL ON AL.isbn = L.isbn
	INNER JOIN Autores A ON AL.id_autor = A.id_autor
	WHERE (L.isbn = @isbn OR @isbn= '')
	AND (@titulo= '' OR L.titulo LIKE '%' + @titulo + '%')
	AND (@subtitulo= '' OR L.subtitulo LIKE '%' + @subtitulo + '%')
	AND (@editorial= '' OR L.editorial LIKE '%' + @editorial + '%')
	AND (@categoria= '' OR C.categoria LIKE '%' + @categoria + '%')
	AND (A.nombre LIKE '%'+@autor+'%' OR A.apellidos LIKE '%'+@autor+'%'  OR @autor= '')
	GROUP BY L.isbn, titulo, subtitulo, fechaPublicacion, editorial, descripcion, nPaginas, imagen,stock, nombre, apellidos, categoria
	ORDER BY L.titulo, A.nombre, A.apellidos, C.categoria

END