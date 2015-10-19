# A compile-time checker for PostgreSQL syntax

*(Based on https://github.com/sfackler/rust-postgres-macros)*

This module implements a quasiquoter that links against the postgres
query parser.

If the query parses OK the quoter returns the query unmodified. A
syntactically invalid query will not compile.

Note that this only check syntax, not semantics.

## Example

```haskell
print ([psql|
    select a, b, c
    from hello, hello2
    where hello.a = hello.b
|])
```

## Building

```
make
cabal build
```
