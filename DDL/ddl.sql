drop TABLE if exists _sys_transform_id;
CREATE TABLE _sys_transform_id
(
    id int,
    entity varchar(100) encoding rle,
    ts_start timestamptz,
    ts_end timestamptz
) ORDER BY entity,
          ts_start,
          ts_end,
          id
UNSEGMENTED ALL NODES;

drop TABLE if exists _sys_load_info;
CREATE TABLE _sys_load_info
(
    project_id varchar(255),
    gdc_project_id varchar(255)  ENCODING RLE,
    ts_from timestamptz,
    ts_to timestamptz,
    event_ts timestamptz,
    event_type varchar(255)  ENCODING RLE,
    entity varchar(255)  ENCODING RLE
)  ORDER BY event_type,
            entity,
            gdc_project_id          
segmented by hash(event_ts) all nodes;

  

drop table if exists out_InvoiceDistribution;
CREATE TABLE out_InvoiceDistribution
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    InvoiceDistributionId varchar(255),
    InvoiceId varchar(255),
    AccountId varchar(255),
    ProjectId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);

drop table if exists out_Ratios;
CREATE TABLE out_Ratios
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    CurrentAssets varchar(255),
    CurrentLiability varchar(255),
    CashCoverageCurrentAssets varchar(255),
    CashCoverageExpense varchar(255),
    QuickRatio varchar(255),
    PostStatus varchar(255),
    PostStatusTranslation varchar(255),
    EncumbranceStatus varchar(255),
    EncumbranceStatusTranslation varchar(255),
    FiscalPeriodId varchar(255)
) ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);

drop table if exists out_Invoices_fact;
CREATE TABLE out_Invoices_fact
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    InvoiceFactId varchar(255),
    VendorId varchar(255),
    FiscalPeriodId varchar(255),
    InvoiceAttrId varchar(255),
    InvoiceAmount varchar(255),
    InvoiceBalance varchar(255),
    InvoiceTaxAmount varchar(255),
    InvoiceDiscountAmount varchar(255),
    DateAdded varchar(255),
    DateChanged varchar(255),
    DueDate varchar(255),
    PostDate varchar(255),
    PostStatusId varchar(255),
    Date varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);

drop TABLE if exists out_Vendors;
CREATE TABLE out_Vendors
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    DateAdded varchar(255),
    DateChanged varchar(255),
    VendorId varchar(255),
    VendorName varchar(255),
    VendorUserID varchar(255),
    CustomerNumber varchar(255),
    StatusTranslation varchar(255),
    AddedByUserName varchar(255),
    AddedByUserNameLabel varchar(255),
    VendorDateId varchar(255),
    Dummy varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);

drop table if exists out_Invoices_attr;
CREATE TABLE out_Invoices_attr
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    InvoiceId varchar(255),
    InvoiceNumber varchar(255),
    Description varchar(255),
    StatusTranslation varchar(255),
    AddedByUserName varchar(255),
    AddedByUserNameLabel varchar(255),
    InvoiceHyperlink varchar(255),
    InvoiceAttributeId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);

drop table if exists out_Users;
CREATE TABLE out_Users
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    UserId varchar(255),
	IsSupervisor varchar(255),
	Name varchar(255),
	Description varchar(255),
	Inactive varchar(255),
	HasSupervisorRights varchar(255),
	ViewOnly varchar(255)
)
 ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);


drop table if exists out_FiscalPeriods;
CREATE TABLE out_FiscalPeriods
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    FiscalPeriodId varchar(255),
    Sequence varchar(255),
    FiscalPeriodStart varchar(255),
    FiscalPeriodStart_sort varchar(255),
    FiscalPeriodEnd varchar(255),
    FiscalYearId varchar(255),
    FiscalYearName varchar(255),
    NumberOfPeriods varchar(255),
    FiscalYearStart varchar(255),
    FiscalYearStart_sort varchar(255),
    FiscalYearEnd varchar(255),
    FiscalDate varchar(255),
    FiscalYearStartDate varchar(255),
    FiscalYearEndDate varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop table if exists out_Projects;
