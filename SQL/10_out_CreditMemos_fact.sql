INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_CreditMemos_fact',now(),null);
insert /*+ direct */ into out_CreditMemos_fact
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
cm.TenantId as "TenantId",
	 GoodData_Attr(cm.CreditMemoId) as "CreditMemoFactId"
	,GoodData_Attr(cm.CreditMemoId)  as "CreditMemoAttrId"
	,GoodData_Attr(cm.VendorId)  as "VendorId"
	,GoodData_Attr(fp.FiscalPeriodId)  as "FiscalPeriodId"
	,cast(cm.Amount as decimal(15,2)) as "CreditMemoAmount"
	,cast((cm.Amount - cm.CreditApplied) as decimal(15,2)) as "CreditMemoBalance"
	,GoodData_Date(cm.PostDate) as "PostDate"
	,GoodData_Date(cm.DateAdded) as "DateAdded"
	,GoodData_Date(cm.DateChanged) as "DateChanged"
	,GoodData_Date(cm.Date) as "Date"
	,GoodData_Attr('cm-'||cm.CreditMemoId) as "PostStatusId"
from stg_csv_creditmemo_merge cm
left join stg_csv_fiscalperiod_merge fp
	on cm.PostDate >= fp.StartDate and cm.PostDate <= fp.EndDate
	and cm.TenantId = fp.TenantId
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_CreditMemos_fact',null,now());
select analyze_statistics('out_CreditMemos_fact')
;
