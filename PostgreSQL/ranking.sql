---First get the totals in table A, only considering the information of the past week
---Then I selected this data and with support of the Rank function, I can show the results
SELECT
RANK () OVER (ORDER BY A."net_profit" desc) "ranking"
,A."id" 
,A."name"
,A."net_profit"
FROM (
SELECT 
t1.id "id"
,t1.name "name"
,sum(t1.price-t1.cost) "net_profit"
FROM order_item t0
INNER JOIN menu_item t1 on t0.menu_item_id = t1.id
INNER JOIN sales_order t2 on t0.sales_order_id = t2.id
AND  t2.order_time between (current_timestamp - interval '1 week' ) and (t2.order_time)
group by 1,2
order by 1
) A
LIMIT 5
