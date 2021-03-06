USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Autores_SEL_SeleccionarAutores]    Script Date: 09/03/2022 15:26:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 03/01/2022
-- Description: devuelve autores de libros
-- =============================================
ALTER PROCEDURE[dbo].[up_Autores_SEL_SeleccionarAutores]
	@id_autor	AS varchar (150),
	@nombre		AS varchar(50),
	@apellidos	AS varchar(50)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT
	Autores.id_autor,
	Autores.nombre,
	Autores.apellidos
	FROM Autores
	WHERE  (CAST( aUTORES.id_autor AS varchar (150)) = @id_autor OR @id_autor = '')
	AND (Autores.nombre LIKE '%'+@nombre+'%' OR @nombre= '')
	AND (Autores.apellidos LIKE '%'+@apellidos+'%' OR @apellidos = '' )
	ORDER BY Autores.apellidos

END