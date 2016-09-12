--Sat Feb  6 18:12:14 2016, Extracted SQL from: "/Users/vasek/Documents/workspace/BBFE_DEV10/graph/DATAMARTS_Create_template.grf" 
--DATAMARTS_CREATE_template----------------DATAMARTS_CREATE_template----------------DATAMARTS_CREATE_template----------------DATAMARTS_CREATE_template----------------DATAMARTS_CREATE_template----------------DATAMARTS_CREATE_template----------------DATAMARTS_CREATE_template--
CREATE OR REPLACE FUNCTION GoodData_date(d DATE)
                    RETURN DATE AS
                    BEGIN
                        RETURN (CAST(
                            CASE
                            WHEN d < '1900-01-01' THEN
                                '1900-01-01'
                            WHEN d > '2050-01-01' THEN
                                '2050-01-01'
                            ELSE
                                d
                            END AS DATE)) #
                END#
                            
                
                CREATE OR REPLACE FUNCTION decimal12_2(d numeric)
                    RETURN numeric AS
                    BEGIN
                        RETURN CAST( d AS decimal(12,2)) #
                END#
                
                CREATE OR REPLACE FUNCTION decimal15_3(d numeric)
                    RETURN numeric AS
                    BEGIN
                        RETURN CAST( d AS decimal(15,3)) #
                END#
                
                       CREATE OR REPLACE FUNCTION GoodData_Attr(d VARCHAR(256))
                    RETURN VARCHAR(128) AS
                    BEGIN
                        RETURN (CAST(
                            CASE
                            WHEN d is null THEN
                                ''
                            ELSE
                                d 
                            END AS VARCHAR(128))) ;
                END;
                
                
                CREATE OR REPLACE FUNCTION GoodData_Attr(d datetime)
                    RETURN VARCHAR(128) AS
                    BEGIN
                        RETURN (CAST(
                            CASE
                            WHEN d is null THEN
                                ''::varchar
                            ELSE
                                d::varchar
                            END AS VARCHAR(128))) ;
                END#
                
                
                CREATE OR REPLACE FUNCTION GoodData_Attr(d int)
                    RETURN VARCHAR(128) AS
                    BEGIN
                        RETURN (CAST(
                            CASE
                            WHEN d is null THEN
                                ''::varchar
                            ELSE
                                d::varchar
                            END AS VARCHAR(128))) ;
                END#
                
                CREATE OR REPLACE FUNCTION GoodData_Attr(d VARCHAR(256))
                    RETURN VARCHAR(128) AS
                    BEGIN
                        RETURN (CAST(
                            CASE
                            WHEN d is null THEN
                                ''
                            ELSE
                                d 
                            END AS VARCHAR(128))) #
                END#
                
                
                CREATE OR REPLACE FUNCTION Bool_to_YesNo(b VARCHAR)
                    RETURN VARCHAR AS
                    BEGIN
                        RETURN (CAST(
                            CASE
                            WHEN b = 'true' THEN
                                'Yes'
                            WHEN b = 'false' THEN
                                'No'
                            ELSE
                                b
                            END AS VARCHAR )) #
                END#
                
                CREATE OR REPLACE FUNCTION Gooddata_ref(b VARCHAR)
                    RETURN VARCHAR AS
                    BEGIN
                        RETURN (CAST(
                            case when nvl(b,'') = '' then '0' else  b end  
                             AS VARCHAR )) #
                END#
                
                CREATE OR REPLACE FUNCTION Gooddata_ref(b int)
                    RETURN int AS
                    BEGIN
                        RETURN (
                           case when b is null  then 0::int else  b::int end  
                            ) #
                END#
                
                
                
                
                
--1. ARCredits: fields: 10
drop table if exists ARCredits cascade#
 create table ARCredits("extracted_on" timestamptz DEFAULT current_timestamp,
"CreditId" integer,
"ClientId" integer,
"TransactionDate" date,
"CreditUserId" integer,
"CreditAmount" numeric,
"TransactionType" integer,
"TransactionTypeTranslation" Varchar(128),
"PostDate" date,
"PostStatus" integer,
"PostStatusTranslation" Varchar(128))  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_ARCredits (extracted_on,"CreditId","ClientId","TransactionDate","CreditUserId","CreditAmount","TransactionType","TransactionTypeTranslation","PostDate","PostStatus","PostStatusTranslation") AS
                                        (
                                            SELECT
                                                extracted_on,"CreditId","ClientId","TransactionDate","CreditUserId","CreditAmount","TransactionType","TransactionTypeTranslation","PostDate","PostStatus","PostStatusTranslation"
                                            FROM
                                                ARCredits
                                            ORDER BY
                                                
                                                "CreditId") SEGMENTED BY   hash("CreditId") all Nodes KSAFE 1 #
