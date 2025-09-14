/*
Name: LiYiping
Matric: G2500424H
*/

#1. How many product categories are there? For each product category, show the number of records.
--  Apply DISTINCT on the column first, then use COUNT to return the number of unique values.
select count(distinct product_category)
from baristacoffeesalestbl;
-- Group the products by product_category, and count the number of products in each group.
select product_category, count(product_category)
from baristacoffeesalestbl
group by product_category;

#2.For each customer_gender and loyalty_member type, show the number of records. Within the same outcome, within each customer_gender and loyalty_member type, for each is_repeat_customer type, show the number of records.
-- Create the first table with 6 rows
with group1 as (
    select customer_gender, loyalty_member, count(*) as total_records
    from baristacoffeesalestbl
    group by 
		customer_gender, 
        loyalty_member
),
-- Create the second table with 12 rows*/
group2 as (
    select customer_gender, loyalty_member, is_repeat_customer, COUNT(*) AS sub_records
    from baristacoffeesalestbl
    group by customer_gender, loyalty_member, is_repeat_customer
)
-- Use customer_gender and loyalty_member as a composite key to join the two tables
select
    group2.customer_gender,
    group2.loyalty_member,
    group1.total_records,
    group2.is_repeat_customer,
    group2.sub_records
from 
group2 join group1
  on group1.customer_gender = group2.customer_gender 
  and group1.loyalty_member = group2.loyalty_member;
  
#3.For each product_category and customer_discovery_source, display the sum of total_amount.
 -- B version
 select product_category, customer_discovery_source, sum(total_amount) as total_sales #直接计算
 from baristacoffeesalestbl
 group by 
    product_category, 
    customer_discovery_source;
 -- A version
select product_category, customer_discovery_source,sum(convert(total_amount,decimal)) as total_sales 
from baristacoffeesalestbl
group by 
    product_category, 
    customer_discovery_source;
-- I think B version is more correct, because A convert the result to DECIMAL with a 0 scale, which removes cents and loses financial precision.

#4.Consider consuming coffee as the beverage, for each time_of_day category and gender, display the average focus_level and average sleep_quality.
-- use WHERE AND to find every row that match the requirment and union them together.
-- coffee, moring, female 
select "morning" as time_of_day,"female" as gender, avg(convert(focus_level,decimal)), avg(convert(sleep_quality,decimal))
from caffeine_intake_tracker
where time_of_day_morning = "true" and gender_female = "true" and beverage_coffee = "true"
union
-- coffee, moring, male
select 'morning' as time_of_day, 'male' as gender,avg(convert(focus_level,decimal)), avg(convert(sleep_quality,decimal))
from caffeine_intake_tracker
where time_of_day_morning='True' and gender_male = 'True' and beverage_coffee='True'
union
-- coffee, afternoon, female 
select 'afternoon' as time_of_day, 'female' as gender,avg(convert(focus_level,decimal)), avg(convert(sleep_quality,decimal))
from caffeine_intake_tracker
where time_of_day_afternoon='True' and gender_female = 'True' and beverage_coffee='True'
union
-- coffee, afternoon, male 
select 'afternoon' as time_of_day, 'male' as gender,avg(convert(focus_level,decimal)), avg(convert(sleep_quality,decimal))
from caffeine_intake_tracker
where time_of_day_afternoon='True' and gender_male = 'True' and beverage_coffee='True'
union
-- coffee, evening, female 
select 'evening' as time_of_day, 'female' as gender,avg(convert(focus_level,decimal)), avg(convert(sleep_quality,decimal))
from caffeine_intake_tracker
where time_of_day_evening='True' and gender_female = 'True' and beverage_coffee='True'
union
-- coffee, evening, male 
select 'evening' as time_of_day, 'male' as gender,avg(convert(focus_level,decimal)), avg(convert(sleep_quality,decimal))
from caffeine_intake_tracker
where time_of_day_evening='True' and gender_male = 'True' and beverage_coffee='True';


#5.There are problems with the data in this table. List out the problematic records.
-- Select the repeat records by using group by and having.
select location_name, count(*)
from list_coffee_shops_in_kota_bogor
group by location_name
having count(*)>1;

#6.List the amount of spending (money) recorded before 12 and after 12
-- In this dataset, the "datetime" column is problematic, so we need to take it into consideration.
(select "before 12" as period, sum(convert(money,decimal(4,2))) as amt
from
(
select hour(convert(datetime,time) )as the_hour,cash_type,card, money, coffee_name
from coffeesales
) as T1
where the_hour >=0 and the_hour < 12)
union
(
select "after 12" as period, sum(convert(money,decimal(4,2))) as amt
from
(
select hour(convert(datetime,time) )as the_hour,cash_type,card, money, coffee_name
from coffeesales
) as T1
where the_hour >=12 and the_hour < 24
);