CREATE TABLE out_Projects
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    ProjectId varchar(255),
    UserId varchar(255),
    Description varchar(255),
    Division varchar(255),
    Location varchar(255),
    Department varchar(255),
    DateAdded varchar(255),
    DateChanged varchar(255),
    AddedByUserName varchar(255),
    AddedByUserNameLabel varchar(255),
    ProjectType varchar(255),
    ProjectDateId varchar(255),
    ProjectStatus varchar(255),
    Dummy varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);


drop table if exists out_CreditMemos_fact;
CREATE TABLE out_CreditMemos_fact
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    CreditMemoFactId varchar(255),
    CreditMemoAttrId varchar(255),
    VendorId varchar(255),
    FiscalPeriodId varchar(255),
    CreditMemoAmount varchar(255),
    CreditMemoBalance varchar(255),
    PostDate varchar(255),
    DateAdded varchar(255),
    DateChanged varchar(255),
    Date varchar(255),
    PostStatusId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop table if exists out_Transactions_fact;
CREATE TABLE out_Transactions_fact
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    TransactionDistributionId varchar(255),
    TransactionAttrDistributionId varchar(255),
    AccountId varchar(255),
    ProjectId varchar(255),
    GrantId varchar(255),
    FiscalPeriodId varchar(255),
    TransactionAmount varchar(255),
    BatchId varchar(255),
    DateAdded varchar(255),
    DateChanged varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop table if exists out_Banks;
CREATE TABLE out_Banks
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    BankId varchar(255),
    DateAdded varchar(255),
    DateChanged varchar(255),
    AddedByUserName varchar(255),
    AddedByUserNameLabel varchar(255),
    ChangedByUserNameLabel varchar(255),
    BankDateId varchar(255),
    Dummy varchar(255),
    IsReconciled varchar(255),
    DateLastReconciled varchar(255),
    LastReconciledByUserName varchar(255),
    LastReconciledByUserNameLabel varchar(255),
    ReconciledBalance varchar(255),
    Name varchar(255),
    AccountId varchar(255),
    Description varchar(255),
    AccountNumber varchar(255),
    RoutingNumber varchar(255),
    AccountType varchar(255),
    AccountTypeTranslation varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop table if exists out_AccountBudgets_fact;
CREATE TABLE out_AccountBudgets_fact
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    AccountBudgetAmount varchar(255),
    AccountId varchar(255),
    FiscalPeriodId varchar(255),
    AccountBudgetFactId varchar(255),
    AccountBudgetAttrId varchar(255),
    ScenarioId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);


drop table if exists out_AccountBudgets_attr;
CREATE TABLE out_AccountBudgets_attr
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    AccountBudgetAttrId varchar(255),
    IncorrectScenarioId varchar(255),
    ScenarioId varchar(255),
    AccountBudgetId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop table if exists out_Transactions_attr;
CREATE TABLE out_Transactions_attr
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    PostStatusTranslation varchar(255),
    PostDate varchar(255),
    TransactionTypeTranslation varchar(255),
    EncumbranceStatusTranslation varchar(255),
    TransactionCode1 varchar(255),
    TransactionCode1IsActive varchar(10),
    TransactionCode2 varchar(255),
    TransactionCode2IsActive varchar(10),
    TransactionCode3 varchar(255),
    TransactionCode3IsActive varchar(10),
    TransactionCode4 varchar(255),
    TransactionCode4IsActive varchar(10),
    TransactionCode5 varchar(255),
    TransactionCode5IsActive varchar(10),
    DateAdded varchar(255),
    DateChanged varchar(255),
    TransactionAttrDistributionId varchar(255),
    TransactionId varchar(255),
    AddedByUserNameId varchar(255),
    AddedByUserName varchar(255),
    LastChangedByUserName varchar(255),
    Class varchar(255),
    TransactionAttributeId varchar(255),
	IsBeginningBalance varchar(10)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop TABLE if exists out_Grants;
