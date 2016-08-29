--Sat Feb  6 18:12:14 2016, Extracted SQL from: "/Users/vasek/Documents/workspace/BBFE_DEV10/graph/DATAMARTS_LOAD_template.grf" 
--ARCredits----------------ARCredits----------------ARCredits----------------ARCredits----------------ARCredits----------------ARCredits----------------ARCredits--
select distinct  GoodData_Attr(CreditId) as "CreditId",
 case when nvl(ClientId,'') = '' then '0' else cast(nvl(ClientId,'') as varchar(32))  end  as "ClientId",
GoodData_date(TransactionDate)  as "TransactionDate",
GoodData_Attr(CreditUserId) as "CreditUserId",
decimal12_2(CreditAmount ) as "CreditAmount",
GoodData_Attr(TransactionType) as "TransactionType",
GoodData_Attr(TransactionTypeTranslation) as "TransactionTypeTranslation",
GoodData_date(PostDate)  as "PostDate",
GoodData_Attr(PostStatus) as "PostStatus",
GoodData_Attr(PostStatusTranslation) as "PostStatusTranslation" 
from ARCredits where CreditId <> ''   
 union 
select   GoodData_Attr('') as "CreditId" , '0' as "ClientId" , GoodData_date(null) as "TransactionDate" , GoodData_Attr('') as "CreditUserId" , decimal12_2(null) as "CreditAmount" , GoodData_Attr('') as "TransactionType" , GoodData_Attr('') as "TransactionTypeTranslation" , GoodData_date(null) as "PostDate" , GoodData_Attr('') as "PostStatus" , GoodData_Attr('') as "PostStatusTranslation"     ;


--Vendors----------------Vendors----------------Vendors----------------Vendors----------------Vendors----------------Vendors----------------Vendors--
select distinct  GoodData_Attr(VendorId) as "VendorId",
GoodData_Attr(VendorName) as "VendorName",
GoodData_Attr(Is1099) as "Is1099",
GoodData_Attr(CustomerNumber) as "CustomerNumber",
GoodData_Attr(Status) as "Status",
GoodData_Attr(StatusTranslation) as "StatusTranslation" 
from Vendors where VendorId <> ''   
 union 
select   GoodData_Attr('') as "VendorId" , GoodData_Attr('') as "VendorName" , GoodData_Attr('') as "Is1099" , GoodData_Attr('') as "CustomerNumber" , GoodData_Attr('') as "Status" , GoodData_Attr('') as "StatusTranslation"     ;


--ARClients----------------ARClients----------------ARClients----------------ARClients----------------ARClients----------------ARClients----------------ARClients--
select distinct  GoodData_Attr(ClientId) as "ClientId",
GoodData_Attr(RecordType) as "RecordType",
GoodData_Attr(RecordTypeTranslation) as "RecordTypeTranslation",
GoodData_Attr(Name) as "Name",
GoodData_Attr(UserId) as "UserId" 
from ARClients where ClientId <> ''   
 union 
select   GoodData_Attr('') as "ClientId" , GoodData_Attr('') as "RecordType" , GoodData_Attr('') as "RecordTypeTranslation" , GoodData_Attr('') as "Name" , GoodData_Attr('') as "UserId"     ;


--AccountBudgets----------------AccountBudgets----------------AccountBudgets----------------AccountBudgets----------------AccountBudgets----------------AccountBudgets----------------AccountBudgets--
select distinct  GoodData_Attr(AccountBudgetId) as "AccountBudgetId",
decimal12_2(Amount ) as "Amount",
GoodData_Attr(ScenarioId) as "ScenarioId",
 case when nvl(AccountId,'') = '' then '0' else cast(nvl(AccountId,'') as varchar(32))  end  as "AccountId",
 case when nvl(FiscalYearId,'') = '' then '0' else cast(nvl(FiscalYearId,'') as varchar(32))  end  as "FiscalYearId" 
from AccountBudgets where AccountBudgetId <> ''   
 union 
select   GoodData_Attr('') as "AccountBudgetId" , decimal12_2(null) as "Amount" , GoodData_Attr('') as "ScenarioId" , '0' as "AccountId" , '0' as "FiscalYearId"     ;


