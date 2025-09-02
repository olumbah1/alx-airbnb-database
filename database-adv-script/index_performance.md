# Identify high-usage columns in your User, Booking, and Property tables (e.g., columns used in WHERE, JOIN, ORDER BY clauses).

Table: user
Column 	         Usage Potential	              Index Recommendation
user_id	     Primary key, used in JOINs	       ✅ Already indexed (PK)
email	     Likely filtered (WHERE email =)   ✅ Needs index
created_at	  Possibly sorted or filtered	   ✅ Optional index if used


Table: property
Column	         Usage Potential	             Index Recommendation
property_id	Primary key, used in JOIN with booking/review ✅ Already indexed (PK)
host_id	        Used in JOIN with user	               ✅ Needs index
location	Possibly filtered (e.g., WHERE location =) ✅ Optional index
pricepernight	Could be used in filtering or sorting  ✅ Optional index
created_at	       Sorted or filtered by date	       ✅ Optional index


Table: booking
Column	              Usage Potential	            Index Recommendation
booking_id          	Primary key	             ✅ Already indexed (PK)
property_id	       Used in JOIN with property 	 ✅ Needs index
user_id	             Used in JOIN with user	     ✅ Needs index
start_date, end_date Filter/sort range-based queries	✅ Index useful
status	    Frequently filtered (WHERE status =)	    ✅ Index useful
created_at	    Ordered or filtered by date         ✅ Optional index


Table: payment
Column	            Usage Potential	           Recommendation
booking_id	        JOIN with booking	   ✅ Index recommended
payment_date	    Filtering/sorting	   ✅ Optional index


# Write SQL CREATE INDEX commands to create appropriate indexes for those columns and save them on database_index.sql

User Table:
Add index for email search and created time
CREATE INDEX idx_user_email ON user(email);
CREATE INDEX idx_user_created_at ON user(created_at);

Property Table
CREATE INDEX idx_property_host_id ON property(host_id);
CREATE INDEX idx_property_location ON property(location);
CREATE INDEX idx_property_price ON property(pricepernight);
CREATE INDEX idx_property_created_at ON property(created_at);

Booking Table
CREATE INDEX idx_booking_user_id ON booking(user_id);
CREATE INDEX idx_booking_property_id ON booking(property_id);
CREATE INDEX idx_booking_start_date ON booking(start_date);
CREATE INDEX idx_booking_end_date ON booking(end_date);
CREATE INDEX idx_booking_status ON booking(status);
CREATE INDEX idx_booking_created_at ON booking(created_at);

Payment Table:
CREATE INDEX idx_payment_booking_id ON payment(booking_id);
CREATE INDEX idx_payment_date ON payment(payment_date);

# Measure the query performance before and after adding indexes using EXPLAIN or ANALYZE.

Let's Use This Query for EXPLAIN

We'll analyze this real-world query:

SELECT *
FROM booking
WHERE user_id = 'abc-123'
ORDER BY created_at DESC;

❌ BEFORE Index (No helpful index exists)

If you run:

EXPLAIN SELECT *
FROM booking
WHERE user_id = 'abc-123'
ORDER BY created_at DESC;

You might get something like this (PostgreSQL or MySQL output):

Seq Scan on booking  (cost=0.00..4200.00 rows=500 width=...)
  Filter: (user_id = 'abc-123')


Explanation:

🟥 Seq Scan = Sequential scan of the whole table.

The database checks every row in booking to find matching user_id

Very slow for large datasets

✅ Create Index to Optimize

Now add a composite index that matches both WHERE and ORDER BY:


CREATE INDEX idx_booking_user_created_at
ON booking(user_id, created_at DESC);

This index helps because it matches both:
WHERE user_id = ...
ORDER BY created_at DESC

✅ AFTER Index

Now run the same EXPLAIN again:

EXPLAIN SELECT *
FROM booking
WHERE user_id = 'abc-123'
ORDER BY created_at DESC;

You'll likely get:

Index Scan using idx_booking_user_created_at on booking
  Index Cond: (user_id = 'abc-123')


Explanation:

🟩 Index Scan means it’s using the new index ✅

It's only scanning matching rows
It can also return them already sorted by created_at DESC
Much faster performance