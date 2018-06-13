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
    tgt_entity varchar(255) ENCODING RLE,
    src_entity varchar(255) ENCODING RLE,
    event_type varchar(255) ENCODING RLE,
    event_ts timestamptz,
    ts_from timestamptz,
    ts_to timestamptz
) ORDER BY event_type,
          tgt_entity,
          src_entity
SEGMENTED BY hash(tgt_entity, event_ts) ALL NODES;

drop table if exists _sys_gd_load_info;
CREATE TABLE _sys_gd_load_info
(
    project_id varchar(255) ENCODING RLE,
    gdc_project_id varchar(255) ENCODING RLE,
    ts_from timestamptz,
    ts_to timestamptz,
    event_ts timestamptz,
    event_type varchar(255) ENCODING RLE,
    entity varchar(255) ENCODING RLE
)
 ORDER BY event_type,
          gdc_project_id,
          event_ts
SEGMENTED BY hash(entity, gdc_project_id, event_ts) ALL NODES;
