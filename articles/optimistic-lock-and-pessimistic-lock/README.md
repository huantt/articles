## Pessimistic lock
- Lock
- READ
- UPDATE
- Unlock

Example:

```sql
START TRANSACTION;

-- Select the product row for update
SELECT * FROM products WHERE product_id = 1 FOR UPDATE;

-- Perform operations on the selected data
UPDATE products 
SET price = 1200,
  version = version + 1
WHERE product_id = 1;

-- Commit the transaction
COMMIT;
```

**PROs:**
- Prevents conflicts.
- Ensures data integrity.
- Suitable for high contention.

**CONs:**
- Decreased throughput.
- Increased deadlock risk.
- Reduced responsiveness.

**Use Case:**
Pessimistic locking is often employed in scenarios where conflicts are likely or must be avoided, such as:
- Banking systems where transactions involving account balances must be processed serially.
- Reservation systems where concurrent bookings for the same resource must be prevented.

## Optimistic lock
- READ
- LOCK
- UPDATE
- UNLOCK

Example:

```sql
-- Check current version of the product
SELECT version FROM products WHERE product_id = 1;

-- Update product price (assuming version 1)
UPDATE products
SET price = 1200.00,
    version = version + 1
WHERE product_id = 1 AND version = 1;

-- Retry if update count is zero
```

**PROs:**
- Minimal performance impact.
- Allows concurrent access.
- Suitable for infrequent conflicts.

**CONs:**
- Risk of conflicts.
- Requires conflict resolution. (retry)
- Not ideal for high contention.

#### Use Case
Optimistic locking is commonly used in scenarios where the likelihood of conflicts is low, such as:

- Content management systems where users rarely edit the same document simultaneously.
- E-commerce platforms where product prices are updated infrequently.
