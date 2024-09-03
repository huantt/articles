## What is Multi-Version Concurrency Control
Multi-Version Concurrency Control (MVCC) is a database management technique that **ensures the consistency and isolation of transactions** in a database while allowing **concurrent access**. 

It addresses the limitations of traditional locking mechanisms, such as pessimistic concurrency control, by enabling multiple versions of data to coexist. This approach enhances system performance and user experience by reducing contention and allowing transactions to proceed without unnecessary waiting.

## How MVCC works

MVCC maintains multiple versions of each database item. 

When a transaction updates a data item, a new version of the item is created rather than overwriting the existing one. This allows read operations to access older versions of the data without waiting for the write operations to complete the new version.

Here's a simplified breakdown of how MVCC operates:

**1/ Read Operations:** When a transaction reads a data item, it retrieves the version of the item that was most recently committed before the transaction began. This guarantees a consistent view of the database without interference from other transactions.

**2. Write Operations:** When a transaction writes or updates a data item, it creates a new version. This new version is not visible to other transactions until the writing transaction commits, ensuring that no other transaction reads uncommitted changes (thus avoiding dirty reads).

**3/ Commit and Cleanup:** When a transaction commits, its changes become visible to other transactions. Older versions of data that are no longer needed (because no active transaction requires them) are eventually cleaned up, freeing up space and resources.

## Example
Let's consider the following scenario:
Given a product that has max quantity of 10.


![Image description](https://i.imgur.com/5cG4dWc.png)



At the same time, we have 2 concurrent transactions:
- 1. Count sales and get remaining items
- 2. Insert new sale and decrease remaining items


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/mslxh15jtpwqxg4fopea.png)


**Without MVCC and any locking mechanism**:
- While the first transaction is counting, it also counts the row inserted by the second transaction. The total count will be 4. 
- When getting the remaining product, because the second transaction has not finished the update, the first transaction will get 7 as the remaining quantity. 
- So, the total is 11. This number is incorrect because it counted the new sale but read the old remaining quantity.

**With MVCC:**
- Before starting the count, the first transaction uses M as the version for the related sales rows and N as the version for the product row. 
- In these version:
  + The related sales rows include only Row A, Row B, and Row C. Row D is not included, even though it was inserted in the second transaction (but has not been committed).
  + The product row has a remaining quantity of 6.
- Therefore, the result will be 3 for the count query and 7 for the remaining quantity. This is correct and consistent.