--2. Vendors: fields: 6
drop table if exists Vendors cascade#
 create table Vendors("extracted_on" timestamptz DEFAULT current_timestamp,
"VendorId" integer,
"VendorName" Varchar(128),
"Is1099" integer,
"CustomerNumber" Varchar(128),
"Status" integer,
"StatusTranslation" Varchar(128))  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_Vendors (extracted_on,"VendorId","VendorName","Is1099","CustomerNumber","Status","StatusTranslation") AS
                                        (
                                            SELECT
                                                extracted_on,"VendorId","VendorName","Is1099","CustomerNumber","Status","StatusTranslation"
                                            FROM
                                                Vendors
                                            ORDER BY
                                                
                                                "VendorId") SEGMENTED BY   hash("VendorId") all Nodes KSAFE 1 #
--3. ARClients: fields: 5
drop table if exists ARClients cascade#
 create table ARClients("extracted_on" timestamptz DEFAULT current_timestamp,
"ClientId" integer,
"RecordType" integer,
"RecordTypeTranslation" Varchar(128),
"Name" Varchar(128),
"UserId" Varchar(128))  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_ARClients (extracted_on,"ClientId","RecordType","RecordTypeTranslation","Name","UserId") AS
                                        (
                                            SELECT
                                                extracted_on,"ClientId","RecordType","RecordTypeTranslation","Name","UserId"
                                            FROM
                                                ARClients
                                            ORDER BY
                                                
                                                "ClientId") SEGMENTED BY   hash("ClientId") all Nodes KSAFE 1 #
--4. AccountBudgets: fields: 5
drop table if exists AccountBudgets cascade#
 create table AccountBudgets("extracted_on" timestamptz DEFAULT current_timestamp,
"AccountBudgetId" integer,
"Amount" numeric,
"ScenarioId" Varchar(128),
"AccountId" integer,
"FiscalYearId" integer)  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_AccountBudgets (extracted_on,"AccountBudgetId","Amount","ScenarioId","AccountId","FiscalYearId") AS
                                        (
                                            SELECT
                                                extracted_on,"AccountBudgetId","Amount","ScenarioId","AccountId","FiscalYearId"
                                            FROM
                                                AccountBudgets
                                            ORDER BY
                                                
                                                "AccountBudgetId") SEGMENTED BY   hash("AccountBudgetId") all Nodes KSAFE 1 #
--5. InvoiceAdjustments: fields: 6
drop table if exists InvoiceAdjustments cascade#
 create table InvoiceAdjustments("extracted_on" timestamptz DEFAULT current_timestamp,
"AdjustmentId" integer,
"InvoiceId" integer,
"Amount" numeric,
"TaxAmount" numeric,
"PostDate" date,
"AdjustmentDate" date)  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_InvoiceAdjustments (extracted_on,"AdjustmentId","InvoiceId","Amount","TaxAmount","PostDate","AdjustmentDate") AS
                                        (
                                            SELECT
                                                extracted_on,"AdjustmentId","InvoiceId","Amount","TaxAmount","PostDate","AdjustmentDate"
                                            FROM
                                                InvoiceAdjustments
                                            ORDER BY
                                                
                                                "AdjustmentId") SEGMENTED BY   hash("AdjustmentId") all Nodes KSAFE 1 #
