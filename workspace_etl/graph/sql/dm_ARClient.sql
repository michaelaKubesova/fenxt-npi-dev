
select
 "ARClientId",
 "ARClientType",
 "ARClientDisplayName",
 "ARClientCFDANumber",
 au.Name,
 Gooddata_Date(dateadded::date),
 Gooddata_Date(datechanged::date),
 "Amount"
from dm_ARClients ar
join stg_csv_user_merge au
	on ar.AddedByUserId = au.UserId and ar.TenantId = au.TenantId
where ar.TenantId = '${TenantId}'