INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_BankReconciliationHistory',now(),null);
insert /*+ direct */ into out_BankReconciliationHistory
select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	b.TenantId as "TenantId",
	 GoodData_Attr(b.BankReconciliationId) as "BankReconciliationId"
	,GoodData_Attr(b.BankId) as "BankId"
	,GoodData_Date(b.ReconciliationDate) as "ReconciliationDate"
	,cast(b.ReconciliationBalance as decimal(15, 2)) as "ReconciliationBalance"
	,GoodData_Attr(b.AddedByUserId) as "AddedByUserId"
	,GoodData_Attr(u.Name) as "AddedByUserName"
from stg_csv_BankReconciliationHistory_merge b
left join stg_csv_User_merge u on
	b.addedByUserId = u.UserId and b.TenantId = u.TenantId
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_BankReconciliationHistory',null,now());
select analyze_statistics('out_BankReconciliationHistory')
;