--6. Transactions: fields: 21
drop table if exists Transactions cascade#
 create table Transactions("extracted_on" timestamptz DEFAULT current_timestamp,
"TransactionCode5" Varchar(128),
"TransactionDistributionId" integer,
"TransactionId" integer,
"AccountId" integer,
"ProjectId" integer,
"GrantId" integer,
"TransactionNumber" Varchar(128),
"PostStatus" integer,
"PostStatusTranslation" Varchar(128),
"PostDate" date,
"FiscalPeriodId" integer,
"TransactionType" integer,
"TransactionTypeTranslation" Varchar(128),
"Reference" Varchar(128),
"TransactionDistributionAmount" numeric,
"EncumbranceStatus" integer,
"EncumbranceStatusTranslation" Varchar(128),
"TransactionCode1" Varchar(128),
"TransactionCode2" Varchar(128),
"TransactionCode3" Varchar(128),
"TransactionCode4" Varchar(128))  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_Transactions (extracted_on,"TransactionCode5","TransactionDistributionId","TransactionId","AccountId","ProjectId","GrantId","TransactionNumber","PostStatus","PostStatusTranslation","PostDate","FiscalPeriodId","TransactionType","TransactionTypeTranslation","Reference","TransactionDistributionAmount","EncumbranceStatus","EncumbranceStatusTranslation","TransactionCode1","TransactionCode2","TransactionCode3","TransactionCode4") AS
                                        (
                                            SELECT
                                                extracted_on,"TransactionCode5","TransactionDistributionId","TransactionId","AccountId","ProjectId","GrantId","TransactionNumber","PostStatus","PostStatusTranslation","PostDate","FiscalPeriodId","TransactionType","TransactionTypeTranslation","Reference","TransactionDistributionAmount","EncumbranceStatus","EncumbranceStatusTranslation","TransactionCode1","TransactionCode2","TransactionCode3","TransactionCode4"
                                            FROM
                                                Transactions
                                            ORDER BY
                                                
                                                "TransactionDistributionId") SEGMENTED BY   hash("TransactionDistributionId") all Nodes KSAFE 1 #
--7. ARCharges: fields: 18
drop table if exists ARCharges cascade#
 create table ARCharges("extracted_on" timestamptz DEFAULT current_timestamp,
"ChargeId" integer,
"ClientId" integer,
"PayerClientId" integer,
"TransactionDate" date,
"DueDate" date,
"Balance" numeric,
"ChargeAmount" numeric,
"Quantity" integer,
"UnitPrice" numeric,
"SaleTaxAmount" numeric,
"TransactionType" integer,
"TransactionTypeTranslation" Varchar(128),
"TransactionUserId" integer,
"InvoiceUserId" integer,
"OriginalTransactionAmount" numeric,
"PostDate" date,
"PostStatus" integer,
"PostStatusTranslation" Varchar(128))  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_ARCharges (extracted_on,"ChargeId","ClientId","PayerClientId","TransactionDate","DueDate","Balance","ChargeAmount","Quantity","UnitPrice","SaleTaxAmount","TransactionType","TransactionTypeTranslation","TransactionUserId","InvoiceUserId","OriginalTransactionAmount","PostDate","PostStatus","PostStatusTranslation") AS
                                        (
                                            SELECT
                                                extracted_on,"ChargeId","ClientId","PayerClientId","TransactionDate","DueDate","Balance","ChargeAmount","Quantity","UnitPrice","SaleTaxAmount","TransactionType","TransactionTypeTranslation","TransactionUserId","InvoiceUserId","OriginalTransactionAmount","PostDate","PostStatus","PostStatusTranslation"
                                            FROM
                                                ARCharges
                                            ORDER BY
                                                
                                                "ChargeId") SEGMENTED BY   hash("ChargeId") all Nodes KSAFE 1 #
--8. InvoicePayments: fields: 10
drop table if exists InvoicePayments cascade#
 create table InvoicePayments("extracted_on" timestamptz DEFAULT current_timestamp,
"PaymentId" integer,
"InvoiceId" integer,
"CheckDate" date,
"PaymentDate" date,
"Status" integer,
"StatusTranslation" Varchar(128),
"CheckReversePostDate" date,
"CheckVoidedDate" date,
"Amount" numeric,
"DiscountAmount" numeric)  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_InvoicePayments (extracted_on,"PaymentId","InvoiceId","CheckDate","PaymentDate","Status","StatusTranslation","CheckReversePostDate","CheckVoidedDate","Amount","DiscountAmount") AS
                                        (
                                            SELECT
                                                extracted_on,"PaymentId","InvoiceId","CheckDate","PaymentDate","Status","StatusTranslation","CheckReversePostDate","CheckVoidedDate","Amount","DiscountAmount"
                                            FROM
                                                InvoicePayments
                                            ORDER BY
                                                
                                                "PaymentId") SEGMENTED BY   hash("PaymentId") all Nodes KSAFE 1 #
