
## Compiling

```
build.sh
```
It will create the images like postgres-pgaudit:version(-alpine)?

## Minimal usage
```
  docker run \
    -e IS_AUDIT_LOG_ENABLED=true \
    -e PGAUDIT_LOG=ALL \
    -e POSTGRES_PASSWORD=test \
    -d --rm \
    postgres-pgaudit:12-alpine
```
## Policy templates
### PSQL settings

See ''postgresql.conf''.

### Audit everything by default
```sql
ALTER SYSTEM SET pgaudit.log='all';
ALTER SYSTEM SET pgaudit.log_catalog = 'on';
ALTER SYSTEM SET pgaudit.log_client = 'off';
ALTER SYSTEM SET pgaudit.log_level = 'log';
ALTER SYSTEM SET pgaudit.log_parameter = 'on';
ALTER SYSTEM SET pgaudit.log_relation = 'off';
ALTER SYSTEM SET pgaudit.log_statement_once = 'off';
ALTER SYSTEM SET pgaudit.role = 'auditor';
```
### Do not audit anything for service accounts
```sql
ALTER ROLE service_account SET pgaudit.log='none';
```
### Audit sensitive table reads
```sql
GRANT SELECT ON sensitive_table TO auditor;
```
### Audit sensitive field access on tableA
```sql
GRANT SELECT (sensitive_field) ON tableA TO auditor;
```
## Useful commands

Querying config file location:
```
psql$ show config_file;
```

Querying pgaudit policy:
```sql
SELECT rolname AS "Role", datname AS "Database", pg_catalog.array_to_string(setconfig, E'\n') AS "Settings"
FROM pg_db_role_setting AS s
LEFT JOIN pg_database ON pg_database.oid = setdatabase
LEFT JOIN pg_roles ON pg_roles.oid = setrole
WHERE pg_catalog.array_to_string(setconfig, E'\n') like 'pgaudit%'
ORDER BY 1, 2;
```
or ```\drds```
