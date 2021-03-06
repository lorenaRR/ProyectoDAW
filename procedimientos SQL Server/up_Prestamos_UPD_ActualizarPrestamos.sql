USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Prestamos_UPD_ActualizarPrestamos]    Script Date: 09/03/2022 15:33:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 12/12/2021
-- Description: actualiza un prestamo
-- =============================================

ALTER PROCEDURE [dbo].[up_Prestamos_UPD_ActualizarPrestamos]
       @isbn			 AS nvarchar(50),
       @dni				 AS nvarchar(50),
	   @fechaPrestamo	 AS Date,
	   @fechaEntrega	 AS Date,
	   @fechaDevolucion	 AS Date,
       @Estado			 AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
            UPDATE prestamos SET
			isbn=@isbn,
			dni=@dni,
			fechaPrestamo=@fechaPrestamo,
			fechaEntrega=@fechaEntrega,
			fechaDevolucion=@fechaDevolucion
			WHERE
			isbn = @isbn
			AND dni = @dni
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'Prestamo actualizado correctamente'
                    SELECT 1
                    RETURN 1    
       END TRY

       BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION;
				END
                    SET @Estado = 'No se ha podido actualizar el prestamo'
                    SELECT 0
                    RETURN 0
       END CATCH    
END