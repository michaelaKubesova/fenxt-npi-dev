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
from stg_csv_Transactions_merge T
inner join stg_csv_Accounts_merge A on T.AccountId = A.AccountId and T.TenantId = A.TenantId
where
	T._sys_is_deleted = false
	and A._sys_is_deleted = false
group by 
	T.TenantId
	,T.PostStatus
	,T.PostStatusTranslation
	,T.EncumbranceStatus
	,T.EncumbranceStatusTranslation
	,T.FiscalPeriodId
;


INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Ratios',null,now());
select analyze_statistics('dm_Ratios')
;