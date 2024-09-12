In PostgreSQL, **isolation levels** determine how transaction integrity is maintained when multiple transactions occur concurrently. 

These levels control the visibility of changes made by other transactions and help prevent phenomena like dirty reads, non-repeatable reads, and phantom reads. 

## Why Isolation Levels Matter
- **Data Consistency**: Incorrect isolation levels can lead to inconsistent data states, such as dirty reads, lost updates, and phantom reads.
- **Performance**: Higher isolation levels often require more locking, which can impact performance.
- **Concurrency**: Lower isolation levels allow for greater concurrency but may introduce risks.

## Read Phenomena
Some isolation levels may encounter the following read phenomena. 
Understanding each of them and how to prevent them by using the appropriate isolation level is the purpose of this article.

- **Dirty Read**: Reading uncommitted changes from another transaction. *** (It's prevented in Postgres due to MVCC model)***
- **Non-repeatable Read**: The result of the same query within a transaction may vary due to changes made by other transactions that have been committed.
- **Phantom Read**: New rows are apeared or disapeard from a query result between 2 executions due to changes made by another transaction that is committed in between.

## Isolation levels
The following isolation level is sorted from lowest to higest:

### 1. **Read Uncommitted**
- In this level, a transaction can read uncommitted changes made by other transactions. However, PostgreSQL internally treats this level as **Read Committed**, meaning it does not allow dirty reads.
- **Phenomena**: Dirty reads are prevented in PostgreSQL, but non-repeatable reads and phantom reads may still occur.

### 2. **Read Committed**
- This is the default isolation level in PostgreSQL. 
- A transaction sees only the committed data at the start of each query within the transaction. It can’t see uncommitted changes from other transactions.
- **Phenomena**: Non-repeatable reads and phantom reads are possible, but dirty reads are prevented.

*Worth noting that we're mentioning the **"at the start of each query winthin transaction",** not the **"at the start of transaction"***.

### 3. **Repeatable Read**
- A transaction in this isolation level sees a consistent snapshot of the database taken when the transaction starts. No other transaction's changes are visible during the transaction, even if they commit.
- **Phenomena**: Prevents both dirty and non-repeatable reads, but phantom reads can still happen.

### 4. **Serializable**
- This is the strictest isolation level. It ensures that transactions execute in such a way that the outcome is as if they were executed one after the other, rather than concurrently. It effectively prevents all three phenomena (dirty reads, non-repeatable reads, and phantom reads).
- **Phenomena**: Prevents dirty reads, non-repeatable reads, and phantom reads, ensuring full transaction isolation.
