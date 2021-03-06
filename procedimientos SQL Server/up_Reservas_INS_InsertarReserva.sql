USE [Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[up_Reservas_INS_InsertarReserva]    Script Date: 09/03/2022 15:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: LRR
-- ALTER date: 13/01/2022
-- Description: crea una nueva reserva
-- =============================================

ALTER PROCEDURE[dbo].[up_Reservas_INS_InsertarReserva]
	@isbn			AS varchar(50),
	@dni			AS varchar(50),
	@fecha_reserva	AS date,
	@Estado			AS nvarchar(125) OUTPUT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
            INSERT INTO Reservas 
			(isbn,dni,fecha_reserva)
			VALUES
			(@isbn,@dni,@fecha_reserva)
			IF @@TRANCOUNT >0
				BEGIN
					COMMIT TRAN
				END
                    SET @Estado = 'Reserva creada correctamente'
                    SELECT 1
                    RETURN 1    
       END TRY

       BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION;
				END
                    SET @Estado = 'No se ha podido crear la reserva'
                    SELECT 0
                    RETURN 0
       END CATCH  
END