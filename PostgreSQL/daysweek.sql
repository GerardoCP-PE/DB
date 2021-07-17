--First Created a temporary table to save the days, qty_sold and total_profit considering the date filters
with summary as (
SELECT 
to_char(t2.order_time, 'Dy') "days",
count(t1.id) "qty_sold",
sum(t3.price - t3.cost) "total_profit"
FROM  order_item t1 
INNER JOIN sales_order t2 on t1.sales_order_id = t2.id
inner join menu_item t3 on t1.menu_item_id = t3.id
where 
t2.order_time > now() - interval '7 days'
and t2.order_time > CAST(t2.order_time AS DATE) - extract(dow from CAST(t2.order_time AS DATE))::integer 
Group by to_char(t2.order_time, 'Dy')
)


--Then using the function generate_series to create the rows with de days of the week
SELECT 
A."day"
,COALESCE(T2."qty_sold",0) "qty_sold"
,COALESCE(T2."total_profit",0) "total_profit"
FROM (select 
to_char((date_trunc('day',date'2021-07-11'  )::date) + i,'Dy') 
as "day" 
from generate_series(0,6) i ) A
LEFT JOIN summary t2 on A."day" = t2."days"