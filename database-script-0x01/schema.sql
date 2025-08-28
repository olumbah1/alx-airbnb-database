
CREATE DATABASE IF NOT EXIST 'database-script-0x01'

CREATE TABLE 'user'(
'user_id' PRIMARY KEY, UUID, INDEXED,
'first_name' VARCHAR(255), NOT NULL,
'last_name' VARCHAR(255), NOT NULL,
'email: VARCHAR' UNIQUE NOT NULL,
'password_hash' VARCHAR(255), NOT NULL,
'phone_number' VARCHAR(255), NULL,
'role' ENUM('guest','host','admin'), NOT NULL,
'created_at' TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE 'property' (
'property_id' PRIMARY KEY, UUID, INDEXED,
'host_id' CHAR(36),
'name' VARCHAR(255), NOT NULL,
'description' TEXT NOT NULL,
'location' VARCHAR(255), NOT NULL,
'pricepernight' DECIMAL(10,2), NOT NULL,
'created_at' TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
'updated_at' TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (`host_id`) REFERENCES `user`(`user_id`)
);

CREATE TABLE 'booking' (
'booking_id' PRIMARY KEY, UUID, INDEXED,
'property_id' CHAR(36),
'user_id'     CHAR(36),
'start_date' DATE NOT NULL,
'end_date' DATE NOT NULL,
'total_price' DECIMAL(10,2), NOT NULL,
'status' ENUM ('pending','confirmed','canceled'), NOT NULL,
'created_at' TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (`property_id`) REFERENCES `property`(`property_id`),
FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`)
);

CREATE TABLE 'payment' (
'payment_id' PRIMARY KEY, UUID, INDEXED,
'booking_id' CHAR(36),
'amount' DECIMAL(10,2), NOT NULL,
'payment_date' TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
'payment_method' ENUM('credit_card','paypal','stripe') NOT NULL,
FOREIGN KEY (`booking_id`) REFERENCES `booking`(`booking_id`)
);

CREATE TABLE 'review' (
'review_id' PRIMARY KEY, UUID, INDEXED,
'property_id' CHAR(36),
'user_id'     CHAR(36),
'rating' INTEGER NOT NULL CHECK(rating >= 1 AND rating <= 5),
'comment' TEXT NOT NULL,
'created_at' TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (`property_id`) REFERENCES `property`(`property_id`),
FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`)
);

CREATE TABLE 'message' (
'message_id' PRIMARY KEY, UUID, INDEXED,
'sender_id'  CHAR(36),
'recipient_id' CHAR(36),
'message_body' TEXT NOT NULL,
'sent_at' TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (`sender_id`) REFERENCES `user`(`user_id`),
FOREIGN KEY (`recipient_id`) REFERENCES `user`(`user_id`)
);

