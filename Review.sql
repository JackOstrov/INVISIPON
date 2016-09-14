Drop table [ConReviewRequest]
CREATE TABLE [dbo].[ConReviewRequest](
	[iRequestId] [int] IDENTITY(1,1) NOT NULL,
	[strReviewWhat] nvarchar(50)  NOT NULL,
	[dtRequestSent] [datetime] NOT NULL default getdate(),
	[iConId] [bigint] NOT NULL)
GO

Drop table [ConReview]
CREATE TABLE [dbo].[ConReview](
	[iReviewId] [int] IDENTITY(1,1) NOT NULL,
	[strReviewWhat] nvarchar(50) NOT NULL,
	[dtReview] [datetime] NOT NULL default getdate(),
	[iConId] [bigint] NOT NULL)
GO

/*
EXEC spConReviewRequestAdd 47,'Android'
Select * from [ConReviewRequest]
*/

Alter procedure spConReviewRequestAdd
@iConId [bigint]
,@strReviewWhat nvarchar(50) 
AS 

Insert into [ConReviewRequest] ([strReviewWhat],[iConId])
values(@strReviewWhat, @iConId)

GO

/*
EXEC spConReviewAdd 47,'Android'
Select * from [ConReview]
*/

Alter procedure spConReviewAdd
@iConId [bigint]
,@strReviewWhat nvarchar(50) 
AS 

Insert into [ConReview] ([strReviewWhat],[iConId])
values(@strReviewWhat, @iConId)

GO

/*
EXEC spConReviewOK 30418,'Android'
Select * from [ConReviewRequest]
Select * from SaleTrans

*/

Alter procedure spConReviewOK
@iConId [bigint]
,@strReviewWhat nvarchar(50) 
AS 
Declare @ConRedeemed int
Declare @OK tinyint =0


Set @ConRedeemed = isnull((Select count(iConId) from SaleTrans where iConId=  @iConId),0)
Set @ConRedeemed += isnull((Select count(iConId) from SaleInStore where iConId = @iConId),0)

IF @ConRedeemed>5 
		if not exists(Select * from [ConReviewRequest] 
		where iConId = @iConId and @strReviewWhat=strReviewWhat and datediff(d,getdate(),[dtRequestSent])<30)
		Begin	
			Set @OK = 1
			Insert into [ConReviewRequest] ([strReviewWhat],[iConId])
									 values(@strReviewWhat, @iConId)
		End
Select @OK
Return @OK
GO