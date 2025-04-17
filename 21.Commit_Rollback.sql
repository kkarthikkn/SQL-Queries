# Commit & Rollback: Both are the part of TCL( Transaction Control Language )

--  COMMIT  -	Saves the changes permanently to the database ✅ [ SAVE ]
-- ROLLBACK -	Cancels changes made in the transaction ❌ [ UNDO ]


drop table if exists accounts;
CREATE TABLE Accounts (
  AccountID INT PRIMARY KEY,
  AccountHolder VARCHAR(100),
  Balance DECIMAL(10,2)
);

INSERT INTO Accounts (AccountID, AccountHolder, Balance)
VALUES (1, 'Alice', 5000.00),
	  (2, 'Bob', 8500.00);
       
start transaction; -- begins a new transaction in SQL — a temporary session where you can run multiple changes
-- OR 
begin; 


SET autocommit = 0;  -- Some databases auto-commits by default. So, it's better to disable

update accounts
set balance=balance-8000 
where accountid=2;

select * from accounts;
rollback;

select * from accounts;
commit;

# NOTE: Once commit is done, then it cannot be rollback. It Saves Permanently, So Make sure the changes