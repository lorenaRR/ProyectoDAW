USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Libros_INS_InsertarLibro]    Script Date: 09/03/2022 15:30:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 12/12/2021
-- Description: crea un nuevo libro
-- =============================================

ALTER PROCEDURE [dbo].[up_Libros_INS_InsertarLibro]
       @isbn                AS nvarchar(50),
       @titulo				AS nvarchar(50),
       @subtitulo			AS nvarchar(50),
       @fechaPublicacion    AS date,
       @descripcion         AS text,
	   @nPaginas			AS int,
       @imagen              AS nvarchar(250),
	   @editorial			AS nvarchar(50),
	   @stock				AS int,
       @Estado				AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
            INSERT INTO Libros 
			(isbn,titulo,subtitulo,fechaPublicacion,descripcion,nPaginas,imagen,editorial,stock)
			VALUES
			(@isbn,@titulo,@subtitulo,@fechaPublicacion,@descripcion,@nPaginas,@imagen,@editorial,@stock)
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'Libro creado correctamente'
                    SELECT 1
                    RETURN 1    
       END TRY

       BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION;
				END
                    SET @Estado = 'No se ha podido crear el libro'
                    SELECT 0
                    RETURN 0
       END CATCH    
END