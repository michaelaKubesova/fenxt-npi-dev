select 1 as AccountSegmentId, AccountSegment1Name as AccountSegmentName from stg_csv_Tenant_merge where AccountSegment1Name != '' and TenantId = '${TenantId}'
union all
select 2 as AccountSegmentId, AccountSegment2Name as AccountSegmentName from stg_csv_Tenant_merge where AccountSegment2Name != '' and TenantId = '${TenantId}'
union all
select 3 as AccountSegmentId, AccountSegment3Name as AccountSegmentName from stg_csv_Tenant_merge where AccountSegment3Name != '' and TenantId = '${TenantId}'
union all
select 4 as AccountSegmentId, AccountSegment4Name as AccountSegmentName from stg_csv_Tenant_merge where AccountSegment4Name != '' and TenantId = '${TenantId}'
union all
select 5 as AccountSegmentId, AccountSegment5Name as AccountSegmentName from stg_csv_Tenant_merge where AccountSegment5Name != '' and TenantId = '${TenantId}'
union all
select 6 as AccountSegmentId, AccountSegment6Name as AccountSegmentName from stg_csv_Tenant_merge where AccountSegment6Name != '' and TenantId = '${TenantId}'
union all
select 7 as AccountSegmentId, AccountSegment7Name as AccountSegmentName from stg_csv_Tenant_merge where AccountSegment7Name != '' and TenantId = '${TenantId}'
union all
select 8 as AccountSegmentId, AccountSegment8Name as AccountSegmentName from stg_csv_Tenant_merge where AccountSegment8Name != '' and TenantId = '${TenantId}' 
;	