## About
This is the "single source of truth" that stores all my articles.

It utilizes [huantt/article-as-code](https://github.com/huantt/article-as-code) to collect, store, and sync all my articles to various platforms, including [dev.to](https://dev.to) and [hashnode.dev](https://hashnode.dev).

## GitHub Action
I have created a GitHub action in the `.github/workflows` directory that runs every 6 hours or whenever you commit to the `main` branch.

## My Recent Articles

<table>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/avoid-misunderstanding-on-delete-no-action-gcj">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/2027227/thumbnail?t=2024-11-16%2018%3a33%3a45.449557914%20%2b0000%20UTC%20m%3d%2b0.023498263" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/avoid-misunderstanding-on-delete-no-action-gcj">Avoid Misunderstanding ON DELETE NO ACTION</a>
                <div>Relational databases often provide several options for handling actions when a referenced row in a...</div>
                <div><i>06/10/2024</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/golang-understanding-unbuffered-and-buffered-channels-35bh">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/2000292/thumbnail?t=2024-11-16%2018%3a33%3a45.449557914%20%2b0000%20UTC%20m%3d%2b0.023498263" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/golang-understanding-unbuffered-and-buffered-channels-35bh">[Golang] Understanding Unbuffered and Buffered Channels</a>
                <div>Table of contents    Channel capacity Behavior Closed channel Receive-Only &amp;amp; Send-only...</div>
                <div><i>14/09/2024</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/snowflake-schema-vs-star-schema-pros-cons-and-use-cases-34p9">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1997485/thumbnail?t=2024-11-16%2018%3a33%3a45.449557914%20%2b0000%20UTC%20m%3d%2b0.023498263" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/snowflake-schema-vs-star-schema-pros-cons-and-use-cases-34p9">Snowflake Schema vs. Star Schema: Pros, Cons, and Use Cases</a>
                <div>Star Schema            Structure:     Central Fact Table: Contains quantitative data for...</div>
                <div><i>12/09/2024</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/postgres-isolation-levels-72h">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1997475/thumbnail?t=2024-11-16%2018%3a33%3a45.449557914%20%2b0000%20UTC%20m%3d%2b0.023498263" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/postgres-isolation-levels-72h">[Postgres] Isolation levels</a>
                <div>In PostgreSQL, isolation levels determine how transaction integrity is maintained when multiple...</div>
                <div><i>12/09/2024</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/acid-in-postgres-6h8">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1960352/thumbnail?t=2024-11-16%2018%3a33%3a45.449557914%20%2b0000%20UTC%20m%3d%2b0.023498263" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/acid-in-postgres-6h8">ACID in Postgres</a>
                <div>ACID is a set of properties that ensure reliable transactions in a database system. It stands for...</div>
                <div><i>15/08/2024</i></div>
            </td>
        </tr>
</table>

<div align="right">

*Updated at: 2024-11-16T18:33:45Z - by **[huantt/article-listing](https://github.com/huantt/article-listing)***

</div>


## Run Locally
The `docker-compose.yml` file helps us run the flow locally.

To run this Docker Compose, create a `.secret.txt` file and fill in the following variables:
- `DEVTO_TOKEN`: Your Dev.to authentication token.
- `DEVTO_USERNAME`: Your Dev.to username.
- `HASHNODE_TOKEN`: Your Hashnode authentication token.
- `HASHNODE_USERNAME`: Your Hashnode username.

Run the following command:
```shell
docker-compose up
```

## Sequence Diagram
```mermaid
sequenceDiagram
This repo ->> Dev.to: Get articles
Dev.to -->> This repo: Articles
This repo ->> This repo: Store articles as code
This repo ->> Dev.to: Sync articles
This repo ->> Hashnode.dev: Sync articles
This repo ->> Github: Commit
```