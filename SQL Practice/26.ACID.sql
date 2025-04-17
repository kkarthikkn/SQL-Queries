# ACID : Atomicity Consistency Isolation Durability


-- ****************************************************************************************************

1. Atomicity — All steps in a transaction succeed or none do

If a transaction has multiple steps, either all succeed or all fail.
Ex: Transferring money — debit from one account, credit to another. If one fails, both should roll back.

-- ****************************************************************************************************

2. Consistency —  Data must stay valid before and after a transaction

The database should always follow defined rules (constraints, data types).
Ex: Two people could book the same seat in bookin apps

-- ****************************************************************************************************

3. Isolation —  Transactions run independently from each other

Transactions shouldn’t interfere with each other.
Ex: If two users update the same row at the same time, isolation prevents conflict or dirty reads.

-- ****************************************************************************************************

4. Durability — Once committed, changes are saved permanently

Once you COMMIT a transaction, the data is permanently saved — even if the system crashes right after.
Ex: Successfully book a ticket, even if system crashes afterward — no data loss.

