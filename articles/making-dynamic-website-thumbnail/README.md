
Look at this article's thumbnail; it's generated dynamically when this post receives new reactions or comments.

`UPDATE:` Dev.to has cached the image, so the thumbnail may not be up-to-date. You can view it here: [Link](https://dynamic-thumbnail-dev-to-e8hh.vercel.app/article/1606750/thumbnail).

In this article, I will show you how to implement this feature on your own website.

## 1. What is Og-Image?
The Open Graph protocol enables any web page to have richer content previews when shared on platforms like Facebook, Twitter, Telegram, and more.

To turn your web pages into graph objects, you need to add basic metadata to your page. 

`og:image` is a property that declares an image URL representing the preview image for your website. It should look like this:

```html
<meta property="og:image" content="https://ia.media-imdb.com/images/rock.jpg" />
```

GitHub is an example of using a dynamic thumbnail; when you share a repository, its thumbnail represents the "near" up-to-date stars, contributors, issues, and more.

To explore more Open Graph properties, visit this website: [Open Graph Protocol](https://ogp.me).

## 2. Use cases
- Generate thumbnails for thousands of articles or product pages automatically.
- Synchronize thumbnail designs.
- Raise awareness with your own thumbnail design featuring your brand.

## 3. How to Make Og-Image Dynamic

Traditionally, websites usually declare a fixed image for the `og:image` property.

To make it dynamic, you should replace this fixed image URL with an API endpoint that receives the identifier of each site (such as the article slug or profile ID) and then generates an image based on the received object identifier.

## 4. Approach #1 - Screenshot HTML
In the first version of `dynamic-thumbnail-service`, I used Puppeteer (a Node library that provides a high-level API to control headless Chrome or Chromium) to capture an HTML page and return it as an image.

The flow looks like this:
```
Article ID -> Service -> Generate HTML for thumbnail -> Capture HTML -> Return Image
```

This model is simple and easy to implement but has some drawbacks:
- Resource consumption: Because it uses a headless browser, it requires significant resources.
- Slow response: It must generate HTML and then capture it as an image, resulting in a slow response time, taking about 1-2 seconds for a request.

Source code: [dynamic-thumbnail-service-ts](https://github.com/huantt/dynamic-thumbnail-service-ts)

## 5. Approach #2 - Convert HTML to Image Directly

In this version, we no longer use Puppeteer to capture HTML and return images. Instead, we utilize the [@vercel/og](https://vercel.com/docs/functions/edge-functions/og-image-generation) library, which employs [Satori](https://github.com/vercel/satori) as its core engine. Satori is a library that converts HTML and CSS into SVG.

In this project, I use `Next.js` for implementation, which includes `@vercel/og` in its core, eliminating the need to import this library.

This approach makes the 2nd version of `dynamic-thumbnail-service-v2` up to 5 times faster than the previous one.

*Cons:*
- Satori currently supports a limited subset of HTML and CSS features. You can find the list of supported CSS features [here](https://github.com/vercel/satori#css).

Source code: [dynamic-thumbnail-service-v2](https://github.com/huantt/dynamic-thumbnail-service-v2)

## Usage
Run it in Docker:
```shell
docker run -p 3001:3000 huanttok/dynamic-thumbnail-service-v2:latest
```

Now the service is live at http://localhost:3001.

Try it out: `http://localhost:3001/article/thumbnail?title={TITLE}&author={AUTHOR}&avatar={AVATAR}`

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ghp2vnkxxtkbnbn6mzsp.png)

## Build Your Own
Feel free to fork this repository to implement your own design.

GitHub: [dynamic-thumbnail-service-v2](https://github.com/huantt/dynamic-thumbnail-service-v2)

{% github https://github.com/huantt/dynamic-thumbnail-service-v2 %}