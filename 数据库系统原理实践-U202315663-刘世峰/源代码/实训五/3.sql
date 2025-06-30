-- 获得兼职总酬劳前三名的客户:

select
    c.c_name,
    c.c_id_card,
    sum(w.w_amount) as total_salary
from client c
join wage w
  on w.w_c_id = c.c_id
where w.w_type = 2
group by c.c_id, c.c_name, c.c_id_card
order by total_salary desc
limit 3;




/* end of you code */