--InvoiceAdjustments----------------InvoiceAdjustments----------------InvoiceAdjustments----------------InvoiceAdjustments----------------InvoiceAdjustments----------------InvoiceAdjustments----------------InvoiceAdjustments--
select distinct  GoodData_Attr(AdjustmentId) as "AdjustmentId",
 case when nvl(InvoiceId,'') = '' then '0' else cast(nvl(InvoiceId,'') as varchar(32))  end  as "InvoiceId",
decimal12_2(Amount ) as "Amount",
decimal12_2(TaxAmount ) as "TaxAmount",
GoodData_date(PostDate)  as "PostDate",
GoodData_date(AdjustmentDate)  as "AdjustmentDate" 
from InvoiceAdjustments where AdjustmentId <> ''   
 union 
select   GoodData_Attr('') as "AdjustmentId" , '0' as "InvoiceId" , decimal12_2(null) as "Amount" , decimal12_2(null) as "TaxAmount" , GoodData_date(null) as "PostDate" , GoodData_date(null) as "AdjustmentDate"     ;


--Transactions----------------Transactions----------------Transactions----------------Transactions----------------Transactions----------------Transactions----------------Transactions--
select distinct  GoodData_Attr(TransactionCode5) as "TransactionCode5",
GoodData_Attr(TransactionDistributionId) as "TransactionDistributionId",
GoodData_Attr(TransactionId) as "TransactionId",
 case when nvl(AccountId,'') = '' then '0' else cast(nvl(AccountId,'') as varchar(32))  end  as "AccountId",
 case when nvl(ProjectId,'') = '' then '0' else cast(nvl(ProjectId,'') as varchar(32))  end  as "ProjectId",
 case when nvl(GrantId,'') = '' then '0' else cast(nvl(GrantId,'') as varchar(32))  end  as "GrantId",
GoodData_Attr(TransactionNumber) as "TransactionNumber",
GoodData_Attr(PostStatus) as "PostStatus",
GoodData_Attr(PostStatusTranslation) as "PostStatusTranslation",
GoodData_date(PostDate)  as "PostDate",
 case when nvl(FiscalPeriodId,'') = '' then '0' else cast(nvl(FiscalPeriodId,'') as varchar(32))  end  as "FiscalPeriodId",
GoodData_Attr(TransactionType) as "TransactionType",
GoodData_Attr(TransactionTypeTranslation) as "TransactionTypeTranslation",
GoodData_Attr(Reference) as "Reference",
decimal12_2(TransactionDistributionAmount ) as "TransactionDistributionAmount",
GoodData_Attr(EncumbranceStatus) as "EncumbranceStatus",
GoodData_Attr(EncumbranceStatusTranslation) as "EncumbranceStatusTranslation",
GoodData_Attr(TransactionCode1) as "TransactionCode1",
GoodData_Attr(TransactionCode2) as "TransactionCode2",
GoodData_Attr(TransactionCode3) as "TransactionCode3",
GoodData_Attr(TransactionCode4) as "TransactionCode4" 
from Transactions where TransactionDistributionId <> ''   
 union 
select   GoodData_Attr('') as "TransactionCode5" , GoodData_Attr('') as "TransactionDistributionId" , GoodData_Attr('') as "TransactionId" , '0' as "AccountId" , '0' as "ProjectId" , '0' as "GrantId" , GoodData_Attr('') as "TransactionNumber" , GoodData_Attr('') as "PostStatus" , GoodData_Attr('') as "PostStatusTranslation" , GoodData_date(null) as "PostDate" , '0' as "FiscalPeriodId" , GoodData_Attr('') as "TransactionType" , GoodData_Attr('') as "TransactionTypeTranslation" , GoodData_Attr('') as "Reference" , decimal12_2(null) as "TransactionDistributionAmount" , GoodData_Attr('') as "EncumbranceStatus" , GoodData_Attr('') as "EncumbranceStatusTranslation" , GoodData_Attr('') as "TransactionCode1" , GoodData_Attr('') as "TransactionCode2" , GoodData_Attr('') as "TransactionCode3" , GoodData_Attr('') as "TransactionCode4"     ;


