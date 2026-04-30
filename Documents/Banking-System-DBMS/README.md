# Banking System DBMS Project

## Project Overview
A comprehensive banking database management system implementing core DBMS concepts including ER modeling, complex SQL queries, normalization, transaction management, concurrency control, and hybrid SQL-NoSQL integration.

## Project Structure banking-dbms/
├── module1/ # ER Model & Schema Design
│ ├── er_diagram.png
│ ├── schema.sql
│ └── sample_data.sql
├── module2/ # Complex SQL Queries
│ ├── queries.sql
│ └── explain_plans.txt
├── module3/ # Normalization
│ ├── normalization.sql
│ └── fd_analysis.txt
├── module4/ # Transaction Management
│ └── transactions.sql
├── module5/ # Concurrency Control
│ └── concurrency_scripts.sql
├── module6/ # Full DBMS Application
│ ├── api_documentation.txt
│ └── mongodb_scripts.js
└── README.md

 
## Setup Instructions
1. Install MySQL/PostgreSQL
2. Run `module1/schema.sql` to create database
3. Run `module1/sample_data.sql` to populate tables
4. Execute queries from `module2/queries.sql`
5. For Module 6: Install MongoDB and run `mongosh < module6/mongodb_scripts.js`

## Modules Description

### Module 1: ER Model to Schema Conversion
- Designed ER diagram for banking domain
- 6 entities: Customers, Accounts, Transactions, Branches, Employees, Loans
- Converted to relational schema with proper constraints
- Primary keys, foreign keys, NOT NULL, and UNIQUE constraints implemented

### Module 2: Relational Algebra & Complex Queries
- 5+ complex SQL queries with multi-table JOINs
- Aggregate functions: SUM, COUNT, AVG, MAX, MIN
- CTEs (WITH clause) and subqueries
- CASE statements for conditional logic
- Query execution plans documented

### Module 3: Normalization Tool
- Functional dependency analysis performed
- BCNF decomposition applied to banking schema
- All 6 tables verified for 3NF/BCNF compliance
- No update/insert/delete anomalies

### Module 4: Transaction Simulator
- ACID properties implementation
- COMMIT and ROLLBACK demonstrations
- SAVEPOINT for partial rollbacks
- Transaction isolation levels (SERIALIZABLE)
- Real-world fund transfer scenarios

### Module 5: Concurrency Control Prototype
- Lock-based concurrency mechanisms
- NOWAIT and WAIT scenarios
- Deadlock prevention strategies
- Row-level locking with FOR UPDATE
- Multi-session simulation

### Module 6: Full DBMS Project
- REST API documentation (6 endpoints)
- MongoDB integration for transaction logs
- Aggregation pipeline for analytics
- Hybrid SQL-NoSQL architecture design
- Analytics dashboard API structure

## Technologies Used
- **Database:** MySQL / PostgreSQL
- **NoSQL:** MongoDB (transaction logging)
- **Backend:** Python Flask (API design)
- **Analytics:** Aggregation pipelines
- **Version Control:** Git & GitHub

## Author
**Vishesh Dalwal**

## Repository
🔗 [github.com/VisheshD2412/Banking-System-DBMS](https://github.com/VisheshD2412/Banking-System-DBMS)
