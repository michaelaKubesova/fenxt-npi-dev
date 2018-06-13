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