--9. FiscalPeriods: fields: 5
drop table if exists FiscalPeriods cascade#
 create table FiscalPeriods("extracted_on" timestamptz DEFAULT current_timestamp,
"FiscalPeriodId" integer,
"FiscalYearId" integer,
"Sequence" integer,
"StartDate" date,
"EndDate" date)  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_FiscalPeriods (extracted_on,"FiscalPeriodId","FiscalYearId","Sequence","StartDate","EndDate") AS
                                        (
                                            SELECT
                                                extracted_on,"FiscalPeriodId","FiscalYearId","Sequence","StartDate","EndDate"
                                            FROM
                                                FiscalPeriods
                                            ORDER BY
                                                
                                                "FiscalPeriodId") SEGMENTED BY   hash("FiscalPeriodId") all Nodes KSAFE 1 #
--10. ARPaymentDistribution: fields: 6
drop table if exists ARPaymentDistribution cascade#
 create table ARPaymentDistribution("extracted_on" timestamptz DEFAULT current_timestamp,
"PaymentDistributionId" integer,
"PaymentId" integer,
"ClientId" integer,
"OwnerClientId" integer,
"Amount" numeric,
"PaymentBalance" numeric)  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_ARPaymentDistribution (extracted_on,"PaymentDistributionId","PaymentId","ClientId","OwnerClientId","Amount","PaymentBalance") AS
                                        (
                                            SELECT
                                                extracted_on,"PaymentDistributionId","PaymentId","ClientId","OwnerClientId","Amount","PaymentBalance"
                                            FROM
                                                ARPaymentDistribution
                                            ORDER BY
                                                
                                                "PaymentDistributionId") SEGMENTED BY   hash("PaymentDistributionId") all Nodes KSAFE 1 #
--11. Projects: fields: 6
drop table if exists Projects cascade#
 create table Projects("extracted_on" timestamptz DEFAULT current_timestamp,
"ProjectId" integer,
"UserId" Varchar(128),
"Description" Varchar(128),
"Division" Varchar(128),
"Location" Varchar(128),
"Department" Varchar(128))  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_Projects (extracted_on,"ProjectId","UserId","Description","Division","Location","Department") AS
                                        (
                                            SELECT
                                                extracted_on,"ProjectId","UserId","Description","Division","Location","Department"
                                            FROM
                                                Projects
                                            ORDER BY
                                                
                                                "ProjectId") SEGMENTED BY   hash("ProjectId") all Nodes KSAFE 1 #
--12. InvoiceDebitDistributions: fields: 7
drop table if exists InvoiceDebitDistributions cascade#
 create table InvoiceDebitDistributions("extracted_on" timestamptz DEFAULT current_timestamp,
"TransactionDistributionId" integer,
"InvoiceTranDebitDistributionId" integer,
"InvoiceDebitDistributionId" integer,
"InvoiceId" integer,
"AccountId" integer,
"TransactionDistributionAmount" numeric,
"ProjectId" integer)  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_InvoiceDebitDistributions (extracted_on,"TransactionDistributionId","InvoiceTranDebitDistributionId","InvoiceDebitDistributionId","InvoiceId","AccountId","TransactionDistributionAmount","ProjectId") AS
                                        (
                                            SELECT
                                                extracted_on,"TransactionDistributionId","InvoiceTranDebitDistributionId","InvoiceDebitDistributionId","InvoiceId","AccountId","TransactionDistributionAmount","ProjectId"
                                            FROM
                                                InvoiceDebitDistributions
                                            ORDER BY
                                                
                                                "InvoiceTranDebitDistributionId") SEGMENTED BY   hash("InvoiceTranDebitDistributionId") all Nodes KSAFE 1 #
--13. ARPayments: fields: 9
drop table if exists ARPayments cascade#
 create table ARPayments("extracted_on" timestamptz DEFAULT current_timestamp,
"ClientId" integer,
"Amount" numeric,
"PaymentDate" date,
"PaymentUserId" integer,
"PostDate" date,
"PostStatus" integer,
"PostStatusTranslation" Varchar(128),
"PaymentId" integer,
"PaymentHeaderId" integer)  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_ARPayments (extracted_on,"ClientId","Amount","PaymentDate","PaymentUserId","PostDate","PostStatus","PostStatusTranslation","PaymentId","PaymentHeaderId") AS
                                        (
                                            SELECT
                                                extracted_on,"ClientId","Amount","PaymentDate","PaymentUserId","PostDate","PostStatus","PostStatusTranslation","PaymentId","PaymentHeaderId"
                                            FROM
                                                ARPayments
                                            ORDER BY
                                                
                                                "PaymentId") SEGMENTED BY   hash("PaymentId") all Nodes KSAFE 1 #
