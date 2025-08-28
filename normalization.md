Normalization Process

Objective
To ensure the database schema adheres to the principles of normalization, specifically up to Third Normal Form (3NF), to eliminate redundancy and maintain data integrity.

---

First Normal Form (1NF)
Rule:
- Eliminate repeating groups
- Ensure all fields contain only atomic (indivisible) values

Status:
All fields in the schema are atomic.
No multi-valued or repeating fields found.


Second Normal Form (2NF)
Rule:
- Be in 1NF
- Eliminate partial dependencies (only an issue with composite primary keys)

Status:
All tables use simple primary keys (UUIDs)
No partial dependencies detected


Third Normal Form (3NF)

Rule:
- Be in 2NF
- Eliminate transitive dependencies (non-key attributes should depend only on the primary key)

Status:
No transitive dependencies found
No redundant data like `OwnerName`, `UserEmail`, etc., stored in multiple tables
Foreign key references are used correctly

Final Notes

All six entities (User, Property, Booking, Payment, Review, Message) are fully normalized up to **3NF**. The design avoids redundancy, improves consistency, and simplifies future data maintenance.

