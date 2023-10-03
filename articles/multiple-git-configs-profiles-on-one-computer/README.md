## How to let git know which profile should be used in specific folders?

Imagine that you’re working for over one company. each company you have a different name, and a separate email address. Using a global git profile with your personal email address works, but GitLab won’t display your avatar correctly as your account email. So how to do that?

The include and includeIf sections allow you to include config directives from another source. So my idea is creating a separate folder for each environment (or company) and then using includeIf to let gitconfig including the correct config profile. Try it now!

## Step 1: Create a separate folder for each environment
`personal`: For personal projects
`google`: For Google projects
`facebook`: For Facebook projects

## Step 2: Create gitconfig file for each environment
You can create files anywhere with the following content:

**~/.gitconfig-personal**
```
[user]
	name = JackTT
	email = jacktt@gmail.com
```

**~/.gitconfig-google**
```
[user]
	name = JackTT
	email = jacktt@google.com
```

**~/.gitconfig-facebook***
```
[user]
	name = JackTT
	email = jacktt@facebook.com
```

## Step 3: Create the main gitconfig
Create `~/.gitconfig` file with the following content:

```
[includeIf "gitdir:/Volumes/Data/personal/"]
	path = ~/.gitconfig-personal
[includeIf "gitdir:/Volumes/Data/google/"]
	path = ~/.gitconfig-google
[includeIf "gitdir:/Volumes/Data/facebook/"]
        path = ~/.gitconfig-facebook

```

Now, cd to the personal folder then type “ git config user.email”, you can see jack@gmail.com. Try it in the google folder, you will see “jack@google.com”.

## References
https://git-scm.com/docs/git-config#_includes