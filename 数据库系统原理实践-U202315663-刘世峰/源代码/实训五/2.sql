
with full_w as (                             
    select w.w_org,
           w.w_c_id,
           w.w_amount,
           date_format(w.w_time,'%Y-%m') as ym
    from wage w
    join client c on c.c_id = w.w_c_id
    where w.w_type = 1
),
org_base as (
    select w_org,
           sum(w_amount) as total_amount,
           count(distinct w_c_id) as people_cnt,
           count(distinct ym) as month_cnt,
           max(w_amount) as max_wage,
           min(w_amount) as min_wage
    from full_w
    group by w_org
),
org_stat as (
    select w_org,
           total_amount,
           round(total_amount/(people_cnt*month_cnt),2) as average_wage,
           max_wage,
           min_wage
    from org_base
),
emp_month_avg as (                                         
    select w_org,
           w_c_id,
           sum(w_amount)/count(distinct ym) as emp_avg
    from full_w
    group by w_org,w_c_id
),
ranked as (                                                
    select w_org,
           emp_avg,
           row_number() over(partition by w_org order by emp_avg) as rn,
           count(*) over(partition by w_org) as cnt
    from emp_month_avg
),
median as (                                                
    select w_org,
           round(avg(emp_avg),2) as mid_wage
    from ranked
    where (cnt mod 2 = 1 and rn = cnt div 2 + 1)
       or (cnt mod 2 = 0 and rn in (cnt div 2, cnt div 2 + 1))
    group by w_org
)
select s.w_org,
       s.total_amount,
       s.average_wage,
       s.max_wage,
       s.min_wage,
       m.mid_wage
from org_stat s
join median  m on m.w_org = s.w_org
order by s.total_amount desc;




/* end of you code */