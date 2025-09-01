# Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.

Used SQL querY a INNER JOIN that retrieves all bookings and the respective users who made those bookings.

Explanation:

booking is the tanle containing property bookings.
users is the table containing all the users informations.


# Write a query using a LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.

SQL query using a LEFT JOIN that retrieves all properties and their associated reviews, including properties that do not have any reviews:

Explanation:

properties is the table containing property information.
reviews is the table containing reviews for each property.
The LEFT JOIN ensures that every row from properties is included.
If a property has no reviews, the columns from reviews will return NULL.



# Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

Used SQL query FULL OUTER JOIN to retrieve all users and all bookings including:

Users who have no bookings, and
Bookings that are not linked to any user.

Explanation:

users is  table of users.

booking is table of property booking.

FULL OUTER JOIN includes:
All records from users (even if there's no matching booking),
All records from bookings (even if there's no matching user).
Where there's no match, the corresponding columns will return NULL.