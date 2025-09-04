-- 1. Assume the Booking table is large and query performance is slow. 
-- Implement partitioning on the Booking table based on the start_date column. 

-- Drop the original table if it exists (optional and dangerous!)

-- Drop existing table if it exists
DROP TABLE IF EXISTS booking CASCADE;

-- Recreate the booking table as a partitioned table
CREATE TABLE booking (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date   DATE NOT NULL,
    -- Add other relevant fields here
    CONSTRAINT booking_date_check CHECK (start_date IS NOT NULL)
) PARTITION BY RANGE (start_date);

-- Create partition for bookings in 2022
CREATE TABLE booking_2022 PARTITION OF booking
FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

-- Create partition for bookings in 2023
CREATE TABLE booking_2023 PARTITION OF booking
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

-- Create partition for bookings in 2024
CREATE TABLE booking_2024 PARTITION OF booking
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Create a default partition (optional - handles unexpected dates)
CREATE TABLE booking_default PARTITION OF booking
DEFAULT;

-- Don’t forget to re-create indexes or foreign keys after partitioning.


-- 2. Test the performance of queries on the partitioned table 
-- (e.g., fetching bookings by date range).

EXPLAIN ANALYZE
SELECT
 * 
FROM 
    booking_2024
WHERE 
    start_date 
BETWEEN '2024-01-01' AND '2024-10-1'
ORDER BY
     start_date;

-- Write a brief report on the improvements you observed.
