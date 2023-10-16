## About
This is the "single source of truth" that stores all my articles.

It utilizes [huantt/article-as-code](https://github.com/huantt/article-as-code) to collect, store, and sync all my articles to various platforms, including [dev.to](https://dev.to) and [hashnode.dev](https://hashnode.dev).

## GitHub Action
I have created a GitHub action in the `.github/workflows` directory that runs every 6 hours or whenever you commit to the `main` branch.

## My Recent Articles

<table>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/writing-resume-as-code-why-not-iab">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1632508/thumbnail?t=2023-10-16%2012%3a44%3a19.043837603%20%2b0000%20UTC%20m%3d%2b0.202405484" alt="thumbnail">
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
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1624491/thumbnail?t=2023-10-16%2012%3a44%3a19.043837603%20%2b0000%20UTC%20m%3d%2b0.202405484" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/showing-more-article-info-on-dailydev-277g">Showing more Article info on Daily.dev</a>
                <div>Daily.dev is a very good extension that helps us aggregate news from several sources.  When...</div>
                <div><i>05/10/2023</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/article-as-code-syncing-articles-between-devto-and-multiple-blogging-platforms-3hib">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1619274/thumbnail?t=2023-10-16%2012%3a44%3a19.043837603%20%2b0000%20UTC%20m%3d%2b0.202405484" alt="thumbnail">
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
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1610649/thumbnail?t=2023-10-16%2012%3a44%3a19.043837603%20%2b0000%20UTC%20m%3d%2b0.202405484" alt="thumbnail">
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
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1605751/thumbnail?t=2023-10-16%2012%3a44%3a19.043837603%20%2b0000%20UTC%20m%3d%2b0.202405484" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/why-i-like-writing-technical-blogs-11nm">Why I Like Writing Technical Blogs</a>
                <div>Requires me to delve further into the topic   It forces me to learn more deeply about the...</div>
                <div><i>20/09/2023</i></div>
            </td>
        </tr>
</table>

<div align="right">

*Updated at: 2023-10-16T12:44:19Z - by **[huantt/article-listing](https://github.com/huantt/article-listing)***

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