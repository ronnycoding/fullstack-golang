# Shipeasecommerce carrier service for multistore monorepo



## Migration
- create a new migration
```bash
$ npm run migration create add_some_column sql
$ Created new file: 20170506082420_add_some_column.sql
```

- Apply all available migrations.
```bash
$ npm run migration up
$ OK    001_basics.sql
$ OK    002_next.sql
```

- Roll back a single migration from the current version.
```bash
$ npm run migration down
$ OK    002_next.sql
```