#7.For each category of Ph values, show the average Liking, FlavorIntensity, Acidity, and Mouthfeel
select '0 to 1' as Ph, convert(avg(Liking),decimal(4,2)) as avgLiking, convert(avg(FlavorIntensity),decimal(4,2)) as avgFlavorIntensity,convert(avg(Acidity),decimal(4,2)) as avgacidity, convert(avg(Mouthfeel),decimal(4,2)) as avgmouthfeel
from consumerpreference
where pH >= 0.0 and pH < 1.0
union
select '1 to 2' as Ph, convert(avg(Liking),decimal(4,2)) as avgLiking, convert(avg(FlavorIntensity),decimal(4,2)) as avgFlavorIntensity,convert(avg(Acidity),decimal(4,2)) as avgacidity, convert(avg(Mouthfeel),decimal(4,2)) as avgmouthfeel
from consumerpreference
where pH >= 1.0 and pH < 2.0
union
select '2 to 3' as Ph, convert(avg(Liking),decimal(4,2)) as avgLiking, convert(avg(FlavorIntensity),decimal(4,2)) as avgFlavorIntensity,convert(avg(Acidity),decimal(4,2)) as avgacidity, convert(avg(Mouthfeel),decimal(4,2)) as avgmouthfeel
from consumerpreference
where pH >= 2.0 and pH < 3.0
union
select '3 to 4' as Ph, convert(avg(Liking),decimal(4,2)) as avgLiking, convert(avg(FlavorIntensity),decimal(4,2)) as avgFlavorIntensity,convert(avg(Acidity),decimal(4,2)) as avgacidity, convert(avg(Mouthfeel),decimal(4,2)) as avgmouthfeel
from consumerpreference
where pH >= 3.0 and pH < 4.0
union
select '4 to 5' as Ph, convert(avg(Liking),decimal(4,2)) as avgLiking, convert(avg(FlavorIntensity),decimal(4,2)) as avgFlavorIntensity,convert(avg(Acidity),decimal(4,2)) as avgacidity, convert(avg(Mouthfeel),decimal(4,2)) as avgmouthfeel
from consumerpreference
where pH >= 4.0 and pH < 5.0
union
select '5 to 6' as Ph, convert(avg(Liking),decimal(4,2)) as avgLiking, convert(avg(FlavorIntensity),decimal(4,2)) as avgFlavorIntensity,convert(avg(Acidity),decimal(4,2)) as avgacidity, convert(avg(Mouthfeel),decimal(4,2)) as avgmouthfeel
from consumerpreference
where pH >= 5.0 and pH < 6.0
union
select '6 to 7' as Ph, convert(avg(Liking),decimal(4,2)) as avgLiking, convert(avg(FlavorIntensity),decimal(4,2)) as avgFlavorIntensity,convert(avg(Acidity),decimal(4,2)) as avgacidity, convert(avg(Mouthfeel),decimal(4,2)) as avgmouthfeel
from consumerpreference
where pH >= 6.0 and pH < 7.0;


#8. After joining the 4 tables, for each trans_month (coffeesaeles.date), list the top 3 combinations of store_id (baristacoffeesalestbl) and shopID (coffeesales) based on the sum of money (coffeesales).
-- `top-rated-coffee`
select
-- Map numeric month to a 3-letter label for display
	case
		when trans_month = 1 then "JAN"
		when trans_month = 2 then "FEB"
		when trans_month = 3 then "MAR"
		when trans_month = 4 then "APR"
		when trans_month = 5 then "MAY"
		when trans_month = 6 then "JUN"
		when trans_month = 7 then "JUL"
		when trans_month = 8 then "AUG"
		when trans_month = 9 then "SEP"
		when trans_month = 10 then "OCT"
		when trans_month = 11 then "NOV"
		else "DEC"
	end as trans_month,   -- I check chatGPT on how can I subtitute the multiple value
store_id, store_location, location_name, avg_agtron, trans_amt, total_money
from
	(
    /* Rank each (month, store/shop) group by total_money descending
       so we can keep the top 3 per month. */
	select *, row_number() over (partition by trans_month order by total_money DESC) AS RN
	from
		(
         /* Aggregate per month + store/shop:
           - extract month from date
           - average agtron after converting to DECIMAL
           - count transactions and sum sales as DECIMAL to avoid float artifacts */
		select 
			extract(month from str_to_date(date,'%d/%m/%y')) AS trans_month,
            store_id,
            MIN(store_location) as store_location,
			MIN(location_name) as location_name,
            avg(convert(agtron,decimal(10,2))) as avg_agtron,
			-- avg(((convert(substring(agtron,1,2),decimal) + convert(substring(agtron,3),decimal))/2)) as avg_agtron
            -- I initially do this equation for avg_agtron because the data set is something like 58/60 and I check the website looks like there are two indicator for this one index so I try to take the average of thẻ data point before doing average of the dataset
			count(coffeesales.money) as trans_amt,
			sum(convert(money,decimal(9,2))) as total_money
		from coffeesales, list_coffee_shops_in_kota_bogor, `top-rated-coffee`, baristacoffeesalestbl
		where coffeesales.coffeeID = `top-rated-coffee`.ID and
			coffeesales.shopID = list_coffee_shops_in_kota_bogor.no and
			coffeesales.customer_id = substring(baristacoffeesalestbl.customer_id,6)
		group by trans_month, store_id, shopID
		order by trans_month, total_money DESC
		) as a 
	) as ranked
where RN <= 3;  -- keep the top 3 groups per month

