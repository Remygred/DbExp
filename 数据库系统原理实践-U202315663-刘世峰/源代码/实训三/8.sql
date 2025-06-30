-- 8) 查询持有两张(含）以上信用卡的用户的名称、身份证号、手机号。
--    请用一条SQL语句实现该查询：


select c.c_name,c.c_id_card,c.c_phone from client c where c.c_id in (
    select b_c_id from bank_card where b_type='信用卡' group by b_c_id having count(*)>=2
)order by c.c_id;



/*  end  of  your code  */