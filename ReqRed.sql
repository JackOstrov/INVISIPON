Select [dtDate],reqCount,transCount, InStoreCount, (transCount+InStoreCount)/convert(decimal(10,4),reqCount) ReqPerRedeem
from [dbo].[biDates] d
inner join 
(SELECT convert(date,[dtSaleRequestInserted]) reqDate, count(*) reqCount
  FROM [Invisipon].[dbo].[SaleRequest]
  group by convert(date,[dtSaleRequestInserted])) req
  on req.reqDate=d.dtDate
inner join 
( SELECT convert(date,[dtSaleTransInserted]) transDate, count(*) transCount
  FROM [Invisipon].[dbo].[SaleTrans]
  group by convert(date,[dtSaleTransInserted])) trans
  on trans.transDate=d.dtDate
inner join 
( SELECT convert(date,[dtSaleTransInserted]) InStoreDate, count(*) InStoreCount
  FROM [Invisipon].[dbo].[SaleInStore]
  group by convert(date,[dtSaleTransInserted])) InStore
  on InStore.InStoreDate=d.dtDate

order by 1