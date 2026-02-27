CREATE TABLE Branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100),
    IFSC_code VARCHAR(20) UNIQUE,
    address VARCHAR(255),
    city VARCHAR(100)
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255),
    created_at DATE
);

CREATE TABLE Account_Type (
    account_type_id INT PRIMARY KEY,
    type_name VARCHAR(50),
    minimum_balance DECIMAL(10,2),
    interest_rate DECIMAL(5,2)
);

CREATE TABLE Account (
    account_id INT PRIMARY KEY,
    account_number VARCHAR(20) UNIQUE,
    balance DECIMAL(12,2),
    open_date DATE,
    status VARCHAR(20),
    branch_id INT,
    account_type_id INT,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id),
    FOREIGN KEY (account_type_id) REFERENCES Account_Type(account_type_id)
);

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE Customer_Account (
    customer_id INT,
    account_id INT,
    role VARCHAR(20),
    PRIMARY KEY (customer_id, account_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (account_id) REFERENCES Account(account_id)
);

CREATE TABLE Transaction (
    transaction_id INT PRIMARY KEY,
    transaction_type VARCHAR(20),
    amount DECIMAL(12,2),
    transaction_date DATE,
    account_id INT,
    reference_account_id INT,
    FOREIGN KEY (account_id) REFERENCES Account(account_id),
    FOREIGN KEY (reference_account_id) REFERENCES Account(account_id)
);

CREATE TABLE Loan (
    loan_id INT PRIMARY KEY,
    loan_type VARCHAR(50),
    amount DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    customer_id INT,
    branch_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE Card (
    card_id INT PRIMARY KEY,
    card_number VARCHAR(20) UNIQUE,
    card_type VARCHAR(20),
    expiry_date DATE,
    cvv INT,
    account_id INT,
    FOREIGN KEY (account_id) REFERENCES Account(account_id)
);
