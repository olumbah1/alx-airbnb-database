-- Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT 
    * 
FROM 
    user u 
JOIN 
    booking b ON u.user_id = b.user_id; 


-- Write a query using a LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT 
    * 
FROM 
    property p
LEFT JOIN 
    reviews r ON p.property_id = r.property_id


-- Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT  
    *
FROM 
    user u
OUTER JOIN 
    booking b ON u.user_id = b.user_id 