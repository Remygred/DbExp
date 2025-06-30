-- 11) 给出黄姓用户的编号、名称、办理的银行卡的数量(没有办卡的卡数量计为0),持卡数量命名为number_of_cards,
--     按办理银行卡数量降序输出,持卡数量相同的,依客户编号排序。
-- 请用一条SQL语句实现该查询：



select c.c_id,c.c_name,count(b.b_number) as number_of_cards from client c left join bank_card b on b.b_c_id=c.c_id where c.c_name like '黄%' group by c.c_id,c.c_name order by number_of_cards desc,c.c_id;








/*  end  of  your code  */ 