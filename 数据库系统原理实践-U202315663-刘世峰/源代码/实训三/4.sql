-- 4) 查询办理了储蓄卡的客户名称、手机号、银行卡号。 查询结果结果依客户编号排序。
--    请用一条SQL语句实现该查询：

select c.c_name,c.c_phone,b.b_number from client c inner join bank_card b on c.c_id=b.b_c_id where b.b_type='储蓄卡' order by c.c_id;



/*  end  of  your code  */