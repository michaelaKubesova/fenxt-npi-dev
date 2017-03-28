
select
 "ARClientId",
 "ARClientType",
 "ARClientDisplayName",
 "ARClientCFDANumber",
 "AddedByUserId",
 "dateadded",
 "datechanged"
from stg_csv_ARClient_merge ar
join stg_csv_user_merge au
	on ar.AddedByUserId = au.UserId and ar.TenantId = au.TenantId
where ar.TenantId = '${TenantId}'