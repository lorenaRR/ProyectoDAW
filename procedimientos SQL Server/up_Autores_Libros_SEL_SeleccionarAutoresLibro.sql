USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Autores_Libros_SEL_SeleccionarAutoresLibro]    Script Date: 09/03/2022 15:26:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 13/01/2022
-- Description: devuelve autores-libros
-- =============================================
ALTER PROCEDURE[dbo].[up_Autores_Libros_SEL_SeleccionarAutoresLibro]
	@isbn			AS varchar(50),
	@id_autor		AS varchar(150)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT
	AL.id_autor,
	AL.isbn
	FROM Autores_Libros AL
	WHERE (CAST( AL.id_autor AS varchar (150)) = @id_autor OR @id_autor = '')
	AND (AL.isbn LIKE '%'+@isbn+'%' OR @isbn = '' )
	ORDER BY AL.id_autor

END