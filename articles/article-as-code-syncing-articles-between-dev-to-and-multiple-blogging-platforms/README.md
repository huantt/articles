In the world of content creation, each platform offers unique advantages. Publishing articles on various platforms helps us expand our audience. However, managing and synchronizing your articles across multiple platforms can become a tedious task.

To address this need, I've developed an application called "Article as Code," which boasts several key features:

- Collects articles from your blog and stores them on GitHub as a "source of truth".
- Synchronizes all articles located in the repository to all your desired platforms.
- Allows you to write new articles by committing directly to this repository.

## Setup your own AAC

### Step 1: Create A New Github Repo

### Step 2: Create Github Action Secretes

```
Go to Repo > Setting > Secrets and Variables > Actions > New repository secrete
```

You will need to create the following secrets:

- `DEVTO_TOKEN`: Your Dev.to authentication token.
- `DEVTO_USERNAME`: Your Dev.to username.
- `HASHNODE_TOKEN`: Your Hashnode authentication token.
- `HASHNODE_USERNAME`: Your Hashnode username.

### Step 2: Schedule sync process

To automate the synchronization process, we'll set up a GitHub Action workflow. Create a new file named `.github/workflows/cronjob.yml` in your repository with the following contents:


```yml
name: "Cronjob"
on:
  schedule:
    - cron: '15 */6 * * *'
  push:
    branches:
      - 'main'

jobs:
  sync:
    permissions: write-all
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-go@v4
        with:
          go-version: '1.21.0'
      - name: Prepare
        run: export PATH=$PATH:$(go env GOPATH)/bin
      - name: Install
        run: go install github.com/huantt/article-as-code@v1.0.3
      - name: Collect
        run: |
          article-as-code collect \
          --username=${{ secrets.DEVTO_USERNAME }} \
          --article-folder=articles
      - name: Sync to dev.to
        run: |
          article-as-code sync \
          --username=${{ secrets.DEVTO_USERNAME }} \
          --auth-token=${{ secrets.DEVTO_TOKEN }} \
          --article-folder=articles \
          --destination="dev.to"
      - name: Sync to hashnode.dev
        run: |
          article-as-code sync \
          --username=${{ secrets.DEVTO_USERNAME }} \
          --auth-token=${{ secrets.HASHNODE_USERNAME }} \
          --article-folder=articles \
          --destination="hashnode.dev"
      - name: Commit
        run: |
          if git diff --exit-code; then
            echo "No changes to commit."
            exit 0
          else
            git config user.name github-actions
            git config user.email github-actions@github.com
            git add .
            git commit -m "update"
            git push origin main
          fi

```
This GitHub Action will run every 6 hours or whenever you push a new commit to the main branch. Here's what it does:

1. Collect all your articles from dev.to then store into the `articles` folder.

2. Sync articles to dev.to 
_(In this case, it's redundant, but it will cover the scenario when you write a new article by committing directly to this repository.)_

3. Sync articles to hashnode.dev

## References
- See my complete repository here: 
{% github: https://github.com/huantt/articles %}
- Source code: 
{% github: https://github.com/huantt/article-as-code %}

_`I will appreciate it if you contribute to support other platforms.`_