--ARCharges----------------ARCharges----------------ARCharges----------------ARCharges----------------ARCharges----------------ARCharges----------------ARCharges--
select distinct  GoodData_Attr(ChargeId) as "ChargeId",
 case when nvl(ClientId,'') = '' then '0' else cast(nvl(ClientId,'') as varchar(32))  end  as "ClientId",
GoodData_Attr(PayerClientId) as "PayerClientId",
GoodData_date(TransactionDate)  as "TransactionDate",
GoodData_date(DueDate)  as "DueDate",
decimal12_2(Balance ) as "Balance",
decimal12_2(ChargeAmount ) as "ChargeAmount",
decimal12_2(Quantity ) as "Quantity",
decimal12_2(UnitPrice ) as "UnitPrice",
decimal12_2(SaleTaxAmount ) as "SaleTaxAmount",
GoodData_Attr(TransactionType) as "TransactionType",
GoodData_Attr(TransactionTypeTranslation) as "TransactionTypeTranslation",
GoodData_Attr(TransactionUserId) as "TransactionUserId",
GoodData_Attr(InvoiceUserId) as "InvoiceUserId",
decimal12_2(OriginalTransactionAmount ) as "OriginalTransactionAmount",
GoodData_date(PostDate)  as "PostDate",
GoodData_Attr(PostStatus) as "PostStatus",
GoodData_Attr(PostStatusTranslation) as "PostStatusTranslation" 
from ARCharges where ChargeId <> ''   
 union 
select   GoodData_Attr('') as "ChargeId" , '0' as "ClientId" , GoodData_Attr('') as "PayerClientId" , GoodData_date(null) as "TransactionDate" , GoodData_date(null) as "DueDate" , decimal12_2(null) as "Balance" , decimal12_2(null) as "ChargeAmount" , decimal12_2(null) as "Quantity" , decimal12_2(null) as "UnitPrice" , decimal12_2(null) as "SaleTaxAmount" , GoodData_Attr('') as "TransactionType" , GoodData_Attr('') as "TransactionTypeTranslation" , GoodData_Attr('') as "TransactionUserId" , GoodData_Attr('') as "InvoiceUserId" , decimal12_2(null) as "OriginalTransactionAmount" , GoodData_date(null) as "PostDate" , GoodData_Attr('') as "PostStatus" , GoodData_Attr('') as "PostStatusTranslation"     ;


--InvoicePayments----------------InvoicePayments----------------InvoicePayments----------------InvoicePayments----------------InvoicePayments----------------InvoicePayments----------------InvoicePayments--
select distinct  GoodData_Attr(PaymentId) as "PaymentId",
 case when nvl(InvoiceId,'') = '' then '0' else cast(nvl(InvoiceId,'') as varchar(32))  end  as "InvoiceId",
GoodData_date(CheckDate)  as "CheckDate",
GoodData_date(PaymentDate)  as "PaymentDate",
GoodData_Attr(Status) as "Status",
GoodData_Attr(StatusTranslation) as "StatusTranslation",
GoodData_date(CheckReversePostDate)  as "CheckReversePostDate",
GoodData_date(CheckVoidedDate)  as "CheckVoidedDate",
decimal12_2(Amount ) as "Amount",
decimal12_2(DiscountAmount ) as "DiscountAmount" 
from InvoicePayments where PaymentId <> ''   
 union 
select   GoodData_Attr('') as "PaymentId" , '0' as "InvoiceId" , GoodData_date(null) as "CheckDate" , GoodData_date(null) as "PaymentDate" , GoodData_Attr('') as "Status" , GoodData_Attr('') as "StatusTranslation" , GoodData_date(null) as "CheckReversePostDate" , GoodData_date(null) as "CheckVoidedDate" , decimal12_2(null) as "Amount" , decimal12_2(null) as "DiscountAmount"     ;


--FiscalPeriods----------------FiscalPeriods----------------FiscalPeriods----------------FiscalPeriods----------------FiscalPeriods----------------FiscalPeriods----------------FiscalPeriods--
select distinct  GoodData_Attr(FiscalPeriodId) as "FiscalPeriodId",
 case when nvl(FiscalYearId,'') = '' then '0' else cast(nvl(FiscalYearId,'') as varchar(32))  end  as "FiscalYearId",
