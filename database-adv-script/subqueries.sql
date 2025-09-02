-- Write a query to find all properties where the average rating 
-- is greater than 4.0 using a subquery.

SELECT *
FROM property
WHERE property_id IN (
    SELECT r.property_id
    FROM reviews r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4
);

-- Write a correlated subquery to find users 
-- who have made more than 3 bookings.


SELECT *
FROM user u
WHERE (
    SELECT COUNT(*)
    FROM booking b
    WHERE b.user_id = u.user_id
) > 3;
