create table recorder(
    id                    number(6)
                           constraint recoder_id_pk primary key,
    name                varchar2(100 char),
    initialValue         number(12)
                            constraint recoder_id_nn not null,
    finalValue           number(12),                           
    growthValue       number(12)
);

commit;

alter table recorder add memo varchar2(100 char);