GoodData_Attr(Sequence) as "Sequence",
GoodData_date(StartDate)  as "StartDate",
GoodData_date(EndDate)  as "EndDate" 
from FiscalPeriods where FiscalPeriodId <> ''   
 union 
select   GoodData_Attr('') as "FiscalPeriodId" , '0' as "FiscalYearId" , GoodData_Attr('') as "Sequence" , GoodData_date(null) as "StartDate" , GoodData_date(null) as "EndDate"     ;


--ARPaymentDistribution----------------ARPaymentDistribution----------------ARPaymentDistribution----------------ARPaymentDistribution----------------ARPaymentDistribution----------------ARPaymentDistribution----------------ARPaymentDistribution--
select distinct  GoodData_Attr(PaymentDistributionId) as "PaymentDistributionId",
 case when nvl(PaymentId,'') = '' then '0' else cast(nvl(PaymentId,'') as varchar(32))  end  as "PaymentId",
 case when nvl(ClientId,'') = '' then '0' else cast(nvl(ClientId,'') as varchar(32))  end  as "ClientId",
GoodData_Attr(OwnerClientId) as "OwnerClientId",
decimal12_2(Amount ) as "Amount",
decimal12_2(PaymentBalance ) as "PaymentBalance" 
from ARPaymentDistribution where PaymentDistributionId <> ''   
 union 
select   GoodData_Attr('') as "PaymentDistributionId" , '0' as "PaymentId" , '0' as "ClientId" , GoodData_Attr('') as "OwnerClientId" , decimal12_2(null) as "Amount" , decimal12_2(null) as "PaymentBalance"     ;


--Projects----------------Projects----------------Projects----------------Projects----------------Projects----------------Projects----------------Projects--
select distinct  GoodData_Attr(ProjectId) as "ProjectId",
GoodData_Attr(UserId) as "UserId",
GoodData_Attr(Description) as "Description",
GoodData_Attr(Division) as "Division",
GoodData_Attr(Location) as "Location",
GoodData_Attr(Department) as "Department" 
from Projects where ProjectId <> ''   
 union 
select   GoodData_Attr('') as "ProjectId" , GoodData_Attr('') as "UserId" , GoodData_Attr('') as "Description" , GoodData_Attr('') as "Division" , GoodData_Attr('') as "Location" , GoodData_Attr('') as "Department"     ;


--InvoiceDebitDistributions----------------InvoiceDebitDistributions----------------InvoiceDebitDistributions----------------InvoiceDebitDistributions----------------InvoiceDebitDistributions----------------InvoiceDebitDistributions----------------InvoiceDebitDistributions--
select distinct   case when nvl(TransactionDistributionId,'') = '' then '0' else cast(nvl(TransactionDistributionId,'') as varchar(32))  end  as "TransactionDistributionId",
GoodData_Attr(InvoiceTranDebitDistributionId) as "InvoiceTranDebitDistributionId",
GoodData_Attr(InvoiceDebitDistributionId) as "InvoiceDebitDistributionId",
 case when nvl(InvoiceId,'') = '' then '0' else cast(nvl(InvoiceId,'') as varchar(32))  end  as "InvoiceId",
 case when nvl(AccountId,'') = '' then '0' else cast(nvl(AccountId,'') as varchar(32))  end  as "AccountId",
decimal12_2(TransactionDistributionAmount ) as "TransactionDistributionAmount",
 case when nvl(ProjectId,'') = '' then '0' else cast(nvl(ProjectId,'') as varchar(32))  end  as "ProjectId" 
from InvoiceDebitDistributions where InvoiceTranDebitDistributionId <> ''   
 union 
select   '0' as "TransactionDistributionId" , GoodData_Attr('') as "InvoiceTranDebitDistributionId" , GoodData_Attr('') as "InvoiceDebitDistributionId" , '0' as "InvoiceId" , '0' as "AccountId" , decimal12_2(null) as "TransactionDistributionAmount" , '0' as "ProjectId"     ;


