
== Compiling ==

```
build.sh
```
It will create the images like postgres-pgaudit:version(-alpine)?

== Minimal usage ==
```
  docker run \
    -e IS_AUDIT_LOG_ENABLED=true \
    -e PGAUDIT_LOG=ALL \
    -e POSTGRES_PASSWORD=test \
    -d --rm \
    postgres-pgaudit:12-alpine
```
== Useful commands ==

Querying config file location:
```
psql$ show config_file
```
