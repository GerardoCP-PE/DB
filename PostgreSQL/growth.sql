
-- Replace with your SQL query
--Got the first days of each month in the table post 
--I saved this record in a temporary table ordered and grouped by date
with temp1 as (
SELECT 
cast(date_trunc('month', created_at) as date)  "date"
,count(id) "count"
FROM posts 
group by 1 order by 1 asc
)
--Select the fields from the temporary table, and calculated the percent growth using the lag function
Select 
"date"
,"count"
,round((100 * (sum(o.count) - lag(sum(o.count), 1) over (order by o.date)) / lag(sum(o.count), 1) over 
           (order by o.date)),1) || '%' as percent_growth
from temp1 o
group by o.date, o.count
