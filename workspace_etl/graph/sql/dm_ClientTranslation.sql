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
and _sys_transform_id = ${DM_CLIENTTRANSLATION_TRANSFORM_ID}
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