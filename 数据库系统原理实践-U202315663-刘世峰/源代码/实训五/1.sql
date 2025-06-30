-- 将客户年度从各单位获得的酬劳进行排序

select
    c.c_name,
    extract(year from w.w_time) as year,
    c.c_id_card,
    coalesce(sum(case when w.w_type = 1 then w.w_amount end),0) as full_t_amount,
    coalesce(sum(case when w.w_type = 2 then w.w_amount end),0) as part_t_amount
from client c
join wage w
  on w.w_c_id = c.c_id
group by c.c_name, c.c_id_card, extract(year from w.w_time)
order by (coalesce(sum(case when w.w_type = 1 then w.w_amount end),0)
         +coalesce(sum(case when w.w_type = 2 then w.w_amount end),0)) desc;




/* end of you code */