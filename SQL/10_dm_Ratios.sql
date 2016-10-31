INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Ratios',now(),null);

insert /*+ direct */ into dm_Ratios
select
    ${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	T.TenantId as "TenantId",
	cast(SUM(
		CASE 
			WHEN A.CurrentAssets = true and T.TransactionType = 1 and A.AccountCategory in (1, 5, 9)
				THEN T.Amount
			WHEN A.CurrentAssets = true and T.TransactionType = 2 and A.AccountCategory in (1, 5, 9)
				THEN -1 * T.Amount
			WHEN A.CurrentAssets = true and T.TransactionType = 1 and A.AccountCategory not in (1, 5, 9)
				THEN -1 * T.Amount
			WHEN A.CurrentAssets = true and T.TransactionType = 2 and A.AccountCategory not in (1, 5, 9)
				THEN T.Amount
			ELSE 0
		END
	) as decimal(15, 2)) as "CurrentAssets"
	,cast(SUM(
		CASE 
			WHEN A.CurrentLiability = true and T.TransactionType = 1 and A.AccountCategory in (1, 5, 9)
				THEN T.Amount
			WHEN A.CurrentLiability = true and T.TransactionType = 2 and A.AccountCategory in (1, 5, 9)
				THEN -1 * T.Amount
			WHEN A.CurrentLiability = true and T.TransactionType = 1 and A.AccountCategory not in (1, 5, 9)
				THEN -1 * T.Amount
			WHEN A.CurrentLiability = true and T.TransactionType = 2 and A.AccountCategory not in (1, 5, 9)
				THEN T.Amount
			ELSE 0
		END
	) as decimal(15, 2)) as "CurrentLiability"
	,cast(SUM(
		CASE 
			WHEN A.CashCoverageCurrentAssets = true and T.TransactionType = 1 and A.AccountCategory in (1, 5, 9)
				THEN T.Amount
			WHEN A.CashCoverageCurrentAssets = true and T.TransactionType = 2 and A.AccountCategory in (1, 5, 9)
				THEN -1 * T.Amount
			WHEN A.CashCoverageCurrentAssets = true and T.TransactionType = 1 and A.AccountCategory not in (1, 5, 9)
				THEN -1 * T.Amount
			WHEN A.CashCoverageCurrentAssets = true and T.TransactionType = 2 and A.AccountCategory not in (1, 5, 9)
				THEN T.Amount
			ELSE 0
		END
	) as decimal(15, 2)) as "CashCoverageCurrentAssets"
	,cast(SUM(
		CASE 
			WHEN A.CashCoverageExpense = true and T.TransactionType = 1 and A.AccountCategory in (1, 5, 9)
				THEN T.Amount
			WHEN A.CashCoverageExpense = true and T.TransactionType = 2 and A.AccountCategory in (1, 5, 9)
				THEN -1 * T.Amount
			WHEN A.CashCoverageExpense = true and T.TransactionType = 1 and A.AccountCategory not in (1, 5, 9)
				THEN -1 * T.Amount
			WHEN A.CashCoverageExpense = true and T.TransactionType = 2 and A.AccountCategory not in (1, 5, 9)
				THEN T.Amount
			ELSE 0
		END
	) as decimal(15, 2)) as "CashCoverageExpense"
	,cast(SUM(
		CASE 
			WHEN A.QuickRatio = true and T.TransactionType = 1 and A.AccountCategory in (1, 5, 9)
				THEN T.Amount
			WHEN A.QuickRatio = true and T.TransactionType = 2 and A.AccountCategory in (1, 5, 9)
				THEN -1 * T.Amount
			WHEN A.QuickRatio = true and T.TransactionType = 1 and A.AccountCategory not in (1, 5, 9)
				THEN -1 * T.Amount
			WHEN A.QuickRatio = true and T.TransactionType = 2 and A.AccountCategory not in (1, 5, 9)
				THEN T.Amount
			ELSE 0
		END
	) as decimal(15, 2)) as "QuickRatio"
	,GoodData_attr(T.PostStatus) as "PostStatus"
	,GoodData_attr(T.PostStatusTranslation) as "PostStatusTranslation"
	,GoodData_attr(T.EncumbranceStatus) as "EncumbranceStatus"
	,GoodData_attr(T.EncumbranceStatusTranslation) as "EncumbranceStatusTranslation"
	,GoodData_attr(T.FiscalPeriodId) as "FiscalPeriodId" 
from stg_csv_Transaction_merge T
inner join (
	select
		 a.TenantId
		,a.AccountId
		,a.AccountCategory
		,cast(MAX(CASE WHEN r.RatioConfigurationId is not null and r.RatioType = 1 THEN 1 ELSE 0 END) as boolean) as "QuickRatio"
		,cast(MAX(CASE WHEN r.RatioConfigurationId is not null and r.RatioType = 2 and wc.StaticEntryId = 2 THEN 1 ELSE 0 END) as boolean) as "CashCoverageCurrentAssets"
		,cast(MAX(CASE WHEN r.RatioConfigurationId is not null and r.RatioType = 2 and a.AccountCategory = 5 THEN 1 ELSE 0 END) as boolean) as "CashCoverageExpense"
		,cast(MAX(CASE WHEN wc.StaticEntryId = 2 THEN 1 ELSE 0 END) as boolean) as "CurrentAssets"
		,cast(MAX(CASE WHEN wc.StaticEntryId = 3 THEN 1 ELSE 0 END) as boolean) as "CurrentLiability"
	from stg_csv_Account_merge a
	left join stg_csv_AccountRatioConfiguration_merge r
		on a.AccountId = r.AccountId and a.TenantId = r.TenantId and r._sys_is_deleted = false and r.Deleted = false
	left join stg_csv_TableEntry_merge wc
		on a.WorkingCapitalId = wc.TableEntryId and a.TenantId = wc.TenantId and wc._sys_is_deleted = false and wc.Deleted = false
	where a.Deleted = false
		and a._sys_is_deleted = false

	group by a.AccountId, a.AccountCategory, a.TenantId) a on a.AccountId = T.AccountId and A.TenantId = T.TenantId
where
	T._sys_is_deleted = false
	and T.Deleted = false
group by 
	 T.PostStatus
	,T.PostStatusTranslation
	,T.EncumbranceStatus
	,T.EncumbranceStatusTranslation
	,T.FiscalPeriodId
	,T.TenantId
;


INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Ratios',null,now());
select analyze_statistics('dm_Ratios')
;