-- Write a query to find the total number of bookings made by each user, 
-- using the COUNT function and GROUP BY clause.


SELECT b.user_id, COUNT(booking_id) As Total_bookings
FROM booking b
GROUP BY b.user_id


-- Use a window function (ROW_NUMBER, RANK) to rank properties 
-- based on the total number of bookings they have received.

WITH booking_counts AS (
    SELECT 
        property_id, 
        COUNT(*) AS total_bookings
    FROM booking
    GROUP BY property_id
)
SELECT 
    property_id,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS rank,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS row_num
FROM booking_counts;
