## About
This is the "single source of truth" that stores all my articles.

It utilizes [huantt/article-as-code](https://github.com/huantt/article-as-code) to collect, store, and sync all my articles to various platforms, including [dev.to](https://dev.to) and [hashnode.dev](https://hashnode.dev).

## GitHub Action
I have created a GitHub action in the `.github/workflows` directory that runs every 6 hours or whenever you commit to the `main` branch.

## My Recent Articles

<table>
    {{- range $i, $article := .Articles }}
        <tr>
            <td width="300px">
                <a href="{{$article.Url}}">
                    <img src="https://dynamic-thumbnail-dev-to.vercel.app/article/{{ $article.Id }}/thumbnail?t={{ $.Time }}" alt="thumbnail">
                </a>
            </td>
            <td>
                <a href="{{ $article.Url }}">{{ truncateByWords $article.Title 10 }}</a>
                <div>{{ $article.Description }}</div>
                <div><i>{{ formatDate $article.CreatedAt }}</i></div>
            </td>
        </tr>
    {{- end}}
</table>

<div align="right">

*Updated at: {{formatTime .Time}} - by **[huantt/article-listing](https://github.com/huantt/article-listing)***

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