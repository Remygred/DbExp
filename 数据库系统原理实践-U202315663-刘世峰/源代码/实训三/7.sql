-- 7) 查询身份证隶属武汉市没有买过任何理财产品的客户的名称、电话号、邮箱。
--    请用一条SQL语句实现该查询：


select c.c_name,c.c_phone,c.c_mail from client c where c.c_id_card like '4201%' and not exists(
    select 1 from property where pro_c_id=c.c_id and pro_type=1
)order by c.c_id;


/*  end  of  your code  */