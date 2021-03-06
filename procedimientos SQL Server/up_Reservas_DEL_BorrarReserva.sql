USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Reservas_DEL_BorrarReserva]    Script Date: 09/03/2022 15:33:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: LRR
-- ALTER date: 25/01/2022
-- Description: borra una reserva
-- =============================================

ALTER PROCEDURE [dbo].[up_Reservas_DEL_BorrarReserva]
	   @isbn			AS varchar(50),
	   @dni				AS varchar (50),
       @Estado			AS nvarchar(125) OUTPUT
AS

BEGIN
	BEGIN TRY
		BEGIN TRAN
            DELETE FROM Reservas
			WHERE
			(@isbn = Reservas.isbn)
			AND (@dni = Reservas.dni)
			
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'Reserva eliminada correctamente'
                    SELECT 1
                    RETURN 1    
       END TRY

       BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION;
				END
                    --SET @Estado = 'No se ha podido eliminar la reserva'
					SET @Estado = ERROR_MESSAGE()
                    SELECT 0
                    RETURN 0
       END CATCH    
END