## About
This is the "single source of truth" that stores all my articles.

It utilizes [huantt/article-as-code](https://github.com/huantt/article-as-code) to collect, store, and sync all my articles to various platforms, including [dev.to](https://dev.to) and [hashnode.dev](https://hashnode.dev).

## GitHub Action
I have created a GitHub action in the `.github/workflows` directory that runs every 6 hours or whenever you commit to the `main` branch.

## My Recent Articles

<table>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/search-goole-like-a-pro-cheat-sheet-4f53">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1846654/thumbnail?t=2024-05-21%2012%3a43%3a37.171565439%20%2b0000%20UTC%20m%3d%2b0.071175095" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/search-goole-like-a-pro-cheat-sheet-4f53">Search Goole Like a Pro [Cheat sheet]</a>
                <div>Before reading my article, let&#39;s try searching the following input:    inurl:/jacktt/ site:dev.to    ...</div>
                <div><i>08/05/2024</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/advanced-go-build-techniques-4fk1">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1846653/thumbnail?t=2024-05-21%2012%3a43%3a37.171565439%20%2b0000%20UTC%20m%3d%2b0.071175095" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/advanced-go-build-techniques-4fk1">Advanced Go Build Techniques</a>
                <div>Table of contents   Build options Which file will be included Build tags Build contraints           ...</div>
                <div><i>08/05/2024</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/search-goole-like-a-pro-cheat-sheet-536m">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1846357/thumbnail?t=2024-05-21%2012%3a43%3a37.171565439%20%2b0000%20UTC%20m%3d%2b0.071175095" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/search-goole-like-a-pro-cheat-sheet-536m">Search Goole Like a Pro [Cheat sheet]</a>
                <div>Before reading my article, let&#39;s try searching the following input:    inurl:/jacktt/ site:dev.to    ...</div>
                <div><i>08/05/2024</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/advanced-go-build-techniques-29ef">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1846356/thumbnail?t=2024-05-21%2012%3a43%3a37.171565439%20%2b0000%20UTC%20m%3d%2b0.071175095" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/advanced-go-build-techniques-29ef">Advanced Go Build Techniques</a>
                <div>Table of contents   Build options Which file will be included Build tags Build contraints           ...</div>
                <div><i>08/05/2024</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/solidity-concepts-1p85">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1844657/thumbnail?t=2024-05-21%2012%3a43%3a37.171565439%20%2b0000%20UTC%20m%3d%2b0.071175095" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/solidity-concepts-1p85">Solidity concepts</a>
                <div>Concept / Keyword Description     Visibility Specifies the accessibility of functions and state...</div>
                <div><i>07/05/2024</i></div>
            </td>
        </tr>
</table>

<div align="right">

*Updated at: 2024-05-21T12:43:37Z - by **[huantt/article-listing](https://github.com/huantt/article-listing)***

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