CREATE TABLE out_Grants
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    GrantId varchar(255),
    UserId varchar(255),
    GrantAmount varchar(255),
    DateAdded varchar(255),
    DateChanged varchar(255),
    AddedByUserId varchar(255),
    AddedByUserName varchar(255),
    AddedByUserNameLabel varchar(255),
    ChangedByUserId varchar(255),
    ChangedByUserName varchar(255),
    ChangedByUserNameLabel varchar(255),
    GrantDateId varchar(255),
    Dummy varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



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
    Dummy varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);




drop table if exists out_ProjectBudgets;
CREATE TABLE out_ProjectBudgets
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    PeriodAmount varchar(255),
    ProjectBudgetId varchar(255),
    AccountBudgetAttrId varchar(255),
    ProjectId varchar(255),
    AccountId varchar(255),
    ProjectBudgetAmount varchar(255),
    FiscalPeriodId varchar(255),
    ScenarioId varchar(255)
) ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop table if exists out_CreditMemos_attr;
CREATE TABLE out_CreditMemos_attr
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    DateAdded varchar(255),
    DateChanged varchar(255),
    CreditMemoAttrId varchar(255),
    Date varchar(255),
    PostDate varchar(255),
    AddedByUserId varchar(255),
    AddedByUserName varchar(255),
    AddedByUserNameLabel varchar(255),
    ChangedByUserId varchar(255),
    ChangedByUserName varchar(255),
    ChangedByUserNameLabel varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop table if exists out_GLBatches;
CREATE TABLE out_GLBatches
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    DateAdded varchar(255),
    DateChanged varchar(255),
    DateDeleted varchar(255),
    DateApproved varchar(255),
    BatchId varchar(255),
    BatchNumber varchar(255),
    StatusTranslation varchar(255),
    AddedByUserName varchar(255),
    AddedByUserNameLabel varchar(255),
    ChangedByUserNameLabel varchar(255),
    DeletedByNameLabel varchar(255),
    ApprovedByUserNameLabel varchar(255),
    BatchDateId varchar(255),
    BatchHyperlink varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop table if exists out_AccountUserSecurity;
CREATE TABLE out_AccountUserSecurity
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    AccountUserSecurityId varchar(255),
    UserId varchar(255),
    AccountId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop TABLE if exists out_ProjectUserSecurity;
CREATE TABLE out_ProjectUserSecurity
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    ProjectUserSecurityId varchar(255),
    UserId varchar(255),
    ProjectId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop table if exists out_GLBatches_fact;
CREATE TABLE out_GLBatches_fact
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    BatchFactId varchar(255),
    BatchId varchar(255),
    DebitAmount varchar(255),
    CreditAmount varchar(255),
    DateAdded varchar(255),
    DateChanged varchar(255),
    DateApproved varchar(255),
    DateDeleted varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id,
          BatchFactId
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop table if exists out_BudgetScenario;
CREATE TABLE out_BudgetScenario
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    ScenarioId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id,
          ScenarioId
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop table if exists out_TransactionScenario;
CREATE TABLE out_TransactionScenario
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    TransactionScenarioId varchar(255),
    TransactionDistributionId varchar(255),
    ScenarioId varchar(255),
    FiscalPeriodId varchar(255),
    AccountId varchar(255)
)
 ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop TABLE if exists out_PostStatus;
CREATE TABLE out_PostStatus
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    PostStatusId varchar(255),
    PostStatus varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);




drop table if exists out_TransactionProjectScenario;
CREATE TABLE out_TransactionProjectScenario
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    TransactionScenarioId varchar(255),
    ProjectId varchar(255),
    TransactionAttrDistributionId varchar(255),
    ScenarioId varchar(255),
    FiscalPeriodId varchar(255),
    AccountId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop TABLE if exists out_ClientTranslation;
CREATE TABLE out_ClientTranslation
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    TransactionCode1Name varchar(255),
    TransactionCode2Name varchar(255),
    TransactionCode3Name varchar(255),
    TransactionCode4Name varchar(255),
    TransactionCode5Name varchar(255),
    ProjectName varchar(255),
    FundName varchar(255),
    GrantName varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



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



