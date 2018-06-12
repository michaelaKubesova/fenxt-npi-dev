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
