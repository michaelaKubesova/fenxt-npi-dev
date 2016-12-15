select Gooddata_attr(T.GL7ACCOUNTSID||'#'||T.SEQUENCE) as AccountSegmentId
,T.GL7ACCOUNTSID as AccountId
	,T.SEQUENCE as SegmentNumber
	,T.SegmentName as SegmentName
	,T.KEYVALUE as AccountSegmentValue from stg_csv_AccountSegmentValue_merge T where TenantId = '${TenantId}';

