select
 "TransactionCode1Name",
 "TransactionCode2Name",
 "TransactionCode3Name",
 "TransactionCode4Name",
 "TransactionCode5Name",
 "AccountSegment1Name",
 "AccountSegment2Name",
 "AccountSegment3Name",
 "AccountSegment4Name",
 "AccountSegment5Name",
 "AccountSegment6Name",
 "AccountSegment7Name",
 "AccountSegment8Name",
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
	,'AccountSegment1Name' "AccountSegment1Name",
	 'AccountSegment2Name' "AccountSegment2Name",
	 'AccountSegment3Name' "AccountSegment3Name",
	 'AccountSegment4Name' "AccountSegment4Name",
	 'AccountSegment5Name' "AccountSegment5Name",
	 'AccountSegment6Name' "AccountSegment6Name",
	 'AccountSegment7Name' "AccountSegment7Name",
	 'AccountSegment8Name' "AccountSegment8Name"
	,'Project' ProjectName
	,'Fund' FundName
	,'Grant' GrantName
	where (select count(1) from dm_ClientTranslation 
			where TenantId = '${TenantId}'
				and _sys_transform_id = ${DM_CLIENTTRANSLATION_TRANSFORM_ID}) = 0