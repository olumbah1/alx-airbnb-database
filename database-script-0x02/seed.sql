USE `database_script_0x01`;

-- Generate UUIDs and store them in variables to reuse for relationships
SET @user1_id = UUID();
SET @user2_id = UUID();
SET @user3_id = UUID();

SET @property1_id = UUID();
SET @property2_id = UUID();

SET @booking1_id = UUID();
SET @booking2_id = UUID();

SET @payment1_id = UUID();
SET @payment2_id = UUID();

SET @review1_id = UUID();
SET @review2_id = UUID();

SET @message1_id = UUID();
SET @message2_id = UUID();

-- Insert Users
INSERT INTO `user` (
  user_id, first_name, last_name, email, password_hash, phone_number, role, created_at
) VALUES
(@user1_id, 'Alice', 'Johnson', 'alice@example.com', 'hashed_pw1', '1234567890', 'host', NOW()),
(@user2_id, 'Bob', 'Smith', 'bob@example.com', 'hashed_pw2', '2345678901', 'guest', NOW()),
(@user3_id, 'Carol', 'Lee', 'carol@example.com', 'hashed_pw3', '3456789012', 'guest', NOW());

-- Insert Properties (owned by Alice)
INSERT INTO `property` (
  property_id, host_id, name, description, location, pricepernight, created_at, updated_at
) VALUES
(@property1_id, @user1_id, 'Cozy Apartment', 'A cozy apartment in the city center', 'New York', 120.00, NOW(), NOW()),
(@property2_id, @user1_id, 'Beach House', 'A beautiful beach house with ocean view', 'Los Angeles', 200.00, NOW(), NOW());

-- Insert Bookings
INSERT INTO `booking` (
  booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at
) VALUES
(@booking1_id, @property1_id, @user2_id, '2025-09-01', '2025-09-05', 480.00, 'confirmed', NOW()),
(@booking2_id, @property2_id, @user3_id, '2025-09-10', '2025-09-15', 1000.00, 'confirmed', NOW());

-- Insert Payments
INSERT INTO `payment` (
  payment_id, booking_id, amount, payment_date, payment_method
) VALUES
(@payment1_id, @booking1_id, 480.00, NOW(), 'credit_card'),
(@payment2_id, @booking2_id, 1000.00, NOW(), 'paypal');

-- Insert Reviews
INSERT INTO `review` (
  review_id, property_id, user_id, rating, comment, created_at
) VALUES
(@review1_id, @property1_id, @user2_id, 5, 'Amazing stay! Clean and comfortable.', NOW()),
(@review2_id, @property2_id, @user3_id, 4, 'Great location and view, but a bit noisy.', NOW());

-- Insert Messages
INSERT INTO `message` (
  message_id, sender_id, recipient_id, message_body, sent_at
) VALUES
(@message1_id, @user2_id, @user1_id, 'Hi Alice, is the apartment available next weekend?', NOW()),
(@message2_id, @user3_id, @user1_id, 'Hi, I have a question about the beach house amenities.', NOW());
