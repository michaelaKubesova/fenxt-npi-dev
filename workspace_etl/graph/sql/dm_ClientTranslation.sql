select
 "TransactionCode1Name",
 "TransactionCode2Name",
 "TransactionCode3Name",
 "TransactionCode4Name",
 "TransactionCode5Name",
 "ProjectName",
 "FundName",
 "GrantName"
from dm_ClientTranslation
where TenantId = '${TenantId}'
union all
select
 	'TransactionCode1' TransactionCode1Name
	,'TransactionCode2' TransactionCode2Name
	,'TransactionCode3' TransactionCode3Name
	,'TransactionCode4' TransactionCode4Name
	,'TransactionCode5' TransactionCode5Name
	,'Project' ProjectName
	,'Fund' FundName
	,'Grant' GrantName
	where (select count(1) from dm_ClientTranslation 
			where TenantId = '${TenantId}') = 0