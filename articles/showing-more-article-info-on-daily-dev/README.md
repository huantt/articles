![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/08up666l3xy6cjmtm404.png)

Daily.dev is a very good extension that helps us aggregate news from several sources.

When browsing news, I usually scan the `Title -> Thumbnail -> Description`. However, the current view of Daily.dev has only `Title` and `Thumbnail` in Grid view and only `Title` in Listing view. This requires me to click on an article to read more in a popup, which consumes more reading time.

Fortunately, Daily.dev is open source, so we can submit feature requests or even customize the design to suit our needs.

In this case, I have submitted a feature request on the [dailydev/apps](github.com/dailydotdev/apps) repository and also implemented a new design that can serve my needs. You can review my pull request here: [pull/2060](https://github.com/dailydotdev/apps/pull/2060).

They have mentioned that they need to pass this request to the Design team before reviewing my merge request or implementing a new UI.

In the meantime, you can pull my request, build it, and install it locally using these easy steps:

### Step 1: Clone my code
```bash
git clone --branch feat/show-more-metadata git@github.com:huantt/daily-dot-dev-apps.git
```

### Step 2: Build
```shell
pnpm install

cd packages/extension

pnpm run build:chrome
```

The output will be located at `packages/extension/dist/chrome`.

### Step 3: Install
- Open Chrome.
- Click the Extension button > Manage Extensions. Alternatively, you can enter the following URL directly: [chrome://extensions](chrome://extensions/).

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/9kv6vmzkhdq116iv3nrp.png)

- Enable `Developer Mode`.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/9dnk3z5gwvpedhgblcfp.png)

- Click on `Load unpacked`.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/dl2aj7i12nnkl5zkyy68.png)

- Point to `packages/extension/dist/chrome`.

Open a new tab, and you will see that all articles in Grid view or Listing View now have a Title, Description, and Thumbnail.


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/sq18fyzsadi5rrm4uls2.png)

I hope that it's helpful for you, and I also hope that Daily.dev releases a new UI soon.
{% github: github.com/huantt/daily-dot-dev-apps %}

