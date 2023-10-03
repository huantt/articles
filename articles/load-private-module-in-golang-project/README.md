Load Private Module in Golang Project


## Table of Contents

- [I. How Does go get Work?](#i-how-does-go-get-work)
- [II. How to Load Private Modules](#ii-how-to-load-private-modules)
- [III. Build Docker Image](#iii-build-docker-image)
- [IV. Run it on gitlab-ci](#iv-run-it-on-gitlab-ci)
- [V. Additional Resources](#v-additional-resources)
- [VI. References](#vi-references)

## I. How Does go get Work?

Before we delve into the process of obtaining private Go modules, let's first take a look at how the `go get` command functions within the Go ecosystem. To illustrate this, we will perform a simple test:

**1. Create Your Own Private Module:**
Assume you have a private module hosted on a version control system (VCS) repository, such as `gitlab.com`. This private module contains code that you want to use in your Go project.

**2. Trying to Get This Module on Your Machine:**
In a typical scenario, you might expect to be able to use the `go get` command to fetch the private module since your machine has the necessary permissions. However, you might encounter an unexpected challenge.


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/sc4a458aol7vqu7a8uhu.png)


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ywb5g7pqfph41jujok1l.png)


When you run `go get {module}`, the Go tooling, by default, attempts to fetch the module from a public Go proxy. If the module is not found there, it will then fall back to attempting to pull from the public repository associated with the module. If the module is still not found or you do not have the necessary permissions to access the private module, you will encounter an error.

## II. How to Load Private Modules

To load a private module from a specific environment, you can follow the steps below:

### 1. Specifying Private Modules

Let Go Know Which Modules Are Private to Load Directly.

To address this issue, Go provides the `GOPRIVATE` environment variable. This variable allows you to specify a pattern for module paths that should be considered private. When a module path matches the patterns specified in `GOPRIVATE`, the Go tooling will attempt to fetch the module directly from the source repository rather than relying solely on public proxies.

For example, to mark the `gitlab.com` domain as private, you can set the `GOPRIVATE` variable like so:

```bash
go env -w GOPRIVATE='gitlab.com/*'
```

To verify the result, you can run:

```bash
go env | grep GOPRIVATE
```

### 2. Configuring Credentials

To access private modules, you may need to configure credentials for authentication. There are several ways to achieve this:

**Use SSH:**
You can configure Git to use SSH for authentication when fetching private modules. To do this, run the following command:

```bash
git config --global url."ssh://git@gitlab.com".insteadOf "https://gitlab.com"
```

**Configure Basic Authentication for HTTPS:**

- **.netrc File in Linux:**
The `.netrc` file is used to store credentials for various applications. To configure basic authentication for accessing private modules, create or update the `.netrc` file:

```bash
echo "machine gitlab.com login $GITLAB_USERNAME password $GITLAB_TOKEN" > ~/.netrc
```

`Note: You should create an Access token for it instead of using your password`

## III. Build Docker Image

If you need to build a Docker image for your project that imports private modules, let's see my Dockerfile example:

```Dockerfile
# Stage 1: Building the Application
FROM golang:1.21 as builder

# Pass build-time arguments for Git credentials
ARG GIT_USER
ARG GIT_TOKEN

# Set GOPRIVATE to specify private module pattern
RUN go env -w GOPRIVATE='gitlab.com/*'

# Set up authentication credentials using .netrc
RUN echo "machine gitlab.com login $GIT_USER password $GIT_TOKEN" > ~/.netrc

# Set the working directory
WORKDIR /app

# Copy go.mod and go.sum to enable efficient dependency fetching
COPY go.mod .
COPY go.sum .

# Download project dependencies
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the application binary
RUN go build -o app

# Stage 2: Creating the Final Minimal Image
FROM ubuntu:20.04

# Set the working directory
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/app .

# Define the command to run the application
CMD ["./app"]
```

In this Dockerfile example, we've divided the process into two stages for clarity and optimization:

**1. Building the Application (`builder` stage):**

This stage is responsible for fetching dependencies, compiling the application, and preparing it for execution. It utilizes build-time arguments (`GIT_USER` and `GIT_TOKEN`) to configure authentication credentials for accessing private modules. The `GOPRIVATE` environment variable is set to ensure that private modules are fetched correctly. The `~/.netrc` file is used to store authentication credentials securely.

**2. Creating the Final Minimal Image:**

In this stage, we copy the compiled binary (`app`) from the `builder` stage into this final image. This image does not hold credentials.

### Building the Docker Image:

To build the Docker image using the provided Dockerfile, you can use the following command:

```bash
docker build \
--build-arg GIT_USER=jack \
--build-arg GIT_TOKEN='{YOUR_TOKEN}' \
-t my-golang-app .
```

Replace `{YOUR_TOKEN}` with your actual Git token. This command sets the build-time arguments `GIT_USER` and `GIT_TOKEN` to provide the required authentication credentials during the image build process.

## IV. Run it on gitlab-ci

So how to pass credentials into build time when using `gitlab-ci`?

**1. Configure your credentials in Repo/Group Variables:**

You can configure `GIT_USER` and `GIT_TOKEN` in CI/CD Variables:

Your repo OR Group > Settings > CI/CD > Variables > Add Variable

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/xjya1s3f2hyx4ynp1blr.png)

**2. Write gitlab-ci.yml:**

Now, you can access these variables in gitlab-ci:

```yml
stages:
  - build

build-docker:
  stage: build
  script:
    - docker build --build-arg GIT_USER=$GIT_USER --build-arg GIT_TOKEN=$GIT_TOKEN -t gitlab.com/jack/my-app .
    - docker push gitlab.com/jack/my-app
```

## V. Additional Resources

Depending on your objectives and the scale of your company, it's prudent to consider suitable models. Explore the array of options described in this article: [Link](https://www.sobyte.net/post/2022-03/private-go-module/)

## VI. References

- [Go Module Proxies](https://www.practical-go-lessons.com/chap-18-go-module-proxies)
- [Private Go Modules Article](https://www.sobyte.net/post/2022-03/private-go-module/)