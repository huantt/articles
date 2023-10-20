## How to Migrate Redis from One Server to Another

Starting from Redis version 5.0.0, Redis supports the `REPLICAOF` command, which assists in migrating data by making the destination Redis server a replica of the source Redis server. You can perform this migration with just a few simple steps:

**Step 1**: Make the destination Redis server a replica of the source Redis server by running the following command:
```shell
REPLICAOF host port
```

**Step 2**: Transform the destination Redis server into a master server by executing the following command:
```shell
REPLICAOF NO ONE
```

That's it!

## AWS ElastiCache does not support REPLICAOF
When migrating Redis, we encountered a struggle as `AWS Elasticache` restricts access to certain commands, including `"MIGRATE"` and `"REPLICAOF"`.

## Solution
I discovered a repository written in Go that helped us address this issue by running a one-time application.
It appeared promising, but it hadn't been updated for several years. I identified some problems:
- It used LPOP, which resulted in the removal of list elements from the "From Redis Instance."
- It ran in a single thread, causing significant delays in migrating large records.
- It did not support certain key types, including Set and SortedSet.

I forked the repository and made the necessary fixes & improvements. 

## Usage
**Step 1**: Create config file
`config.yaml`
```yaml
old_redis:
  host: localhost # IP redis server
  port: 6379 # Port redis server
  password: "" # Password of redis server, leave empty if there is no password

new_redis:
  host: localhost
  port: 6380
  password: ""

migration_databases: [0,1,2,3,4,5,6,7,8] # Databases list which needs to be migrated
concurrent_workers: 5
clear_before_migration: true
```

**Step 2**: Run using Docker

```shell
docker run \
--rm \
-v /path/to/config.yaml:/data/config.yaml \
 huanttok/redis-migrator migrate \
 --config.file=/data/config.yaml \
--log.level=debug
```

(_To call `localhost` while using Docker, use `host.docker.internal` instead._

## Source code
{% github: https://github.com/huantt/redis-migrator %}
