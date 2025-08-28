Entities and Attributes

User
user_id: Primary Key, UUID, Indexed
first_name: VARCHAR, NOT NULL
last_name: VARCHAR, NOT NULL
email: VARCHAR, UNIQUE, NOT NULL
password_hash: VARCHAR, NOT NULL
phone_number: VARCHAR, NULL
role: ENUM (guest, host, admin), NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

Property
property_id: Primary Key, UUID, Indexed
host_id: Foreign Key, references User(user_id)
name: VARCHAR, NOT NULL
description: TEXT, NOT NULL
location: VARCHAR, NOT NULL
pricepernight: DECIMAL, NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

Booking
booking_id: Primary Key, UUID, Indexed
property_id: Foreign Key, references Property(property_id)
user_id: Foreign Key, references User(user_id)
start_date: DATE, NOT NULL
end_date: DATE, NOT NULL
total_price: DECIMAL, NOT NULL
status: ENUM (pending, confirmed, canceled), NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

Payment
payment_id: Primary Key, UUID, Indexed
booking_id: Foreign Key, references Booking(booking_id)
amount: DECIMAL, NOT NULL
payment_date: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
payment_method: ENUM (credit_card, paypal, stripe), NOT NULL

Review
review_id: Primary Key, UUID, Indexed
property_id: Foreign Key, references Property(property_id)
user_id: Foreign Key, references User(user_id)
rating: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
comment: TEXT, NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

Message
message_id: Primary Key, UUID, Indexed
sender_id: Foreign Key, references User(user_id)
recipient_id: Foreign Key, references User(user_id)
message_body: TEXT, NOT NULL
sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP


Relationship

1. User → Booking

Type: One-to-Many (1:N)

Explanation: A user can make multiple bookings, but each booking is made by one user.

2. Property → Booking

Type: One-to-Many (1:N)

Explanation: A property can have many bookings, but a booking is for one property.


3. Booking → Payment

Type: One-to-One (1:1) or One-to-Many (1:N), depending on your design

Explanation:

Most common One booking has one payment.

4. Property → Review

Type: One-to-Many (1:N)

Explanation: A property can have many reviews.

5. User → Property

Type: One-to-Many (1:N)

Explanation: A user can own/list multiple properties; each property has one owner.

6. User → Message

Type: One-to-Many (1:N) or User to User via Message (Many-to-Many)

Explanation: Users can send and receive many messages.

7. User → Review

Type: One-to-Many (1:N)

Explanation: A user can write many reviews; each review is written by one user.

