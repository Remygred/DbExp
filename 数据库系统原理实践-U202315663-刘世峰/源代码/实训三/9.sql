-- 9) 查询购买了货币型(f_type='货币型')基金的用户的名称、电话号、邮箱。
--   请用一条SQL语句实现该查询：



select c.c_name,c.c_phone,c.c_mail from client c where exists(
    select 1 from property p join fund f on f_id=pro_pif_id where pro_type=3 and f_type='货币型' and pro_c_id=c.c_id
)order by c.c_id;



/*  end  of  your code  */