--ARPayments----------------ARPayments----------------ARPayments----------------ARPayments----------------ARPayments----------------ARPayments----------------ARPayments--
select distinct   case when nvl(ClientId,'') = '' then '0' else cast(nvl(ClientId,'') as varchar(32))  end  as "ClientId",
decimal12_2(Amount ) as "Amount",
GoodData_date(PaymentDate)  as "PaymentDate",
GoodData_Attr(PaymentUserId) as "PaymentUserId",
GoodData_date(PostDate)  as "PostDate",
GoodData_Attr(PostStatus) as "PostStatus",
GoodData_Attr(PostStatusTranslation) as "PostStatusTranslation",
GoodData_Attr(PaymentId) as "PaymentId",
GoodData_Attr(PaymentHeaderId) as "PaymentHeaderId" 
from ARPayments where PaymentId <> ''   
 union 
select   '0' as "ClientId" , decimal12_2(null) as "Amount" , GoodData_date(null) as "PaymentDate" , GoodData_Attr('') as "PaymentUserId" , GoodData_date(null) as "PostDate" , GoodData_Attr('') as "PostStatus" , GoodData_Attr('') as "PostStatusTranslation" , GoodData_Attr('') as "PaymentId" , GoodData_Attr('') as "PaymentHeaderId"     ;


--ARDistributions----------------ARDistributions----------------ARDistributions----------------ARDistributions----------------ARDistributions----------------ARDistributions----------------ARDistributions--
select distinct  GoodData_Attr(TransactionDistributionId) as "TransactionDistributionId",
GoodData_Attr(ParentId) as "ParentId",
GoodData_Attr(ParentType) as "ParentType",
 case when nvl(AccountId,'') = '' then '0' else cast(nvl(AccountId,'') as varchar(32))  end  as "AccountId",
decimal12_2(TransactionDistributionAmount ) as "TransactionDistributionAmount",
 case when nvl(ProjectId,'') = '' then '0' else cast(nvl(ProjectId,'') as varchar(32))  end  as "ProjectId",
 case when nvl(GrantId,'') = '' then '0' else cast(nvl(GrantId,'') as varchar(32))  end  as "GrantId",
GoodData_Attr(TransactionType) as "TransactionType",
GoodData_Attr(TransactionTypeTranslation) as "TransactionTypeTranslation" 
from ARDistributions where TransactionDistributionId <> ''   
 union 
select   GoodData_Attr('') as "TransactionDistributionId" , GoodData_Attr('') as "ParentId" , GoodData_Attr('') as "ParentType" , '0' as "AccountId" , decimal12_2(null) as "TransactionDistributionAmount" , '0' as "ProjectId" , '0' as "GrantId" , GoodData_Attr('') as "TransactionType" , GoodData_Attr('') as "TransactionTypeTranslation"     ;


--Banks----------------Banks----------------Banks----------------Banks----------------Banks----------------Banks----------------Banks--
select distinct  GoodData_Attr(Name) as "Name",
GoodData_Attr(AccountNumber) as "AccountNumber",
GoodData_Attr(AccountType) as "AccountType",
GoodData_Attr(AccountTypeTranslation) as "AccountTypeTranslation",
GoodData_Attr(BankId) as "BankId" 
from Banks where BankId <> ''   
 union 
select   GoodData_Attr('') as "Name" , GoodData_Attr('') as "AccountNumber" , GoodData_Attr('') as "AccountType" , GoodData_Attr('') as "AccountTypeTranslation" , GoodData_Attr('') as "BankId"     ;


--InvoiceCreditMemoApplication----------------InvoiceCreditMemoApplication----------------InvoiceCreditMemoApplication----------------InvoiceCreditMemoApplication----------------InvoiceCreditMemoApplication----------------InvoiceCreditMemoApplication----------------InvoiceCreditMemoApplication--
select distinct  GoodData_Attr(CreditMemoApplicationId) as "CreditMemoApplicationId",
 case when nvl(InvoiceId,'') = '' then '0' else cast(nvl(InvoiceId,'') as varchar(32))  end  as "InvoiceId",
