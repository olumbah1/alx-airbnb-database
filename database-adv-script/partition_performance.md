# Note
CASCADE ensures any foreign key references or dependent views are also dropped — use with caution.
You can backup the original booking table before running this, just in case:

CREATE TABLE booking_backup AS TABLE booking;

Don’t forget to re-create indexes or foreign keys after partitioning.

# Summary
We safely replaced the original booking table with a partitioned version, using start_date as the partition key. The table is partitioned by year, improving performance on time-based queries. If the table already exists, it is dropped and recreated immediately to ensure consistency. A default partition is added to capture any data that doesn't match defined ranges.

# How Migrate data from backup after dropping and partioning
-- Migrate data from backup into the new partitioned table
INSERT INTO booking (
    booking_id, user_id, property_id, start_date, status
-- add any other fields here
)

SELECT
    booking_id, user_id, property_id, start_date, status
    -- match the same field order
FROM booking_backup;


# Objective

The goal was to improve query performance on the large booking table by partitioning it based on the start_date column. This change aimed to optimize time-based queries, reduce scan time, and improve overall efficiency.

# Approach

Replaced the original booking table with a partitioned version using PostgreSQL's RANGE partitioning on the start_date column.

Created yearly partitions (e.g., booking_2022, booking_2023, booking_2024) to logically separate data by time.

Migrated existing data from a booking_backup table into the appropriate partitions.

Tested query performance using filtered SELECT statements on both the parent and individual partition tables.

#  Queries Tested
-- Query on partitioned table
SELECT * FROM booking_2024
WHERE start_date BETWEEN '2024-01-01' AND '2024-10-01'
ORDER BY start_date;

-- Query on parent table (partition pruning test)
SELECT * FROM booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-10-01';