drop table if exists out_ProjectHistory;
CREATE TABLE out_ProjectHistory
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    ProjectHistoryId varchar(255),
    ProjectId varchar(255),
    FieldChanged varchar(255),
    FieldChangedTranslation varchar(255),
    OldValue varchar(255),
    NewValue varchar(255),
    DateChanged varchar(255),
    ChangedByUserName varchar(255)
) ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop table if exists out_VendorHistory;
CREATE TABLE out_VendorHistory
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    VendorHistoryId varchar(255),
    VendorId varchar(255),
    FieldChanged varchar(255),
    FieldChangedTranslation varchar(255),
    OldValue varchar(255),
    NewValue varchar(255),
    DateChanged varchar(255),
    ChangedByUserName varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop TABLE if exists out_AccountHistory;
CREATE TABLE out_AccountHistory
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    AccountHistoryId varchar(255),
    AccountId varchar(255),
    FieldChanged varchar(255),
    FieldChangedTranslation varchar(255),
    OldValue varchar(255),
    NewValue varchar(255),
    DateChanged varchar(255),
    ChangedByUserName varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop TABLE if exists out_BankUserSecurity;
CREATE TABLE out_BankUserSecurity
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    BankUserSecurityId varchar(255),
    UserId varchar(255),
    BankId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);




drop table if exists out_BankReconciliationHistory;
CREATE TABLE out_BankReconciliationHistory
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    BankReconciliationId varchar(255),
    BankId varchar(255),
    ReconciliationDate varchar(255),
    ReconciliationBalance varchar(255),
    AddedByUserId varchar(255),
    AddedByUserName varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);


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



drop table if exists wk_Transactions_TransactionDistribution_Join cascade;
CREATE TABLE wk_Transactions_TransactionDistribution_Join
(
    TenantId varchar(255) encoding rle,
    TransactionTypeTranslation varchar(255),
    EncumbranceStatusTranslation varchar(255),
    AddedById int,
    DateAdded varchar(255),
    LastChangedById int,
    DateChanged varchar(255),
    BatchId int,
    PostStatusTranslation varchar(255),
    AccountId int  encoding rle,
    PostDate varchar(255),
    FiscalPeriodId int encoding rle,
    GrantId int,
    TranDistributionId int,
    TransactionId int encoding rle,
    Projectid int  encoding rle,
    ClassId int,
    TDAmount numeric,
    TransactionCode1Id int,
    TransactionCode2Id int,
    TransactionCode3Id int,
    TransactionCode4Id int,
    TransactionCode5Id int
)  ORDER BY TenantId,
          AccountId,
          Projectid,
          FiscalPeriodId
SEGMENTED BY hash(TenantId) ALL NODES;

CREATE PROJECTION wk_Transactions_TransactionDistribution_Join_agg
(
 TenantId ENCODING RLE,
 AccountId ENCODING RLE,
 FiscalPeriodId ENCODING RLE,
 TranDistributionId
)
AS
 SELECT TenantId,
        AccountId,
        FiscalPeriodId,
        TranDistributionId
 FROM wk_Transactions_TransactionDistribution_Join
 ORDER BY TenantId, AccountId, FiscalPeriodId, TranDistributionId
SEGMENTED BY hash(TenantId, AccountId, FiscalPeriodId, TranDistributionId) ALL NODES;

CREATE PROJECTION wk_Transactions_TransactionDistribution_Join_attr
(
 TenantId ENCODING RLE,
 TransactionTypeTranslation,
 EncumbranceStatusTranslation,
 AddedById ENCODING RLE,
 DateAdded,
 LastChangedById ENCODING RLE,
 DateChanged,
 PostStatusTranslation,
 PostDate,
 TransactionId,
 TranDistributionId,
 ClassId ENCODING RLE,
 TransactionCode1Id ENCODING RLE,
 TransactionCode2Id ENCODING RLE,
 TransactionCode3Id ENCODING RLE,
 TransactionCode4Id ENCODING RLE,
 TransactionCode5Id ENCODING RLE
)
AS
 SELECT TenantId,
        TransactionTypeTranslation,
        EncumbranceStatusTranslation,
        AddedById,
        DateAdded,
        LastChangedById,
        DateChanged,
        PostStatusTranslation,
        PostDate,
        TransactionId,
        TranDistributionId,
        ClassId,
        TransactionCode1Id,
        TransactionCode2Id,
        TransactionCode3Id,
        TransactionCode4Id,
        TransactionCode5Id
 FROM wk_Transactions_TransactionDistribution_Join
 ORDER BY TenantId,AddedById,LastChangedById,
          TransactionCode1Id,TransactionCode2Id,TransactionCode3Id,TransactionCode4Id,TransactionCode5Id,ClassId
