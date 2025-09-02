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


# Write a query to find all properties where the average rating is greater than 4.0 using a subquery.

First, we go look at all the bookings.
We find users who made more than 3 bookings — like building a list: [2,4, 6].
Then we go to the user table and say: "Give me all users whose user_id is in that list."

The subquery doesn’t care what’s happening in the outer query


# Write a correlated subquery to find users who have made more than 3 bookings.
You look at each user one by one:
"OK, this is User 1 — how many bookings did they make?"
Then "OK, now User 2 — how many bookings for them?"
And so on…
If a user has more than 3 bookings, you keep them.

The subquery needs the outer query to work.