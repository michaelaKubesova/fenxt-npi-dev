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

  

drop table if exists dm_InvoiceDistribution;
CREATE TABLE dm_InvoiceDistribution
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

drop table if exists dm_Ratios;
CREATE TABLE dm_Ratios
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

drop table if exists dm_Invoices_fact;
CREATE TABLE dm_Invoices_fact
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

drop TABLE if exists dm_Vendors;
CREATE TABLE dm_Vendors
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

drop table if exists dm_Invoices_attr;
CREATE TABLE dm_Invoices_attr
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

drop table if exists dm_Users;
CREATE TABLE dm_Users
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


drop table if exists dm_FiscalPeriods;
CREATE TABLE dm_FiscalPeriods
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



drop table if exists dm_Projects;
CREATE TABLE dm_Projects
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


drop table if exists dm_CreditMemos_fact;
CREATE TABLE dm_CreditMemos_fact
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



drop table if exists dm_Transactions_fact;
CREATE TABLE dm_Transactions_fact
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



drop table if exists dm_Banks;
CREATE TABLE dm_Banks
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



drop table if exists dm_AccountBudgets_fact;
CREATE TABLE dm_AccountBudgets_fact
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


drop table if exists dm_AccountBudgets_attr;
CREATE TABLE dm_AccountBudgets_attr
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



drop table if exists dm_Transactions_attr;
CREATE TABLE dm_Transactions_attr
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
    TransactionAttributeId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop TABLE if exists dm_Grants;
CREATE TABLE dm_Grants
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



 drop table if exists dm_Accounts;
CREATE TABLE dm_Accounts
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
	AccountSegment1 varchar(255),
	AccountSegment2 varchar(255),
	AccountSegment3 varchar(255),
	AccountSegment4 varchar(255),
	AccountSegment5 varchar(255),
	AccountSegment6 varchar(255),
	AccountSegment7 varchar(255),
	AccountSegment8 varchar(255),
    Dummy varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);




drop table if exists dm_ProjectBudgets;
CREATE TABLE dm_ProjectBudgets
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



drop table if exists dm_CreditMemos_attr;
CREATE TABLE dm_CreditMemos_attr
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



drop table if exists dm_GLBatches;
CREATE TABLE dm_GLBatches
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



drop table if exists dm_AccountUserSecurity;
CREATE TABLE dm_AccountUserSecurity
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



drop TABLE if exists dm_ProjectUserSecurity;
CREATE TABLE dm_ProjectUserSecurity
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



drop table if exists dm_GLBatches_fact;
CREATE TABLE dm_GLBatches_fact
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



drop table if exists dm_BudgetScenario;
CREATE TABLE dm_BudgetScenario
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    ScenarioId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id,
          ScenarioId
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop table if exists dm_TransactionScenario;
CREATE TABLE dm_TransactionScenario
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



drop TABLE if exists dm_PostStatus;
CREATE TABLE dm_PostStatus
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    PostStatusId varchar(255),
    PostStatus varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);




drop table if exists dm_TransactionProjectScenario;
CREATE TABLE dm_TransactionProjectScenario
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



drop TABLE if exists dm_ClientTranslation;
CREATE TABLE dm_ClientTranslation
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    TransactionCode1Name varchar(255),
    TransactionCode2Name varchar(255),
    TransactionCode3Name varchar(255),
    TransactionCode4Name varchar(255),
    TransactionCode5Name varchar(255),
    AccountSegment1Name varchar(255),
	AccountSegment2Name varchar(255),
	AccountSegment3Name varchar(255),
	AccountSegment4Name varchar(255),
	AccountSegment5Name varchar(255),
	AccountSegment6Name varchar(255),
	AccountSegment7Name varchar(255),
	AccountSegment8Name varchar(255),
    ProjectName varchar(255),
    FundName varchar(255),
    GrantName varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);



drop table if exists dm_Tenants;
CREATE TABLE dm_Tenants
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



drop table if exists dm_ProjectHistory;
CREATE TABLE dm_ProjectHistory
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



drop table if exists dm_VendorHistory;
CREATE TABLE dm_VendorHistory
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



drop TABLE if exists dm_AccountHistory;
CREATE TABLE dm_AccountHistory
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



drop TABLE if exists dm_BankUserSecurity;
CREATE TABLE dm_BankUserSecurity
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




drop table if exists dm_BankReconciliationHistory;
CREATE TABLE dm_BankReconciliationHistory
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



drop table if exists wk_Transactions_TransactionDistribution_Join;
CREATE TABLE wk_Transactions_TransactionDistribution_Join
(
    TenantId varchar(255) encoding rle,
	TransactionTypeTranslation varchar(255),
	TAmount varchar(255),
	Reference varchar(255),
	JournalId varchar(255),
	EncumbranceStatus varchar(255),
	EncumbranceStatusTranslation varchar(255),
	ReverseDate varchar(255),
	ReversedTransactionId varchar(255),
	TransactionNumber varchar(255),
	SourceRecordId varchar(255),
	TTransactionId varchar(255),
	SourceNumber varchar(255),
	SourceType varchar(255),
	SourceSystemMask varchar(255),
	AddedById varchar(255),
	DateAdded varchar(255),
	LastChangedById varchar(255),
	DateChanged varchar(255),
	TDeleted varchar(255),
	BatchId varchar(255),
	PostStatus varchar(255),
	PostStatusTranslation varchar(255),
	AccountId varchar(255),
	PostDate varchar(255),
	FiscalPeriodId varchar(255),
	TransactionType varchar(255),
	TransactionCode3Id varchar(255),
	TransactionCode4Id varchar(255),
	TransactionCode5Id varchar(255),
	GrantId varchar(255),
	TDDeleted varchar(255),
	TranDistributionId varchar(255),
	TDTransactionId varchar(255),
	Projectid varchar(255),
	ClassId varchar(255),
	TDAmount varchar(255),
	Comment varchar(255),
	TransactionCode1Id varchar(255),
	TransactionCode2Id varchar(255)
)  ORDER BY TenantId
SEGMENTED BY hash(TenantId) ALL NODES