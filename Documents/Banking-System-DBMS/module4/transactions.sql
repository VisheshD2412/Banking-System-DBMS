-- ============================================
-- TRANSACTION MANAGEMENT DEMONSTRATIONS
-- ============================================

-- Test 1: Successful Transaction with COMMIT
BEGIN TRANSACTION;
    UPDATE Accounts SET balance = balance - 500 WHERE account_id = 1001;
    UPDATE Accounts SET balance = balance + 500 WHERE account_id = 1002;
    INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date)
    VALUES (1001, 'WITHDRAWAL', 500, CURRENT_TIMESTAMP);
    INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date)
    VALUES (1002, 'DEPOSIT', 500, CURRENT_TIMESTAMP);
COMMIT;

-- Test 2: Failed Transaction with ROLLBACK
BEGIN TRANSACTION;
    UPDATE Accounts SET balance = balance - 100000 WHERE account_id = 1005;
    -- Check if sufficient balance
    IF (SELECT balance FROM Accounts WHERE account_id = 1005) < 0 THEN
        ROLLBACK;
        RAISE NOTICE 'Transaction rolled back: Insufficient funds';
    ELSE
        COMMIT;
    END IF;
COMMIT;

-- Test 3: Savepoint Demonstration
BEGIN TRANSACTION;
    UPDATE Accounts SET balance = balance - 1000 WHERE account_id = 1001;
    SAVEPOINT after_debit;
    
    UPDATE Accounts SET balance = balance + 1000 WHERE account_id = 1003;
    -- Error condition simulation
    IF (SELECT balance FROM Accounts WHERE account_id = 1001) < 1000 THEN
        ROLLBACK TO SAVEPOINT after_debit;
        RAISE NOTICE 'Rolled back to savepoint';
    END IF;
COMMIT;

-- Test 4: ACID Properties - Isolation Level
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;
    SELECT SUM(balance) FROM Accounts WHERE branch_id = 1;
    -- Prevents other transactions from modifying these rows
    UPDATE Accounts SET balance = balance * 1.05 WHERE branch_id = 1;
COMMIT;
