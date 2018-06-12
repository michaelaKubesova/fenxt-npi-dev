drop table if exists out_Tenants;
CREATE TABLE out_Tenants
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    Tenant varchar(255),
    TransactionCode1Name varchar(255),
    TransactionCode2Name varchar(255),
    TransactionCode3Name varchar(255),
    TransactionCode4Name varchar(255),
    TransactionCode5Name varchar(255),
    ProjectName varchar(255),
    FundName varchar(255),
    GrantName varchar(255),
    DataUpdated varchar(255),
	AccountSegment1Name varchar(255),
	AccountSegment2Name varchar(255),
	AccountSegment3Name varchar(255),
	AccountSegment4Name varchar(255),
	AccountSegment5Name varchar(255),
	AccountSegment6Name varchar(255),
	AccountSegment7Name varchar(255),
	AccountSegment8Name varchar(255)
)
 ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);