--Write an initial query that retrieves all bookings along with the user 
--details, property details, and payment details and save it on perfomance.sql
SELECT
     b.*,
     u.*,
     pr.*,
     pay.*
FROM booking b 
INNER JOIN user u ON b.user_id =  u.user_id
INNER JOIN property pr ON b.property_id = pr.property_id
INNER JOIN payment pay ON b.booking_id = pay.booking_id;


-- Analyze the query’s performance using EXPLAIN and identify any inefficiencies.
EXPLAIN SELECT
     b.*,
     u.*,
     pr.*,
     pay.*
FROM booking b 
INNER JOIN user u ON b.user_id =  u.user_id
INNER JOIN property pr ON b.property_id = pr.property_id
INNER JOIN payment pay ON b.booking_id = pay.booking_id;


-- Refactor the query to reduce execution time, such as reducing unnecessary joins or using indexing.
SELECT 
    b.booking_id,
    b.booking_date,
    b.status,
    u.user_id,
    u.name,
    u.email,
    pr.property_id,
    pr.name AS property_name,
    pr.location,
    pay.payment_id,
    pay.amount,
    pay.payment_date
FROM booking b
INNER JOIN user u ON b.user_id = u.user_id
INNER JOIN property pr ON b.property_id = pr.property_id
INNER JOIN payment pay ON b.booking_id = pay.booking_id;