--14. ARDistributions: fields: 9
drop table if exists ARDistributions cascade#
 create table ARDistributions("extracted_on" timestamptz DEFAULT current_timestamp,
"TransactionDistributionId" integer,
"ParentId" integer,
"ParentType" integer,
"AccountId" integer,
"TransactionDistributionAmount" numeric,
"ProjectId" integer,
"GrantId" integer,
"TransactionType" integer,
"TransactionTypeTranslation" Varchar(128))  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_ARDistributions (extracted_on,"TransactionDistributionId","ParentId","ParentType","AccountId","TransactionDistributionAmount","ProjectId","GrantId","TransactionType","TransactionTypeTranslation") AS
                                        (
                                            SELECT
                                                extracted_on,"TransactionDistributionId","ParentId","ParentType","AccountId","TransactionDistributionAmount","ProjectId","GrantId","TransactionType","TransactionTypeTranslation"
                                            FROM
                                                ARDistributions
                                            ORDER BY
                                                
                                                "TransactionDistributionId") SEGMENTED BY   hash("TransactionDistributionId") all Nodes KSAFE 1 #
--15. Banks: fields: 5
drop table if exists Banks cascade#
 create table Banks("extracted_on" timestamptz DEFAULT current_timestamp,
"Name" Varchar(128),
"AccountNumber" Varchar(128),
"AccountType" integer,
"AccountTypeTranslation" Varchar(128),
"BankId" integer)  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_Banks (extracted_on,"Name","AccountNumber","AccountType","AccountTypeTranslation","BankId") AS
                                        (
                                            SELECT
                                                extracted_on,"Name","AccountNumber","AccountType","AccountTypeTranslation","BankId"
                                            FROM
                                                Banks
                                            ORDER BY
                                                
                                                "BankId") SEGMENTED BY   hash("BankId") all Nodes KSAFE 1 #
--16. InvoiceCreditMemoApplication: fields: 8
drop table if exists InvoiceCreditMemoApplication cascade#
 create table InvoiceCreditMemoApplication("extracted_on" timestamptz DEFAULT current_timestamp,
"CreditMemoApplicationId" integer,
"InvoiceId" integer,
"CheckVoided" integer,
"Status" integer,
"StatusTranslation" Varchar(128),
"Amount" numeric,
"CreditMemoPostDate" date,
"CreditMemoDate" date)  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_InvoiceCreditMemoApplication (extracted_on,"CreditMemoApplicationId","InvoiceId","CheckVoided","Status","StatusTranslation","Amount","CreditMemoPostDate","CreditMemoDate") AS
                                        (
                                            SELECT
                                                extracted_on,"CreditMemoApplicationId","InvoiceId","CheckVoided","Status","StatusTranslation","Amount","CreditMemoPostDate","CreditMemoDate"
                                            FROM
                                                InvoiceCreditMemoApplication
                                            ORDER BY
                                                
                                                "CreditMemoApplicationId") SEGMENTED BY   hash("CreditMemoApplicationId") all Nodes KSAFE 1 #
--17. PurchaseOrders: fields: 5
drop table if exists PurchaseOrders cascade#
 create table PurchaseOrders("extracted_on" timestamptz DEFAULT current_timestamp,
"Comment" Varchar(128),
"PurchaseOrderId" integer,
"VendorId" integer,
"Number" numeric,
"TotalAmount" numeric)  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_PurchaseOrders (extracted_on,"Comment","PurchaseOrderId","VendorId","Number","TotalAmount") AS
                                        (
                                            SELECT
                                                extracted_on,"Comment","PurchaseOrderId","VendorId","Number","TotalAmount"
                                            FROM
                                                PurchaseOrders
                                            ORDER BY
                                                
                                                "PurchaseOrderId") SEGMENTED BY   hash("PurchaseOrderId") all Nodes KSAFE 1 #
--18. FiscalYears: fields: 5
drop table if exists FiscalYears cascade#
 create table FiscalYears("extracted_on" timestamptz DEFAULT current_timestamp,
"FiscalYearId" integer,
"Name" Varchar(128),
"NumberOfPeriods" integer,
"StartDate" date,
"EndDate" date)  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_FiscalYears (extracted_on,"FiscalYearId","Name","NumberOfPeriods","StartDate","EndDate") AS
                                        (
                                            SELECT
                                                extracted_on,"FiscalYearId","Name","NumberOfPeriods","StartDate","EndDate"
                                            FROM
                                                FiscalYears
                                            ORDER BY
                                                
                                                "FiscalYearId") SEGMENTED BY   hash("FiscalYearId") all Nodes KSAFE 1 #
