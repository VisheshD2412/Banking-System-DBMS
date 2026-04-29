-- ============================================
-- CONCURRENCY CONTROL DEMONSTRATIONS
-- ============================================

-- Session 1: Lock with NOWAIT
BEGIN TRANSACTION;
SELECT * FROM Accounts WHERE account_id = 1001 FOR UPDATE NOWAIT;
-- This session holds the lock
-- Run Session 2 in another terminal to demonstrate NOWAIT
COMMIT;

-- Session 2: Will fail immediately if lock is held
BEGIN TRANSACTION;
SELECT * FROM Accounts WHERE account_id = 1001 FOR UPDATE NOWAIT;
-- ERROR: could not obtain lock
ROLLBACK;

-- Deadlock Prevention Example
-- Session 1
BEGIN TRANSACTION;
UPDATE Accounts SET balance = balance - 100 WHERE account_id = 1001;
-- Session 2 (in another terminal)
BEGIN TRANSACTION;
UPDATE Accounts SET balance = balance - 100 WHERE account_id = 1002;
-- Session 1 tries to update account 1002
UPDATE Accounts SET balance = balance + 100 WHERE account_id = 1002;
-- This will wait or deadlock depending on the DBMS
COMMIT;
