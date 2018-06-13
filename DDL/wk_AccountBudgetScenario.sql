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