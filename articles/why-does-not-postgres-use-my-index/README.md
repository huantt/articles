_This is a quick note_

## 1. Query Conditions Not Matching the Index
- The index is not on the columns being queried.
- The query does not use the leading columns of a composite index.
- The query is not written in a way that takes advantage of the index's order.
- The query uses functions or operations that prevent the use of the index (e.g., using functions like LOWER() on the column in the query).
- Data type mismatches between the column and the query can prevent index usage. Ensure that the data types match exactly.

## 2. Query Planner's Cost Estimates
- PostgreSQL's query planner estimates the cost of using the index and might decide that a sequential scan is cheaper.
- The statistics for the table are outdated or inaccurate, leading the planner to make suboptimal decisions. Running ANALYZE can help update these statistics.

## 3. Index Selectivity
The index is not selective enough. For example, if a column has many **duplicate values**, scanning the index might not save much time compared to a sequential scan.
