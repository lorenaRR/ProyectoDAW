USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Autores_SEL_SeleccionarAutoresUnCampo]    Script Date: 09/03/2022 15:27:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 31/01/2022
-- Description: devuelve autores de libros
-- =============================================
ALTER PROCEDURE[dbo].[up_Autores_SEL_SeleccionarAutoresUnCampo]
	@autor	AS varchar (150)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT
	Autores.id_autor,
	Autores.nombre,
	Autores.apellidos
	FROM Autores
	WHERE (Autores.nombre LIKE '%'+@autor+'%' OR Autores.apellidos LIKE '%'+@autor+'%'  OR @autor= '')
	ORDER BY Autores.apellidos

END