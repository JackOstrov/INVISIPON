--select * from coninsert2
--Delete from coninsert where f1 is null

Declare @strCellPhone  nvarchar(50),
@strFirstName  nvarchar(50),
@strLastName nvarchar(50),
@iYearOfBirth nvarchar(50),
@strEmail nvarchar(50),
@strPassword nvarchar(50) = 'password',
@strPinCode nvarchar(50) ='',
@AgeGroup nvarchar(50) ='',
@Gender nvarchar(50),
@strZip nvarchar(50),
@dtDOB nvarchar(50),
@strAddress1 nvarchar(50),
@strAddress2 nvarchar(50)

Select top 1
@strCellPhone = f3,
@strFirstName = f1,
@strLastName = f2,
@iYearOfBirth = year(f10),
@strEmail = '',
@strPassword = 'password',
@strPinCode='',
@AgeGroup='',
@Gender=F9,
@strZip=f8,
@dtDOB=f10,
@strAddress1 = f4,
@strAddress2 = isnull(f5,'')
--Select top 1 *
from invisipontest..coninsert2
where dbo.fnPhoneFormat(f3)  not in (select strCellPhone from consumers)

Select @strCellPhone ,
@strFirstName ,
@strLastName ,
@iYearOfBirth,
@strEmail ,
@strPassword ,
@strPinCode,
@AgeGroup,
@Gender,
@strZip,
@dtDOB


Exec [dbo].[spConAccountCreate]
@strCellPhone ,
@strFirstName ,
@strLastName ,
@iYearOfBirth,
@strEmail ,
@strPassword ,
@strPinCode,
@AgeGroup,
@Gender,
@strZip,
@dtDOB


update [Consumers] set iActive = 1, 
strAddress1 = @strAddress1,
strAddress2 = @strAddress2
where dbo.fnPhoneFormat(@strCellPhone) = strCellPhone

GO 

select top 1 * from [Consumers] order by id desc
--exec dbo.spConAccountCategoryListProfile 37

 --select top 10 * from Consumers order by dtRegistered desc