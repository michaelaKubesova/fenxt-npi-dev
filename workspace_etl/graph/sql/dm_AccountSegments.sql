select Gooddata_attr(T.AccountId||'#'||T.SegmentId) as AccountSegmentId
,T.AccountId as AccountId
	,T.SegmentId as SegmentNumber
	,T.SegmentName as SegmentName
	,T.AccountSegmentValue as AccountSegmentValue from stg_csv_AccountSegmentValue_merge T where TenantId = '${TenantId}';

