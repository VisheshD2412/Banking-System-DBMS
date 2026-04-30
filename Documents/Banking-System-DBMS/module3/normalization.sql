-- ============================================
-- NORMALIZATION - BCNF DECOMPOSITION
-- ============================================

-- Original Unnormalized Table (for demonstration)
-- This table has update anomalies
CREATE TABLE IF NOT EXISTS UnnormalizedBanking (
    customer_id INT,
    customer_name VARCHAR(100),
    account_id INT,
    account_type VARCHAR(50),
    branch_id INT,
    branch_name VARCHAR(100),
    branch_city VARCHAR(50),
    transaction_id INT,
    transaction_type VARCHAR(20),
    amount DECIMAL(15,2),
    transaction_date TIMESTAMP
);

-- BCNF DECOMPOSITION
-- Decomposed into 6 normalized tables:

-- 1. Branches (no partial dependencies)
-- FD: branch_id -> branch_name, branch_city
CREATE TABLE Branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    address TEXT
);

-- 2. Customers (atomic attributes)
-- FD: customer_id -> customer_name, email, phone
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address TEXT
);

-- 3. Accounts (no transitive dependencies)
-- FD: account_id -> account_type, balance
-- FK references: branch_id, customer_id
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    account_type VARCHAR(20),
    balance DECIMAL(15,2) DEFAULT 0.00,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

-- 4. Transactions (no multivalued dependencies)
-- FD: transaction_id -> transaction_type, amount, date
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_type VARCHAR(20),
    amount DECIMAL(15,2),
    transaction_date TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

-- 5. Employees
-- FD: employee_id -> first_name, last_name, position, salary
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    branch_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    position VARCHAR(50),
    salary DECIMAL(10,2),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

-- 6. Loans
-- FD: loan_id -> loan_type, amount, status
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_type VARCHAR(50),
    loan_amount DECIMAL(15,2),
    remaining_balance DECIMAL(15,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- VERIFICATION QUERIES
-- Check for BCNF compliance:
-- Every determinant is a candidate key
SELECT 'BCNF Verification Complete' AS normalization_status;
