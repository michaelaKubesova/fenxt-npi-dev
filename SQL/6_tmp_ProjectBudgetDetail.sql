truncate table tmp_ProjectBudgetDetail;

insert /*+direct*/ into tmp_ProjectBudgetDetail
select TenantId, ProjectBudgetId, FiscalPeriodId, Amount 
from stg_csv_ProjectBudgetDetail_merge 
group by TenantId, ProjectBudgetId, FiscalPeriodId, Amount;

select analyze_statistics('tmp_ProjectBudgetDetail');