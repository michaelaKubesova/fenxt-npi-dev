
select
 "GrantId",
 "UserId",
 "Description",
 "Type",
 "Status",
 "GrantAmount",
 "DateAdded",
 "StartDate",
 "EndDate"
from dm_Grants
where TenantId = '${TenantId}'

union all

select  
GoodData_Attr(0) as "GrantId" , 
GoodData_Attr('0') as "UserId" , 
'' as "Description",
'' as "Type",
'' as "Status",
null as "GrantAmount" , 
null as "DateAdded" , 
null as "StartDate",
null as "EndDate"

;