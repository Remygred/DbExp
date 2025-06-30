
select
    w.w_org,
    sum(w.w_amount) as total_salary
from wage w
join client c
  on w.w_c_id = c.c_id
where w.w_type = 2
group by w.w_org
order by total_salary desc
limit 3;




/* end of you code */