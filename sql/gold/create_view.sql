create view gold.bike_sales
AS
with bike_share as(
select * from silver.bike_share_yr_0
UNION ALL 
select * from  silver.bike_share_yr_1)

select 
date,
season,
bs.year,
month,
hour,
is_holiday,
day_of_week,
is_working_day,
weather,
temperature,
humidity,
wind_speed,
rider_type,
riders,
price,
COGS,
(price * riders) as revenue,
(riders * COGS) as cost,
riders * (price - COGS) as profit
from bike_share bs
left join silver.cost_table cs
on bs.year = cs.year