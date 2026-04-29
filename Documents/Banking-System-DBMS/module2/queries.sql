-- ============================================
-- BANKING SYSTEM - COMPLEX QUERIES
-- ============================================

-- Query 1: Customer Transaction Summary with Account Details
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    a.account_type,
    a.account_number,
    COUNT(t.transaction_id) AS total_transactions,
    SUM(CASE WHEN t.transaction_type = 'DEPOSIT' THEN t.amount ELSE 0 END) AS total_deposits,
    SUM(CASE WHEN t.transaction_type = 'WITHDRAWAL' THEN t.amount ELSE 0 END) AS total_withdrawals,
    a.balance AS current_balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
LEFT JOIN Transactions t ON a.account_id = t.account_id
GROUP BY c.customer_id, c.first_name, c.last_name, a.account_type, 
         a.account_number, a.balance
ORDER BY total_deposits DESC;

-- Query 2: Monthly Transaction Volume Analysis
SELECT 
    EXTRACT(YEAR FROM transaction_date) AS year,
    EXTRACT(MONTH FROM transaction_date) AS month,
    transaction_type,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    AVG(amount) AS avg_transaction_amount,
    MAX(amount) AS max_transaction,
    MIN(amount) AS min_transaction
FROM Transactions
GROUP BY EXTRACT(YEAR FROM transaction_date), 
         EXTRACT(MONTH FROM transaction_date), 
         transaction_type
ORDER BY year DESC, month DESC, transaction_type;

-- Query 3: High-Value Customer Identification
WITH CustomerTotalBalance AS (
    SELECT 
        c.customer_id,
        c.first_name || ' ' || c.last_name AS full_name,
        SUM(a.balance) AS total_balance,
        COUNT(a.account_id) AS account_count
    FROM Customers c
    JOIN Accounts a ON c.customer_id = a.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
),
AverageBalance AS (
    SELECT AVG(total_balance) AS avg_balance
    FROM CustomerTotalBalance
)
SELECT 
    ctb.full_name,
    ctb.total_balance,
    ctb.account_count,
    ROUND((ctb.total_balance - ab.avg_balance) / ab.avg_balance * 100, 2) 
        AS percent_above_average
FROM CustomerTotalBalance ctb
CROSS JOIN AverageBalance ab
WHERE ctb.total_balance > ab.avg_balance
ORDER BY ctb.total_balance DESC;

-- Query 4: Branch Performance Metrics
SELECT 
    b.branch_id,
    b.branch_name,
    b.city,
    COUNT(DISTINCT e.employee_id) AS employee_count,
    COUNT(DISTINCT a.account_id) AS accounts_managed,
    SUM(a.balance) AS total_deposits,
    AVG(a.balance) AS avg_account_balance,
    COUNT(DISTINCT t.transaction_id) AS transaction_volume
FROM Branches b
LEFT JOIN Employees e ON b.branch_id = e.branch_id
LEFT JOIN Accounts a ON b.branch_id = a.branch_id
LEFT JOIN Transactions t ON a.account_id = t.account_id
GROUP BY b.branch_id, b.branch_name, b.city
ORDER BY total_deposits DESC;

-- Query 5: Loan Default Risk Analysis
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(l.loan_id) AS active_loans,
    SUM(l.loan_amount) AS total_loan_amount,
    SUM(l.remaining_balance) AS total_outstanding,
    SUM(a.balance) AS total_savings,
    ROUND((SUM(l.remaining_balance) / NULLIF(SUM(a.balance), 0)) * 100, 2) 
        AS debt_to_savings_ratio,
    CASE 
        WHEN SUM(l.remaining_balance) > SUM(a.balance) * 2 THEN 'HIGH RISK'
        WHEN SUM(l.remaining_balance) > SUM(a.balance) THEN 'MEDIUM RISK'
        ELSE 'LOW RISK'
    END AS risk_category
FROM Customers c
JOIN Loans l ON c.customer_id = l.customer_id
LEFT JOIN Accounts a ON c.customer_id = a.customer_id
WHERE l.status = 'ACTIVE'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(l.loan_id) > 0
ORDER BY debt_to_savings_ratio DESC;
