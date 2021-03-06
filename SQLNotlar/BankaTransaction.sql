USE [Bankadb]
GO
/****** Object:  StoredProcedure [dbo].[HataVer]    Script Date: 12/24/2021 10:28:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[HataVer]
	-- Add the parameters for the stored procedure here
	@MusteriId int,
	@Tutar decimal(18,2)

AS
BEGIN
    DECLARE @bakiye decimal(10,2)
    Select @bakiye = Bakiye from Musteri WHERE MusteriId = @MusteriId
	
	BEGIN TRAN
	BEGIN TRY
	if @Tutar <= @bakiye
	BEGIN
    -- Insert statements for procedure here
	UPDATE Musteri SET Bakiye = Bakiye - @Tutar 
	WHERE MusteriId = @MusteriId

	INSERT INTO Hareket (Tarih,Tutar,MusteriId) VALUES ('sfsfsf',@Tutar*-1,@MusteriId)
	END
	
	else
	Begin
	PRINT 'Yetersiz Bakiye' 
	End
	COMMIT TRAN
	END TRY
	
	BEGIN CATCH
	Rollback TRAN
	PRINT 'Bir hata oluştu ve işlem geri alındı'
	END CATCH
	
END

