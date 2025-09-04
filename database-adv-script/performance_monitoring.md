# Use SQL commands like SHOW PROFILE or EXPLAIN ANALYZE to monitor the performance of a few of your frequently used queries.

Performance Monitoring with SQL Tools

To monitor query performance, I used:
EXPLAIN ANALYZE in PostgreSQL
SHOW PROFILE in MySQL (after enabling profiling)

Examples:
PostgreSQL Example:
EXPLAIN ANALYZE
SELECT *
FROM booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-10-01'
ORDER BY start_date;

Result:
Detected a sequential scan
High cost due to scanning the entire booking table


MySQL Example:
SET profiling = 1;

SELECT *
FROM booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-10-01';

SHOW PROFILE FOR QUERY 1;


Result:
Most time spent on “Sending data” and “Query execution”
Indicated inefficient row access and sorting


# Identify any bottlenecks and suggest changes (e.g., new indexes, schema adjustments).

## Bottleneck Analysis

After monitoring frequently used queries with EXPLAIN ANALYZE (PostgreSQL) and SHOW PROFILE (MySQL), the following performance issues were identified:

1. Full Table Scans

Queries on the booking table using filters like:

SELECT * FROM booking WHERE start_date BETWEEN '2024-01-01' AND '2024-10-01';


Were triggering sequential scans, even with large datasets.

2. Slow JOINs

Queries that joined booking, user, property, and payment tables:

SELECT b.*, u.*, p.*, pay.*
FROM booking b
JOIN user u ON b.user_id = u.user_id
JOIN property p ON b.property_id = p.property_id
JOIN payment pay ON b.booking_id = pay.booking_id;


Performed poorly due to missing indexes on join keys.

# Suggested Changes
# A. Add Indexes
-- For filtering by date
CREATE INDEX idx_booking_start_date ON booking(start_date);

-- For joins
CREATE INDEX idx_booking_user_id ON booking(user_id);
CREATE INDEX idx_booking_property_id ON booking(property_id);
CREATE INDEX idx_payment_booking_id ON payment(booking_id);

# B. Partition the Booking Table (PostgreSQL)

To improve performance for date-range queries:

-- Partition by year
CREATE TABLE booking (
  booking_id SERIAL PRIMARY KEY,
  user_id INT,
  property_id INT,
  start_date DATE NOT NULL
) PARTITION BY RANGE (start_date);


Create partitions like:

CREATE TABLE booking_2024 PARTITION OF booking
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

# C. Schema Adjustments

Ensure all JOIN keys (user_id, property_id, booking_id) are of the same data type across tables.

Use appropriate data types (e.g., use DATE not TEXT for start_date).

Avoid SELECT *; instead, select only the needed columns for better performance.

