In this article, I'll share you how to update your latest articles on dev.to into your Github profile.
[![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/xrh12lkov7a8hn4qq6hq.png)
](https://github.com/huantt/article-listing)
## What is Github profile
GitHub will display your profile README on your profile page if all of the following are true.

- You've created a repository with a name that matches your GitHub username.
- The repository is public.
- The repository contains a file named README.md in its root.
- The README.md file contains any content.

## How to update articles into your repository
Follow the same approach as outlined in my previous article, [Creating a Dynamic README.md File](https://dev.to/jacktt/creating-dynamic-readmemd-file-388o), I have recently developed another GitHub Action for updating your `dev.to` articles on your GitHub profile.

To do that, let's follow these straightforward steps:

**Step 1:** In your repository, create a file named `README.md.template`.

**Step 2:** Write anything you want within the `README.md.template` file.

**Step 3:** Embed one of the following entities within your `README.md.template`:

- **Article listing:**
```shell
{{ template "article-list" .Articles }}
```

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/fzo7n5q6g462efwtk2ut.png)


- **Article table:**
```shell
{{ template "article-table" .Articles }}
```

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/xrh12lkov7a8hn4qq6hq.png)


If you are familiar with Go templates, you have access to the `root` variable, which includes the following fields:

- `Articles`: An array of Article. You can view the Article struct definition in [model/article.go](model/article.go).
- `Time`: Updated Time

**Step 4**: Register Github Action
- Create a file `.github/workflows/update-articles.yml` in your repository.
```yml
name: "Cronjob"
on:
 schedule:
  - cron: '15 0 * * *'

jobs:
    update-articles:
        permissions: write-all
        runs-on: ubuntu-latest
        steps:
            - uses: actions/checkout@v3
            - name: Generate README
              uses: huantt/article-listing@v1.1.0
              with:
                username: YOUR_USERNAME_ON_DEV_TO                
                template-file: 'README.md.template'
                out-file: 'README.md'
                limit: 5
            - name: Commit
              run: |
                git config user.name github-actions
                git config user.email github-actions@github.com
                git add .
                git commit -m "update articles"
                git push origin main
```

**Step 5**: Commit your change, then Github actions will run as your specified cron to update Articles into your README.md file

## Source Code
See the source code and an example here: https://github.com/huantt/article-listing

## Reference
- https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-github-profile/customizing-your-profile/managing-your-profile-readme