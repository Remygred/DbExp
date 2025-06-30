 -- 6) 查找相似的理财客户
--   请用一条SQL语句实现该查询：

with cp as (                        
    select distinct pro_c_id as cid,
                    pro_pif_id as pid
    from property
    where pro_type = 1
),
common_pairs as (   
    select a.cid as pac,
           b.cid as pbc,
           count(*) as common
    from cp a
    join cp b
      on a.pid = b.pid
     and a.cid <> b.cid
    group by a.cid, b.cid
),
ranked as (
    select pac,
           pbc,
           common,
           rank() over (partition by pac order by common desc, pbc asc) as crank
    from common_pairs
)
select pac,
       pbc,
       common,
       crank
from ranked
where crank < 3
order by pac,
         crank,
         pbc;







/*  end  of  your code  */