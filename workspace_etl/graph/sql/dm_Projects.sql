select
 "ProjectId",
 "UserId",
 "Description",
 "Division",
 "Location",
 "Department",
 "DateAdded",
 "DateChanged",
 "AddedByUserName",
 "AddedByUserNameLabel",
 "ProjectType",
 "ProjectDateId",
 "ProjectStatus",
 "Dummy"
from dm_Projects
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_PROJECTS_TRANSFORM_ID}
union all
select  
GoodData_Attr(-1) as "ProjectId" ,
GoodData_Attr('<No Project>') as "UserId" ,
GoodData_Attr('<No Project>') as "Description" ,
GoodData_Attr('No Division') as "Division" ,
GoodData_Attr('No Location') as "Location" ,
GoodData_Attr('No Department') as "Department",
null as "DateAdded" ,
null as "DateChanged",
GoodData_Attr('') as "AddedByUserName",
GoodData_Attr('') as "AddedByUserNameLabel",
GoodData_Attr('No Type') as "ProjectType",
GoodData_Attr(0) as "ProjectDateId",
GoodData_Attr('Active') as "ProjectStatus",
GoodData_Attr(1) as "Dummy"
union all
select	
GoodData_Attr(-2) as "ProjectId" ,
GoodData_Attr('') as "UserId" ,
GoodData_Attr('') as "Description" ,
GoodData_Attr('') as "Division" ,
GoodData_Attr('') as "Location" ,
GoodData_Attr('') as "Department",
null as "DateAdded" ,
null as "DateChanged",
GoodData_Attr('') as "AddedByUserName",
GoodData_Attr('') as "AddedByUserNameLabel",
GoodData_Attr('') as "ProjectType",
GoodData_Attr(0) as "ProjectDateId",
GoodData_Attr('Active') as "ProjectStatus",
GoodData_Attr(1) as "Dummy"
;