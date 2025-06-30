insert into wage
    (w_c_id, w_amount, w_org, w_time, w_type, w_memo, w_tax)
select
    w_c_id,
    w_amount,
    w_org,
    w_time,
    w_type,
    w_memo,
    'N'
from (
    /* 全职：去重后直接插入 */
    select
        c.c_id as w_c_id,
        d.w_amount as w_amount,
        d.w_org as w_org,
        d.w_time as w_time,
        1 as w_type,
        d.w_memo as w_memo
    from (
        select nw.*
        from new_wage nw
        join (
                select min(id) id
                from   new_wage
                group  by c_id_card, w_amount, w_org, w_time
            ) k
        on k.id = nw.id
    ) d
    join client c
    on   c.c_id_card = d.c_id_card
    where d.w_type = 1

    union all

    /* 兼职：去重后按“人-单位-月份”汇总 */
    select
        c.c_id as w_c_id,
        sum(d.w_amount) as w_amount,
        d.w_org as w_org,
        min(d.w_time) as w_time,
        2 as w_type,
        group_concat(d.w_memo order by d.w_time) as w_memo
    from (
        select nw.*
        from   new_wage nw
        join   (
                 select min(id) id
                 from   new_wage
                 group  by c_id_card, w_amount, w_org, w_time
               ) k
        on k.id = nw.id
    ) d
    join client c
    on   c.c_id_card = d.c_id_card
    where d.w_type = 2
    group by c.c_id,
             d.w_org,
             date_format(d.w_time,'%Y-%m')
) src
order by w_c_id, w_org, w_time;
