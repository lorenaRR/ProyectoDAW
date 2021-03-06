USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Prestamos_INS_InsertarPrestamo]    Script Date: 09/03/2022 15:32:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 12/01/2022
-- Description: crea un nuevo prestamo
-- =============================================

ALTER PROCEDURE [dbo].[up_Prestamos_INS_InsertarPrestamo]
       @isbn			 AS nvarchar(50),
       @dni				 AS nvarchar(50),
	   @fechaPrestamo	 AS Date,
	   @fechaEntrega	 AS Date,
       @Estado			 AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
            INSERT INTO Prestamos 
			(isbn, dni, fechaPrestamo, fechaEntrega)
			VALUES
			(@isbn, @dni, @fechaPrestamo, @fechaEntrega)
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'El prestamo se ha realizado correctamente'
                    SELECT 1
                    RETURN 1    
       END TRY

       BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION;
				END
                    SET @Estado = 'No se ha podido realziar el prestamo'
                    SELECT 0
                    RETURN 0
       END CATCH    
END