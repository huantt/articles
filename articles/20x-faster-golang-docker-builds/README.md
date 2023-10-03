According to the Go command [documentation](https://pkg.go.dev/cmd/go#hdr-Build_and_test_caching):

_`"The go command caches build outputs for reuse in future builds."`_

This means that the first time you run go build will take the most time, but all subsequent times will use the cache to reduce building time.

## Dockerfile without caching
Let's take a look at this Dockerfile

```Dockerfile
FROM golang:1.21-bullseye as builder
WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN go build -o app

FROM ubuntu:22.04
RUN mkdir /app
WORKDIR /app
COPY --from=builder /app/app .
ENTRYPOINT ["./app"]
```

This Dockerfile is using 2 states:
- The first stage is responsible for downloading dependencies and building the binary app.
- The second state copy this binary app a clean Ubuntu image.

It did help us cache some layers when they are not changed.

But every time we build this image, Docker creates a new environment. This means that the go build command will rebuild without using the cache. The more dependencies included in this project, the longer the build process takes.

In my "Hello world!" example, it took 26s to complete the build process.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/nzeetfw5dtanqod1b0b2.png)



## Docker cache mount
Cache mounts let you specify a persistent package cache to be used during builds. The persistent cache helps speed up build steps, especially steps that involve installing packages using a package manager. Having a persistent cache for packages means that even if you rebuild a layer, you only download new or changed packages.

Cache mounts are created using the `--mount` flag together with the `RUN` instruction in the Dockerfile. To use a cache mount, the format for the flag is `--mount=type=cache,target=<path>`, where <path> is the location of the cache directory that you wish to mount into the container.

The Dockerfile after using the mount flag will look like:
```Dockerfile
FROM golang:1.21-bullseye as builder

WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
ENV GOCACHE=/root/.cache/go-build
RUN --mount=type=cache,target="/root/.cache/go-build" go build -o app

FROM ubuntu:22.04
RUN mkdir /app
WORKDIR /app
COPY --from=builder /app/app .
ENTRYPOINT ["./app"]
```


After applying mount cache, it took 1.2s to complete the build process.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/qa4f9cyqe2z6yb2ugzoz.png)


## References
- https://pkg.go.dev/cmd/go#hdr-Build_and_test_caching
- https://docs.docker.com/build/guide/mounts/