GoodData_Attr(CheckVoided) as "CheckVoided",
GoodData_Attr(Status) as "Status",
GoodData_Attr(StatusTranslation) as "StatusTranslation",
decimal12_2(Amount ) as "Amount",
GoodData_date(CreditMemoPostDate)  as "CreditMemoPostDate",
GoodData_date(CreditMemoDate)  as "CreditMemoDate" 
from InvoiceCreditMemoApplication where CreditMemoApplicationId <> ''   
 union 
select   GoodData_Attr('') as "CreditMemoApplicationId" , '0' as "InvoiceId" , GoodData_Attr('') as "CheckVoided" , GoodData_Attr('') as "Status" , GoodData_Attr('') as "StatusTranslation" , decimal12_2(null) as "Amount" , GoodData_date(null) as "CreditMemoPostDate" , GoodData_date(null) as "CreditMemoDate"     ;


--PurchaseOrders----------------PurchaseOrders----------------PurchaseOrders----------------PurchaseOrders----------------PurchaseOrders----------------PurchaseOrders----------------PurchaseOrders--
select distinct  GoodData_Attr(Comment) as "Comment",
GoodData_Attr(PurchaseOrderId) as "PurchaseOrderId",
 case when nvl(VendorId,'') = '' then '0' else cast(nvl(VendorId,'') as varchar(32))  end  as "VendorId",
GoodData_Attr(Number) as "Number",
decimal12_2(TotalAmount ) as "TotalAmount" 
from PurchaseOrders where PurchaseOrderId <> ''   
 union 
select   GoodData_Attr('') as "Comment" , GoodData_Attr('') as "PurchaseOrderId" , '0' as "VendorId" , GoodData_Attr('') as "Number" , decimal12_2(null) as "TotalAmount"     ;


--FiscalYears----------------FiscalYears----------------FiscalYears----------------FiscalYears----------------FiscalYears----------------FiscalYears----------------FiscalYears--
select distinct  GoodData_Attr(FiscalYearId) as "FiscalYearId",
GoodData_Attr(Name) as "Name",
GoodData_Attr(NumberOfPeriods) as "NumberOfPeriods",
GoodData_date(StartDate)  as "StartDate",
GoodData_date(EndDate)  as "EndDate" 
from FiscalYears where FiscalYearId <> ''   
 union 
select   GoodData_Attr('') as "FiscalYearId" , GoodData_Attr('') as "Name" , GoodData_Attr('') as "NumberOfPeriods" , GoodData_date(null) as "StartDate" , GoodData_date(null) as "EndDate"     ;


--Invoices----------------Invoices----------------Invoices----------------Invoices----------------Invoices----------------Invoices----------------Invoices--
select distinct  GoodData_Attr(PostStatusTranslation) as "PostStatusTranslation",
 case when nvl(PurchaseOrderId,'') = '' then '0' else cast(nvl(PurchaseOrderId,'') as varchar(32))  end  as "PurchaseOrderId",
GoodData_Attr(InvoiceId) as "InvoiceId",
 case when nvl(VendorId,'') = '' then '0' else cast(nvl(VendorId,'') as varchar(32))  end  as "VendorId",
 case when nvl(BankId,'') = '' then '0' else cast(nvl(BankId,'') as varchar(32))  end  as "BankId",
GoodData_Attr(InvoiceNumber) as "InvoiceNumber",
GoodData_Attr(Description) as "Description",
decimal12_2(Amount ) as "Amount",
decimal12_2(Balance ) as "Balance",
decimal12_2(TaxAmount ) as "TaxAmount",
GoodData_date(Date)  as "Date",
GoodData_date(DueDate)  as "DueDate",
GoodData_Attr(Status) as "Status",
GoodData_Attr(StatusTranslation) as "StatusTranslation",
decimal12_2(DiscountAmount ) as "DiscountAmount",
GoodData_date(PostDate)  as "PostDate",
GoodData_Attr(PostStatus) as "PostStatus" 
from Invoices where InvoiceId <> ''   
 union 
