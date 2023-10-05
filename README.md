## About
This is the "single source of truth" that stores all my articles.

It utilizes [huantt/article-as-code](https://github.com/huantt/article-as-code) to collect, store, and sync all my articles to various platforms, including [dev.to](https://dev.to) and [hashnode.dev](https://hashnode.dev).

## GitHub Action
I have created a GitHub action in the `.github/workflows` directory that runs every 6 hours or whenever you commit to the `main` branch.

## My Recent Articles

<table>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/article-as-code-syncing-articles-between-devto-and-multiple-blogging-platforms-3hib">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1619274/thumbnail?t=2023-10-05%2001%3a50%3a24.137130946%20%2b0000%20UTC%20m%3d%2b0.040925219" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/article-as-code-syncing-articles-between-devto-and-multiple-blogging-platforms-3hib">[Article as Code] Syncing Articles Between Dev.to and Multiple Blogging...</a>
                <div>In the world of content creation, each platform offers unique advantages. Publishing articles on...</div>
                <div><i>03/10/2023</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/20x-faster-golang-docker-builds-289n">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1610649/thumbnail?t=2023-10-05%2001%3a50%3a24.137130946%20%2b0000%20UTC%20m%3d%2b0.040925219" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/20x-faster-golang-docker-builds-289n">20X Faster Golang Docker Builds</a>
                <div>According to the Go command documentation:  &#34;The go command caches build outputs for reuse in future...</div>
                <div><i>25/09/2023</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/why-i-like-writing-technical-blogs-11nm">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1605751/thumbnail?t=2023-10-05%2001%3a50%3a24.137130946%20%2b0000%20UTC%20m%3d%2b0.040925219" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/why-i-like-writing-technical-blogs-11nm">Why I Like Writing Technical Blogs</a>
                <div>Requires me to delve further into the topic   It forces me to learn more deeply about the...</div>
                <div><i>20/09/2023</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/makding-dynamic-website-thumbnail-412k">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1606750/thumbnail?t=2023-10-05%2001%3a50%3a24.137130946%20%2b0000%20UTC%20m%3d%2b0.040925219" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/makding-dynamic-website-thumbnail-412k">Making Dynamic Website Thumbnail</a>
                <div>Look at this article&#39;s thumbnail; it&#39;s generated dynamically when this post receives new reactions or...</div>
                <div><i>21/09/2023</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/survey-automatic-table-of-contents-in-devto-articles-4m1g">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1605720/thumbnail?t=2023-10-05%2001%3a50%3a24.137130946%20%2b0000%20UTC%20m%3d%2b0.040925219" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/survey-automatic-table-of-contents-in-devto-articles-4m1g">[Survey] Automatic Table of Contents in Dev.to Articles</a>
                <div>If you&#39;re an avid reader on Dev.to, you might have come across articles that feature a table of...</div>
                <div><i>20/09/2023</i></div>
            </td>
        </tr>
</table>

<div align="right">

*Updated at: 2023-10-05T01:50:24Z - by **[huantt/article-listing](https://github.com/huantt/article-listing)***

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