INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_PostStatus',now(),null);
insert /*+ direct */ into dm_PostStatus
select
 	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	i.TenantId as "TenantId",
	GoodData_Attr('inv-'||i.InvoiceId) as "PostStatusId",
	GoodData_Attr(i.PostStatusTranslation) as "PostStatus"
from stg_csv_invoice_merge i
union all
select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	cm.TenantId as "TenantId",
	GoodData_Attr('cm-'||cm.CreditMemoId) as "PostStatusId",
	GoodData_Attr(cm.PostStatusTranslation) as "PostStatus"
from stg_csv_CreditMemo_merge cm
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_PostStatus',null,now());
select analyze_statistics('dm_PostStatus')
;