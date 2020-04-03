# SQL

This gist mainly use PostgreSQL database for examples.

## SELECT

```
SELECT * FROM tbl
```

```
SELECT c1,c2 FROM tbl
WHERE conditions
ORDER BY c1 ASC, cs DESC
```

```
SELECT DISTINCT c1,c2
FROM tbl
```

```
SELECT c1,aggregate(expr)
FROM tbl
GROUP BY c1
```

```
SELECT c1,aggregate(expr) AS c2
FROM tbl
GROUP BY c1
HAVING c2>val
```

## UPDATE

```
INSERT INTO tbl(c1,c2,...)
VALUES(v1,v2,...)
```

```
INSERT INTO tbl(c1,c2,...)
SELECT c1,c2,... FROM tbl2
WHERE conditions
```

```
DELETE FROM tbl2WHERE conditions
```

```
TRUNCATE TABLE tbl
```

## TABLE

```
CREATE TABLE tbl(
  c1 type(length)
  c2 type(length)
  ...
  PRIMARY KEY(c1)
)
```

```
DROP TABLE tbl
```

```
ALTER TABLE tbl
ADD COLUMN c1 type(length)
```

```
ALTER TABLE tbl
DROP COLUMN c1
```

## JOIN

```
SELECT * FROM tbl1
INNER JOIN tbl2 ON join-conditions
```

```
SELECT * FROM tbl1
LEFT JOIN tbl2 ON join-conditions
```

```
SELECT * FROM tbl1
FULL OUTER JOIN tbl2 ON join-conditions
```
