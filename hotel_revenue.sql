alter table code_basics.dim_hotels rename column property_id to p_id;
alter table code_basics.dim_date rename column `mmm yy` to m_year;
alter table code_basics.fact_aggregated_bookings modify column property_id varchar(255);
alter table code_basics.fact_aggregated_bookings drop primary key;

drop table all_data;

create table all_data as (

select booking_id, property_id, booking_date, check_in_date, m_year, week_no
,  day_type, checkout_date, no_guests, booking_platform, ratings_given
, booking_status, revenue_generated, revenue_realized, room_id, room_class, property_name
, category, city

from code_basics.fact_bookings as fact_b

left join code_basics.dim_rooms as dim_r
on fact_b.room_category = dim_r.room_id

left join code_basics.dim_hotels as dim_h
on fact_b.property_id = dim_h.p_id

left join code_basics.dim_date as dim_d
on fact_b.check_in_date = dim_d.dates);

-- left join code_basics.fact_aggregated_bookings as fact_a
-- on (fact_b.property_id = fact_a.prop_id and fact_b.check_in_date = fact_a.checkin_date and fact_b.room_category = fact_a.r_category));

select * from all_data;

create table fact_a_bookings as (

select prop_id, property_name, checkin_date, r_category, successful_bookings, capacity

from code_basics.fact_aggregated_bookings as fact_a

left join code_basics.dim_hotels as dim_h
on fact_a.prop_id = dim_h.p_id);

select * from fact_a_bookings