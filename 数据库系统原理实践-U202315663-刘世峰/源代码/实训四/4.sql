with prod14_cust as (
    select pro_c_id,
           sum(pro_quantity) qty
    from property
    where pro_type = 1
      and pro_pif_id = 14
    group by pro_c_id
),
ranked as (
    select pro_c_id,
           dense_rank() over (order by qty desc) rk
    from prod14_cust
),
top_cust as (
    select pro_c_id
    from ranked
    where rk <= 3
),
cand as (
    select distinct pro_pif_id
    from property
    where pro_type = 1
      and pro_pif_id <> 14
      and pro_c_id in (select pro_c_id from top_cust)
),
sim as (
    select c.pro_pif_id,
           count(distinct p.pro_c_id) cc
    from cand c
    join property p
      on p.pro_type = 1
     and p.pro_pif_id = c.pro_pif_id
    group by c.pro_pif_id
)
select pro_pif_id,
       cc,
       prank
from (
    select pro_pif_id,
           cc,
           dense_rank() over (order by cc desc) prank
    from sim
) t
where prank <= 3
order by cc desc,
         pro_pif_id;