SEGMENTED BY hash(TenantId) ALL NODES;



drop TABLE if exists wk_FiscalPeriod_Scenario_Join;
CREATE TABLE wk_FiscalPeriod_Scenario_Join
(
    TenantId varchar(255) encoding rle,
    ProjectId int,
    AccountId int,
    ScenarioId varchar(255),
    FiscalPeriodId int
) order by TenantId,AccountId,ProjectId,FiscalPeriodId
SEGMENTED BY hash(TenantId) ALL NODES;


drop TABLE if exists wk_AccountBudgetScenario cascade;
CREATE TABLE wk_AccountBudgetScenario
(
    TenantId varchar(255) encoding rle,
    AccountId int,
    AccountBudgetId int,
    CodeTableId int,
    ScenarioId varchar(255)
) ORDER BY TenantId,
           AccountBudgetId,
           AccountId
UNSEGMENTED ALL NODES;

CREATE PROJECTION wk_AccountBudgetScenario_account
(
 TenantId encoding rle,
 AccountId,
 AccountBudgetId,
 CodeTableId,
 ScenarioId
)
AS
 SELECT TenantId,
        AccountId,
        AccountBudgetId,
        CodeTableId,
        ScenarioId
 FROM wk_AccountBudgetScenario
 ORDER BY TenantId,
          AccountId
UNSEGMENTED ALL NODES;


drop table if exists out_ARClients;
CREATE TABLE out_ARClients
(
	_sys_transform_id int NOT NULL encoding rle,
	TenantId varchar(255) encoding rle,
	ARClientId varchar(255),
	 ARClientType varchar(255),
	 ARClientDisplayName varchar(255),
	 ARClientCFDANumber varchar(255),
	 AddedByUserId int,
	 dateadded varchar(255),
	 datechanged varchar(255),
	 Amount numeric
) order by TenantId, 
			_sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);


drop table if exists out_ARCharges;
CREATE TABLE out_ARCharges
(
	_sys_transform_id int NOT NULL encoding rle,
	TenantId varchar(255) encoding rle,
	ARChargeId int,
	ARChargeType varchar(255),
	ARChargeInvoiceId int,
	ARChargeLineItemSequence int,
	ARChargePostStatus varchar(255),
	ARChargePaymentStatus varchar(255),
	ARChargeItemDescription varchar(255),
	ARChargeAmount numeric,
	ARChargeBalance numeric, 
	ARClientId int,
	datechanged varchar(255),
	dateadded varchar(255),
	postdate varchar(255),
	duedate varchar(255)
) order by TenantId, 
			_sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);

drop table if exists out_CheckHistory;
CREATE TABLE out_CheckHistory
(
   _sys_transform_id integer NOT NULL encoding rle,
   TenantId varchar(255) encoding rle,
   CheckHistoryId varchar(255),
   CheckNumber varchar(255),
   VendorName varchar(255),
   FieldChanged varchar(255),
   FieldChangedTranslation varchar(255),
   OldValue varchar(255),
   NewValue varchar(255),
   DateChanged varchar(255),
   PostStatus varchar(255),
   BankId varchar(255),
   ChangedByUserName varchar(255),
   DrillInId varchar(255)
) order by TenantId,
			_sys_transform_id
SEGMENTED BY hash(TenantId) ALL nodes
PARTITION BY (_sys_transform_id)
;

