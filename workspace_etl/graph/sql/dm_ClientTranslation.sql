select
 case when "TransactionCode1Name"='Transaction Code 1' or "TransactionCode1Name"='TransactionCode1' then 'Code 1' else "TransactionCode1Name" end,
 case when "TransactionCode2Name"='Transaction Code 2' or "TransactionCode2Name"='TransactionCode2' then 'Code 2' else "TransactionCode2Name" end,
 case when "TransactionCode3Name"='Transaction Code 3' or "TransactionCode3Name"='TransactionCode3' then 'Code 3' else "TransactionCode3Name" end,
 case when "TransactionCode4Name"='Transaction Code 4' or "TransactionCode4Name"='TransactionCode4' then 'Code 4' else "TransactionCode4Name" end,
 case when "TransactionCode5Name"='Transaction Code 5' or "TransactionCode5Name"='TransactionCode5' then 'Code 5' else "TransactionCode5Name" end,
 "ProjectName",
 "FundName",
 "GrantName",
 (select case when SegmentName like 'Account%' then SegmentName else  concat('Account ', lower(SegmentName)) end from stg_csv_AccountSegmentValue_merge asv where TenantId = '${TenantId}' and SegmentId = 1 limit 1  ) "AccountSegment1",
 (select case when SegmentName like 'Account%' then SegmentName else  concat('Account ', lower(SegmentName)) end from stg_csv_AccountSegmentValue_merge asv where TenantId = '${TenantId}' and SegmentId = 2 limit 1  ) "AccountSegment2",
 (select case when SegmentName like 'Account%' then SegmentName else  concat('Account ', lower(SegmentName)) end from stg_csv_AccountSegmentValue_merge asv where TenantId = '${TenantId}' and SegmentId = 3 limit 1  ) "AccountSegment3",
 (select case when SegmentName like 'Account%' then SegmentName else  concat('Account ', lower(SegmentName)) end from stg_csv_AccountSegmentValue_merge asv where TenantId = '${TenantId}' and SegmentId = 4 limit 1  ) "AccountSegment4",
 (select case when SegmentName like 'Account%' then SegmentName else  concat('Account ', lower(SegmentName)) end from stg_csv_AccountSegmentValue_merge asv where TenantId = '${TenantId}' and SegmentId = 5 limit 1  ) "AccountSegment5",
 (select case when SegmentName like 'Account%' then SegmentName else  concat('Account ', lower(SegmentName)) end from stg_csv_AccountSegmentValue_merge asv where TenantId = '${TenantId}' and SegmentId = 6 limit 1  ) "AccountSegment6",
 (select case when SegmentName like 'Account%' then SegmentName else  concat('Account ', lower(SegmentName)) end from stg_csv_AccountSegmentValue_merge asv where TenantId = '${TenantId}' and SegmentId = 7 limit 1  ) "AccountSegment7",
 (select case when SegmentName like 'Account%' then SegmentName else  concat('Account ', lower(SegmentName)) end from stg_csv_AccountSegmentValue_merge asv where TenantId = '${TenantId}' and SegmentId = 8 limit 1  ) "AccountSegment8",
 (select case when SegmentName like 'Account%' then SegmentName else  concat('Account ', lower(SegmentName)) end from stg_csv_AccountSegmentValue_merge asv where TenantId = '${TenantId}' and SegmentId = 9 limit 1  ) "AccountSegment9",
 (select case when SegmentName like 'Account%' then SegmentName else  concat('Account ', lower(SegmentName)) end from stg_csv_AccountSegmentValue_merge asv where TenantId = '${TenantId}' and SegmentId = 10 limit 1  ) "AccountSegment10"
from dm_ClientTranslation
where TenantId = '${TenantId}'
union all
select
 	'Code 1' TransactionCode1Name
	,'Code 2' TransactionCode2Name
	,'Code 3' TransactionCode3Name
	,'Code 4' TransactionCode4Name
	,'Code 5' TransactionCode5Name
	,'Project' ProjectName
	,'Fund' FundName
	,'Grant' GrantName
	,'Account segment 1' AccountSegment1
	,'Account segment 2' AccountSegment2
	,'Account segment 3' AccountSegment3
	,'Account segment 4' AccountSegment4
	,'Account segment 5' AccountSegment5
	,'Account segment 6' AccountSegment6
	,'Account segment 7' AccountSegment7
	,'Account segment 8' AccountSegment8
	,'Account segment 9' AccountSegment9
	,'Account segment 10' AccountSegment10
	where (select count(1) from dm_ClientTranslation 
			where TenantId = '${TenantId}') = 0