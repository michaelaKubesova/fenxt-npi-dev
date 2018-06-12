drop table if exists out_Accounts;
CREATE TABLE out_Accounts
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    AccountId varchar(255),
    AccountNumber varchar(255),
    AccountDescription varchar(255),
    AccountCategory varchar(255),
    AccountCategoryTranslation varchar(255),
    FundDescription varchar(255),
    Class varchar(255),
    StatusTranslation varchar(255),
    AccountCodeDescription varchar(255),
    DateAdded varchar(255),
    DateChanged varchar(255),
    AddedByUserId varchar(255),
    AddedByUserName varchar(255),
    AddedByUserNameLabel varchar(255),
    ChangedByUserId varchar(255),
    ChangedByUserName varchar(255),
    ChangedByUserNameLabel varchar(255),
    AccountDateId varchar(255),
	IsContra varchar(255),
    Dummy varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);