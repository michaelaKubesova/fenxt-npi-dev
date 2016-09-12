INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_PostStatus',now(),null);
insert /*+ direct */ into dm_PostStatus
select
 	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	TenantId as "TenantId",
	GoodData_Attr('inv-'||InvoiceId) as "PostStatusId",
	GoodData_Attr(PostStatusTranslation) as "PostStatus"
from stg_csv_invoices_merge
union all
select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	TenantId as "TenantId",
	GoodData_Attr('cm-'||CreditMemoId) as "PostStatusId",
	GoodData_Attr(PostStatusTranslation) as "PostStatus"
from stg_csv_CreditMemos_merge
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_PostStatus',null,now());
select analyze_statistics('dm_PostStatus')
;