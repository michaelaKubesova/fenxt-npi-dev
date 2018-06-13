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