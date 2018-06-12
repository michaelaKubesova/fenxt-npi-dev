drop table if exists out_ProjectBalance;
CREATE TABLE out_ProjectBalance
(
	_sys_transform_id int NOT NULL encoding rle,
	TenantId varchar(255) encoding rle,
	ProjectBalanceId varchar(255),
	 "FiscalPeriodId" int,
	 "ProjectId" int,
	 "Balance" numeric,
	 "AddBalance" numeric,
	 "EncumberanceType" varchar(255),
	 "AccountId" int,
	 "PostStatus" varchar(255)
) order by TenantId, 
			_sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);