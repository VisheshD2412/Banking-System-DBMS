-- Sample Data for Banking System
-- Insert Branches
INSERT INTO Branches (branch_id, branch_name, city, address) VALUES
(1, 'Main Branch', 'New York', '123 Wall Street'),
(2, 'Downtown Branch', 'Los Angeles', '456 Sunset Blvd'),
(3, 'Tech Park Branch', 'San Francisco', '789 Silicon Valley');

-- Insert Customers
INSERT INTO Customers (customer_id, first_name, last_name, email, phone, address) VALUES
(101, 'John', 'Smith', 'john.smith@email.com', '555-0101', '100 Main St, NY'),
(102, 'Sarah', 'Johnson', 'sarah.j@email.com', '555-0102', '200 Oak Ave, LA'),
(103, 'Mike', 'Williams', 'mike.w@email.com', '555-0103', '300 Pine Rd, SF'),
(104, 'Emily', 'Brown', 'emily.b@email.com', '555-0104', '400 Elm St, NY'),
(105, 'David', 'Davis', 'david.d@email.com', '555-0105', '500 Maple Dr, LA');

-- Insert Accounts
INSERT INTO Accounts (account_id, customer_id, account_number, account_type, balance, branch_id) VALUES
(1001, 101, 'ACC100001', 'SAVINGS', 15000.00, 1),
(1002, 101, 'ACC100002', 'CHECKING', 5000.00, 1),
(1003, 102, 'ACC100003', 'SAVINGS', 25000.00, 2),
(1004, 103, 'ACC100004', 'CHECKING', 8000.00, 3),
(1005, 104, 'ACC100005', 'SAVINGS', 12000.00, 1),
(1006, 105, 'ACC100006', 'CHECKING', 3000.00, 2);

-- Insert Transactions
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES
(1, 1001, 'DEPOSIT', 5000.00, '2024-01-15 10:30:00'),
(2, 1001, 'WITHDRAWAL', 1000.00, '2024-01-20 14:15:00'),
(3, 1002, 'DEPOSIT', 3000.00, '2024-02-01 09:00:00'),
(4, 1003, 'DEPOSIT', 10000.00, '2024-02-10 11:30:00'),
(5, 1003, 'WITHDRAWAL', 500.00, '2024-02-15 16:45:00');

-- Insert Employees
INSERT INTO Employees (employee_id, branch_id, first_name, last_name, position, salary) VALUES
(201, 1, 'Robert', 'Taylor', 'Branch Manager', 75000.00),
(202, 1, 'Lisa', 'Anderson', 'Teller', 45000.00),
(203, 2, 'James', 'Thomas', 'Branch Manager', 72000.00);

-- Insert Loans
INSERT INTO Loans (loan_id, customer_id, loan_type, loan_amount, remaining_balance, status) VALUES
(301, 101, 'HOME', 250000.00, 200000.00, 'ACTIVE'),
(302, 103, 'AUTO', 35000.00, 25000.00, 'ACTIVE'),
(303, 104, 'PERSONAL', 10000.00, 5000.00, 'ACTIVE');
