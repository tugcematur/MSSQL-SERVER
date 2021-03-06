USE [Bankadb]
GO
/****** Object:  StoredProcedure [dbo].[HataVer]    Script Date: 12/24/2021 9:08:43 AM ******/
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
	
	
	if @Tutar <= @bakiye
	BEGIN
    -- Insert statements for procedure here
	UPDATE Musteri SET Bakiye = Bakiye - @Tutar 
	WHERE MusteriId = @MusteriId

	INSERT INTO Hareket (Tarih,Tutar,MusteriId) VALUES (GETDATE(),@Tutar*-1,@MusteriId)
	END
	else
	Begin
	PRINT 'Yetersiz Bakiye' 
	End
END

