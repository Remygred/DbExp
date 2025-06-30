

update wage w
join (
    select c_id from client where c_id_card = '420108199702144323'
) c on w.w_c_id = c.c_id
join (
    select w_c_id, sum(w_amount) as total_salary
    from wage
    where w_c_id = (select c_id from client where c_id_card = '420108199702144323')
      and year(w_time) = 2023
    group by w_c_id
) s on w.w_c_id = s.w_c_id
set 
    w.w_amount = w.w_amount - (
        greatest(s.total_salary - 60000, 0) * 0.2 
        * (w.w_amount / s.total_salary)
    ),
    w.w_tax = if(s.total_salary > 60000, 'Y', 'N')
where year(w.w_time) = 2023;




/* end of you code */ 