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
PARTITION BY (_sys_transform_id);