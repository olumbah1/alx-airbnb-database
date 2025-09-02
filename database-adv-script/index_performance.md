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