--19. Invoices: fields: 17
drop table if exists Invoices cascade#
 create table Invoices("extracted_on" timestamptz DEFAULT current_timestamp,
"PostStatusTranslation" Varchar(128),
"PurchaseOrderId" integer,
"InvoiceId" integer,
"VendorId" integer,
"BankId" integer,
"InvoiceNumber" Varchar(128),
"Description" Varchar(128),
"Amount" numeric,
"Balance" numeric,
"TaxAmount" numeric,
"Date" date,
"DueDate" date,
"Status" integer,
"StatusTranslation" Varchar(128),
"DiscountAmount" numeric,
"PostDate" date,
"PostStatus" integer)  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_Invoices (extracted_on,"PostStatusTranslation","PurchaseOrderId","InvoiceId","VendorId","BankId","InvoiceNumber","Description","Amount","Balance","TaxAmount","Date","DueDate","Status","StatusTranslation","DiscountAmount","PostDate","PostStatus") AS
                                        (
                                            SELECT
                                                extracted_on,"PostStatusTranslation","PurchaseOrderId","InvoiceId","VendorId","BankId","InvoiceNumber","Description","Amount","Balance","TaxAmount","Date","DueDate","Status","StatusTranslation","DiscountAmount","PostDate","PostStatus"
                                            FROM
                                                Invoices
                                            ORDER BY
                                                
                                                "InvoiceId") SEGMENTED BY   hash("InvoiceId") all Nodes KSAFE 1 #
--20. Grants: fields: 4
drop table if exists Grants cascade#
 create table Grants("extracted_on" timestamptz DEFAULT current_timestamp,
"GrantId" integer,
"UserId" Varchar(128),
"Description" Varchar(128),
"Amount" numeric)  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_Grants (extracted_on,"GrantId","UserId","Description","Amount") AS
                                        (
                                            SELECT
                                                extracted_on,"GrantId","UserId","Description","Amount"
                                            FROM
                                                Grants
                                            ORDER BY
                                                
                                                "GrantId") SEGMENTED BY   hash("GrantId") all Nodes KSAFE 1 #
--21. Accounts: fields: 12
drop table if exists Accounts cascade#
 create table Accounts("extracted_on" timestamptz DEFAULT current_timestamp,
"AccountId" integer,
"AccountNumber" Varchar(128),
"AccountDescription" Varchar(128),
"AccountCategory" integer,
"AccountCategoryTranslation" Varchar(128),
"FundName" Varchar(128),
"FundDescription" Varchar(128),
"Class" Varchar(128),
"Status" integer,
"StatusTranslation" Varchar(128),
"AccountCode" Varchar(128),
"AccountCodeDescription" Varchar(128))  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_Accounts (extracted_on,"AccountId","AccountNumber","AccountDescription","AccountCategory","AccountCategoryTranslation","FundName","FundDescription","Class","Status","StatusTranslation","AccountCode","AccountCodeDescription") AS
                                        (
                                            SELECT
                                                extracted_on,"AccountId","AccountNumber","AccountDescription","AccountCategory","AccountCategoryTranslation","FundName","FundDescription","Class","Status","StatusTranslation","AccountCode","AccountCodeDescription"
                                            FROM
                                                Accounts
                                            ORDER BY
                                                
                                                "AccountId") SEGMENTED BY   hash("AccountId") all Nodes KSAFE 1 #
--22. ProjectBudgets: fields: 7
drop table if exists ProjectBudgets cascade#
 create table ProjectBudgets("extracted_on" timestamptz DEFAULT current_timestamp,
"ProjectBudgetId" integer,
"AccountBudgetId" integer,
"ProjectId" integer,
"AccountId" integer,
"Amount" numeric,
"FiscalPeriodId" integer,
"PeriodAmount" numeric)  #
 CREATE PROJECTION
                                    IF NOT EXISTS projection_ProjectBudgets (extracted_on,"ProjectBudgetId","AccountBudgetId","ProjectId","AccountId","Amount","FiscalPeriodId","PeriodAmount") AS
                                        (
                                            SELECT
                                                extracted_on,"ProjectBudgetId","AccountBudgetId","ProjectId","AccountId","Amount","FiscalPeriodId","PeriodAmount"
                                            FROM
                                                ProjectBudgets
                                            ORDER BY
                                                
                                                "ProjectBudgetId") SEGMENTED BY   hash("ProjectBudgetId") all Nodes KSAFE 1 # ;