select   GoodData_Attr('') as "PostStatusTranslation" , '0' as "PurchaseOrderId" , GoodData_Attr('') as "InvoiceId" , '0' as "VendorId" , '0' as "BankId" , GoodData_Attr('') as "InvoiceNumber" , GoodData_Attr('') as "Description" , decimal12_2(null) as "Amount" , decimal12_2(null) as "Balance" , decimal12_2(null) as "TaxAmount" , GoodData_date(null) as "Date" , GoodData_date(null) as "DueDate" , GoodData_Attr('') as "Status" , GoodData_Attr('') as "StatusTranslation" , decimal12_2(null) as "DiscountAmount" , GoodData_date(null) as "PostDate" , GoodData_Attr('') as "PostStatus"     ;


--Grants----------------Grants----------------Grants----------------Grants----------------Grants----------------Grants----------------Grants--
select distinct  GoodData_Attr(GrantId) as "GrantId",
GoodData_Attr(UserId) as "UserId",
GoodData_Attr(Description) as "Description",
decimal12_2(Amount ) as "Amount" 
from Grants where GrantId <> ''   
 union 
select   GoodData_Attr('') as "GrantId" , GoodData_Attr('') as "UserId" , GoodData_Attr('') as "Description" , decimal12_2(null) as "Amount"     ;


--Accounts----------------Accounts----------------Accounts----------------Accounts----------------Accounts----------------Accounts----------------Accounts--
select distinct  GoodData_Attr(AccountId) as "AccountId",
GoodData_Attr(AccountNumber) as "AccountNumber",
GoodData_Attr(AccountDescription) as "AccountDescription",
GoodData_Attr(AccountCategory) as "AccountCategory",
GoodData_Attr(AccountCategoryTranslation) as "AccountCategoryTranslation",
GoodData_Attr(FundName) as "FundName",
GoodData_Attr(FundDescription) as "FundDescription",
GoodData_Attr(Class) as "Class",
GoodData_Attr(Status) as "Status",
GoodData_Attr(StatusTranslation) as "StatusTranslation",
GoodData_Attr(AccountCode) as "AccountCode",
GoodData_Attr(AccountCodeDescription) as "AccountCodeDescription" 
from Accounts where AccountId <> ''   
 union 
select   GoodData_Attr('') as "AccountId" , GoodData_Attr('') as "AccountNumber" , GoodData_Attr('') as "AccountDescription" , GoodData_Attr('') as "AccountCategory" , GoodData_Attr('') as "AccountCategoryTranslation" , GoodData_Attr('') as "FundName" , GoodData_Attr('') as "FundDescription" , GoodData_Attr('') as "Class" , GoodData_Attr('') as "Status" , GoodData_Attr('') as "StatusTranslation" , GoodData_Attr('') as "AccountCode" , GoodData_Attr('') as "AccountCodeDescription"     ;


--ProjectBudgets----------------ProjectBudgets----------------ProjectBudgets----------------ProjectBudgets----------------ProjectBudgets----------------ProjectBudgets----------------ProjectBudgets--
select distinct  GoodData_Attr(ProjectBudgetId) as "ProjectBudgetId",
 case when nvl(AccountBudgetId,'') = '' then '0' else cast(nvl(AccountBudgetId,'') as varchar(32))  end  as "AccountBudgetId",
 case when nvl(ProjectId,'') = '' then '0' else cast(nvl(ProjectId,'') as varchar(32))  end  as "ProjectId",
 case when nvl(AccountId,'') = '' then '0' else cast(nvl(AccountId,'') as varchar(32))  end  as "AccountId",
decimal12_2(Amount ) as "Amount",
 case when nvl(FiscalPeriodId,'') = '' then '0' else cast(nvl(FiscalPeriodId,'') as varchar(32))  end  as "FiscalPeriodId",
decimal12_2(PeriodAmount ) as "PeriodAmount" 
from ProjectBudgets where ProjectBudgetId <> ''   
 union 
select   GoodData_Attr('') as "ProjectBudgetId" , '0' as "AccountBudgetId" , '0' as "ProjectId" , '0' as "AccountId" , decimal12_2(null) as "Amount" , '0' as "FiscalPeriodId" , decimal12_2(null) as "PeriodAmount"     ;


