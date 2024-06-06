_Imagine that we're developing an e-commerce website. In this case, we have a limited number of items while many users are trying to buy them at the same time. In this article, let's try to resolve this problem with some solutions_

### Database-Level Locking
_You can read this article beforehand to understand Pros an Cons of Optimistic lock & Pessimistic lock: [link](https://dev.to/jacktt/optimistic-lock-pessimistic-lock-4h36)_

#### Optimistic Locking

Optimistic locking operates on the premise that most database transactions do not conflict. It uses a versioning system to detect conflicts and resolve them without locking the entire database row.

**How It Works:**
1. Each item in the database has a version number.
2. When a user attempts to purchase an item, the current version number is checked.
3. If the version number hasn't changed during the transaction, the purchase is processed and the version number is updated.
4. If the version number has changed, indicating another transaction has modified the item, the current transaction must retry or fail. 

In this case, we can use `stock` field itself as the version of item.

**Implementation Example:**
```sql
UPDATE items 
SET stock = stock - 1
WHERE item_id = ? AND stock = ?;
```
This SQL statement ensures that the item is updated only if the stock value has not been changed.

#### Pessimistic Locking

With pessimistic locking, we lock the item for the duration of the transaction, preventing other transactions from updating it.

**How It Works:**
1. Begin a transaction.
2. Lock the item row.
3. Check the stock and perform the purchase if stock is available.
4. Commit the transaction.

**Implementation Example:**
```sql
BEGIN;
SELECT stock 
FROM items 
WHERE item_id = ? 
FOR UPDATE;
-- Check stock and update if available
UPDATE items 
SET stock = stock - 1 
WHERE item_id = ?;
COMMIT;
```
This approach locks the row when checking and updating the stock, preventing other transactions from interfering.

### Application-Level Handling

#### Distributed Locking

**How It Works:**
1. Acquire a distributed lock for the item when a user attempts to purchase it.
2. Perform the purchase operation while holding the lock.
3. Release the lock after the operation.

To implement this solution, we can use `SETNX` command, that returns 1 if acquire successfully and 0 if other one acquired. Don't forget to set expire time to prevent deadlock in case the owner of the lock crashes before releasing it.


### Combining Strategies

A robust solution often combines database and application-level strategies:
- Use optimistic or pessimistic locking to maintain immediate consistency in the database.
- Implement distributed locking for higher-level application logic.
