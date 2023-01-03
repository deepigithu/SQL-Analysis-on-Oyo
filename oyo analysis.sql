select * from cust_feb_2017

select * from cust_jan_2017

select * from cust_march_2017

select * from Sheet1$

-----Understanding the relationship between the tables
-----march 2017 and sheet related by hotel id
-----jan 2017 and sheet related by hotel id
-----feb 2017 and sheet related by hotel id
------so by sheet we can connect three tables by "hotelid" and here sheet acts main table

----Room Night -> oyo_rooms*(checkout –checkin)
----Average price per room –> Revenue/Room Night



---1Q---
---Write the query to count # of unique guests who have made a booking, total # of bookings for each month i.e., Jan, Feb and Mar 2017.

select DATENAME(MONTH,date) [Month],SUM(booking_id) as tot_bookings,COUNT(distinct(booking_id)) as uni_bookings
from cust_jan_2017
group by DATENAME(MONTH,date)
union
select DATENAME(MONTH,date) [Month],SUM(booking_id) as tot_bookings,COUNT(distinct(booking_id)) as uni_bookings
from cust_feb_2017
group by DATENAME(MONTH,date)
union
select DATENAME(MONTH,date) [Month],SUM(booking_id) as tot_bookings,COUNT(distinct(booking_id)) as uni_bookings
from cust_march_2017
group by DATENAME(MONTH,date)



----2Q---
----Write a query to calculate # of Room night booked and Average price per room for each city.

select SUM(j.oyo_rooms * (DATEDIFF(day,j.checkout,j.checkin))) as Room_night,AVG(j.amount/(DATEDIFF(day,j.checkout,j.checkin))) as avg_price_per_room,s.city,DATENAME(month,j.date)[Month]
from cust_jan_2017 j inner join Sheet1$ s on j.hotel_id=s.hotel_id
group by s.city,DATENAME(MONTH,j.date)
union
select SUM(f.oyo_rooms * (DATEDIFF(day,f.checkout,f.checkin))) as Room_night,AVG(f.amount/(DATEDIFF(day,f.checkout,f.checkin))) as avg_price_per_room,s.city,DATENAME(month,f.date)[Month]
from cust_feb_2017 f inner join Sheet1$ s on f.hotel_id=s.hotel_id
group by s.city,DATENAME(MONTH,f.date)
union
select SUM(m.oyo_rooms * (DATEDIFF(day,m.checkout,m.checkin))) as Room_night,AVG(m.amount/(DATEDIFF(day,m.checkout,m.checkin))) as avg_price_per_room,s.city,DATENAME(month,m.date)[Month]
from cust_march_2017 m inner join Sheet1$ s on m.hotel_id=s.hotel_id
group by s.city,DATENAME(MONTH,m.date)



---3Q---
---Write a query to display the top 3 hotels by revenue for each city for March 2017. Here N should be dynamic, i.e., value of N will of user’s choice

---N=3
select top 3 m.hotel_id,s.city,SUM(m.amount) as Revenue
from cust_march_2017 m inner join Sheet1$ s on m.hotel_id=s.hotel_id
group by m.hotel_id,s.city
order by Revenue desc


---N=6
select top 6 m.hotel_id,s.city,SUM(m.amount) as Revenue
from cust_march_2017 m inner join Sheet1$ s on m.hotel_id=s.hotel_id
group by m.hotel_id,s.city
order by Revenue desc


---4Q---
---Write a query that display the top 3 hotels in each city where the cancelation rate was high.(individually)

--For Jan 2017
select top 3 j.hotel_id,s.city,count(j.status) as cancelation_count,ROW_NUMBER() over (order by count(j.status)) as Rank
from cust_jan_2017 j inner join Sheet1$ s on j.hotel_id=s.hotel_id
where j.status=3
group by j.hotel_id,s.city
order by cancelation_count desc

---For Feb 2017
select top 3 f.hotel_id,s.city,count(f.status) as cancelation_count,ROW_NUMBER() over (order by count(f.status)) as Rank
from cust_feb_2017 f inner join Sheet1$ s on f.hotel_id=s.hotel_id
where f.status=3
group by f.hotel_id,s.city
order by cancelation_count desc

--For March 2017
select top 3 m.hotel_id,s.city,count(m.status) as cancelation_count,ROW_NUMBER() over (order by count(m.status)) as Rank
from cust_march_2017 m inner join Sheet1$ s on m.hotel_id=s.hotel_id
where m.status=3
group by m.hotel_id,s.city
order by cancelation_count desc


---5Q---
---Write a query that shows the top ‘N’ cities where highest revenue was generated(individually)

---For Jan 2017
select s.city,sum(j.amount) as Revenue,ROW_NUMBER() over (order by SUM(j.amount) desc) as Rank
from cust_jan_2017 j inner join Sheet1$ s on j.hotel_id=s.hotel_id
group by s.city

---For Feb 2017
select s.city,sum(f.amount) as Revenue,ROW_NUMBER() over (order by SUM(f.amount) desc) as Rank
from cust_feb_2017 f inner join Sheet1$ s on f.hotel_id=s.hotel_id
group by s.city

---For March 2017
select s.city,sum(m.amount) as Revenue,ROW_NUMBER() over (order by SUM(m.amount) desc) as Rank
from cust_march_2017 m inner join Sheet1$ s on m.hotel_id=s.hotel_id
group by s.city









