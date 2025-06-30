-- 17 查询2022年2月购买基金的高峰期。至少连续三个交易日，所有投资者购买基金的总金额超过100万(含)，则称这段连续交易日为投资者购买基金的高峰期。只有交易日才能购买基金,但不能保证每个交易日都有投资者购买基金。2022年春节假期之后的第1个交易日为2月7日,周六和周日是非交易日，其余均为交易日。请列出高峰时段的日期和当日基金的总购买金额，按日期顺序排序。总购买金额命名为total_amount。
--    请用一条SQL语句实现该查询：

with recursive calendar as (
    select date '2022-02-07' as d
    union all
    select date_add(d, interval 1 day)
    from calendar
    where d < '2022-02-28'
),
trading_day as (
    select d,
           row_number() over (order by d) as rn_td
    from calendar
    where dayofweek(d) between 2 and 6
),
day_amount as (
    select t.d,
           coalesce(sum(f.f_amount * p.pro_quantity), 0) as total_amount,
           t.rn_td
    from trading_day t
    left join property p
           on date(p.pro_purchase_time) = t.d
          and p.pro_type = 3
    left join fund f
           on f.f_id = p.pro_pif_id
    group by t.d, t.rn_td
),
high_day as (
    select d,
           total_amount,
           rn_td,
           row_number() over (order by d) as rn_high
    from day_amount
    where total_amount >= 1000000
),
tagged as (
    select d,
           total_amount,
           rn_td - rn_high as grp_id
    from high_day
),
qualified_grp as (
    select grp_id
    from tagged
    group by grp_id
    having count(*) >= 3
)
select d as pro_purchase_time,
       total_amount as total_amount
from tagged
where grp_id in (select grp_id from qualified_grp)
order by d;








/*  end  of  your code  */