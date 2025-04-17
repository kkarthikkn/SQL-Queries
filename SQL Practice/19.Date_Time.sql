# Date & Time

create table test_time(
	event_id int auto_increment primary key,
     event_name varchar(20),
     event_date datetime,
     created_at timestamp default current_timestamp
);
#TIMESTAMP: This is the data type. It stores both date and time (e.g., 2025-04-14 12:34:56).
#DEFAULT CURRENT_TIMESTAMP: This sets the default value for the column to the current date and time when the row is inserted.

#Difference b/w DateTime & TimeStamp [ Both stores Date & Time ]

-- 🕒 DATETIME:
-- Doesn't care about time zones
-- Good for: Events with fixed times (like birthdays, deadlines)
-- Ex: 2025-04-14 10:30:00 (stays exactly that)

-- ⏱️ TIMESTAMP:
-- Converts to and from UTC
-- Good for: Tracking when something was created or updated
-- Can auto-fill with CURRENT_TIMESTAMP
-- Ex: 2025-04-14 10:30:00 UTC (might look different in another time zone)


insert into test_time(event_name, event_date) values
('New Year Celebration', '2025-01-01 00:00:00'),
('Summer Fest', '2024-08-10 12:30:00'),
('Team Meeting', '2021-02-28 00:00:00'),
('Conference', '2025-06-15 12:30:00'),
('Online Webinar', '2023-07-03 00:00:00'),
('Workshop', '2024-06-20 12:30:00');

# returns the year
select event_date, year(event_date) as Year 
from test_time;

# returns the date
select event_date, date(event_date) as Year 
from test_time;

# returns the day
select event_date, day(event_date) as Year 
from test_time;

# Returns Weekday
select event_date,
weekday(event_date) as Weekdays
from test_time;

# Returns Week_number
select event_date,
week(event_date) as Week_no
from test_time;

# returns hours
select event_date,
hour(event_date) as Hours
from test_time;

# returns minutes
select event_date,
minute(event_date) as Minutes
from test_time;

# returns quarter
select event_date,
quarter(event_date) as Quarters
from test_time;

-- ============================================

# Time Intervals
select event_date, event_date + interval 30 day as After_30Days
from test_time;

select event_date, event_date - interval 30 day as Before_30Days
from test_time;



# Date Format Codes:
-- 	*---------------------------------------*
--   | %Y | Year (4 digits)        |  2025   | 
--   | %y | Year (2 digits)        |  25     | 
--   | %m | Month (01–12)          |  04     | 
--   | %b | Abbreviated month      |  Apr    | 
--   | %M | Full month name        |  April  | 
--   | %d | Day (01–31)            |  14     | 
--   | %W | Day of week (full)     |  Monday | 
--   | %a | Day of week (short)    |  Mon    | 
-- 	*---------------------------------------*


# 1
select event_date,
date_format(event_date,"%d-%m-%Y") as DD_MM_YYYY
from test_time;

# 2
select event_date,
date_format(event_date,"%a, %M %d, %Y") as Day_Date
from test_time;

# 3
select event_date,
date_format(event_date,'%M') as Months
from test_time;

# 4
select event_date,
date_format(event_date,'%W') as Weeks                 
from test_time;


# To convert from one time-zone to other [MySQl doesn't support ]
select '2025-01-01 10:00:00' as NY_time,
convert_tz('2025-01-01 10:00:00', 'America/New_York', 'Asia/Kolkata') as Converted;


-- ============================================

# Time Format Codes:
--    *-------------------------------*
-- 	 | %H |  Hour (00–23)	 |  15  | 
-- 	 | %h |  Hour (01–12)	 |  03  | 
-- 	 | %i |  Minutes (00–59)  |  30  | 
-- 	 | %s |  Seconds (00–59)  |  00  | 
-- 	 | %p |  AM or PM		 |  PM  | 
--    *-------------------------------*


#
select event_date,
date_format(event_date,"%h:%i:%s %p") as Time_Format
from test_time;

#
select event_date,
date_format(event_date,"%H:%i %p") as Time_Format
from test_time;







