## About
This is the "single source of truth" that stores all my articles.

It utilizes [huantt/article-as-code](https://github.com/huantt/article-as-code) to collect, store, and sync all my articles to various platforms, including [dev.to](https://dev.to) and [hashnode.dev](https://hashnode.dev).

## GitHub Action
I have created a GitHub action in the `.github/workflows` directory that runs every 6 hours or whenever you commit to the `main` branch.

## My Recent Articles

<table>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/kafka-dump-backup-restore-stream-40ai">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1740436/thumbnail?t=2024-03-15%2001%3a27%3a00.800529077%20%2b0000%20UTC%20m%3d%2b0.034119779" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/kafka-dump-backup-restore-stream-40ai">Kafka dump: backup, restore, stream,...</a>
                <div>Source code   Kafka dump           Kafka data backup   Kafka dump is a tool to back up and...</div>
                <div><i>24/01/2024</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/kafka-dump-backup-restore-stream-22hf">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1740117/thumbnail?t=2024-03-15%2001%3a27%3a00.800529077%20%2b0000%20UTC%20m%3d%2b0.034119779" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/kafka-dump-backup-restore-stream-22hf">Kafka dump: backup, restore, stream,...</a>
                <div>Source code   Kafka dump           Kafka data backup   Kafka dump is a tool to back up and...</div>
                <div><i>24/01/2024</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/saa-aws-storage-types-1noo">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1739612/thumbnail?t=2024-03-15%2001%3a27%3a00.800529077%20%2b0000%20UTC%20m%3d%2b0.034119779" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/saa-aws-storage-types-1noo">[SAA] AWS EBS, EFS and EC2 insntace storage</a>
                <div>EBS (a.k.a. Elastic Block Store)    They are bound to a specific AZ (in specific region) You...</div>
                <div><i>24/01/2024</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/kubernetes-scheduler-129i">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1715409/thumbnail?t=2024-03-15%2001%3a27%3a00.800529077%20%2b0000%20UTC%20m%3d%2b0.034119779" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/kubernetes-scheduler-129i">Kubernetes Scheduler</a>
                <div>I. Concepts            Node labels   When create a node, we can mark some labels for it. On...</div>
                <div><i>03/01/2024</i></div>
            </td>
        </tr>
        <tr>
            <td width="300px">
                <a href="https://dev.to/jacktt/multiple-git-configs-profiles-on-one-computer-2ik">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/1646687/thumbnail?t=2024-03-15%2001%3a27%3a00.800529077%20%2b0000%20UTC%20m%3d%2b0.034119779" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="https://dev.to/jacktt/multiple-git-configs-profiles-on-one-computer-2ik">Multiple git configs (profiles) on one computer</a>
                <div>How to let git know which profile should be used in specific folders?   Imagine that you’re...</div>
                <div><i>26/10/2023</i></div>
            </td>
        </tr>
</table>

<div align="right">

*Updated at: 2024-03-15T01:27:00Z - by **[huantt/article-listing](https://github.com/huantt/article-listing)***

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