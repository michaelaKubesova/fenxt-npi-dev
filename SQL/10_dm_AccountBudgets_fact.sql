INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_AccountBudgets_fact',now(),null);
insert /*+ direct */ into dm_AccountBudgets_fact
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
TenantId as "TenantId",
cast(Amount as decimal(15,2)) as "AccountBudgetAmount",
GoodData_Attr(AccountId)  as "AccountId",
GoodData_Attr(FiscalPeriodId) as "FiscalPeriodId",
GoodData_Attr(AccountBudgetDetailId) as "AccountBudgetFactId",
GoodData_Attr(AccountBudgetDetailId) as "AccountBudgetAttrId" ,
GoodData_Attr(ScenarioId) as "ScenarioId" 
from stg_csv_AccountBudgets_merge
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_AccountBudgets_fact',null,now());
select analyze_statistics('dm_AccountBudgets_fact')
;