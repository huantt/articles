## About
This is the "single source of truth" that stores all my articles.

It utilizes [huantt/article-as-code](https://github.com/huantt/article-as-code) to collect, store, and sync all my articles to various platforms, including [dev.to](https://dev.to) and [hashnode.dev](https://hashnode.dev).

## GitHub Action
I have created a GitHub action in the `.github/workflows` directory that runs every 6 hours or whenever you commit to the `main` branch.

## My Recent Articles

<table>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/explaining-ab-testing-algorithm-50mf">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1645679/thumbnail?t=2023-10-26%2006%3a28%3a28.020964114%20%2b0000%20UTC%20m%3d%2b0.140049226" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/explaining-ab-testing-algorithm-50mf">Explaining A/B testing algorithm</a>
                <div>We are developing a crypto news aggregator Bitesapp.co. A few days ago, we implemented A/B testing...</div>
                <div><i>25/10/2023</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/understanding-the-weighted-random-algorithm-581p">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1644268/thumbnail?t=2023-10-26%2006%3a28%3a28.020964114%20%2b0000%20UTC%20m%3d%2b0.140049226" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/understanding-the-weighted-random-algorithm-581p">Understanding the Weighted Random Algorithm</a>
                <div>Imagine you have a collection of items, and each item has a different &#34;weight,&#34; or probability of...</div>
                <div><i>24/10/2023</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/migrate-redis-to-aws-elasticache-8bl">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1639841/thumbnail?t=2023-10-26%2006%3a28%3a28.020964114%20%2b0000%20UTC%20m%3d%2b0.140049226" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/migrate-redis-to-aws-elasticache-8bl">Migrate Redis to AWS ElastiCache</a>
                <div>How to Migrate Redis from One Server to Another   Starting from Redis version 5.0.0, Redis...</div>
                <div><i>19/10/2023</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/writing-resume-as-code-why-not-iab">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1632508/thumbnail?t=2023-10-26%2006%3a28%3a28.020964114%20%2b0000%20UTC%20m%3d%2b0.140049226" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/writing-resume-as-code-why-not-iab">Writing Resume as Code - Why not?</a>
                <div>Why I Developed Resume as Code   I&#39;ve explored various CV builder platforms over the...</div>
                <div><i>12/10/2023</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/showing-more-article-info-on-dailydev-277g">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1624491/thumbnail?t=2023-10-26%2006%3a28%3a28.020964114%20%2b0000%20UTC%20m%3d%2b0.140049226" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/showing-more-article-info-on-dailydev-277g">Showing more Article info on Daily.dev</a>
                <div>Daily.dev is a very good extension that helps us aggregate news from several sources.  When...</div>
                <div><i>05/10/2023</i></div>
            </td>
        </tr>
</table>

<div align="right">

*Updated at: 2023-10-26T06:28:28Z - by **[huantt/article-listing](https://github.com/huantt/article-listing)***

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