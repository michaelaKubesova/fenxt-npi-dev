select
 "TransactionCode1Name",
 "TransactionCode2Name",
 "TransactionCode3Name",
 "TransactionCode4Name",
 "TransactionCode5Name",
 "AccountSegment1Name",
 "ProjectName",
 "FundName",
 "GrantName"
from dm_ClientTranslation
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_CLIENTTRANSLATION_TRANSFORM_ID}