# Course 01: SurrealDB Foundations

**Level:** Beginner | **Duration:** ~2 hours | **Prerequisites:** None

## Learning Objectives

By the end of this course you will be able to:

1. Define strict schemas with `DEFINE TABLE SCHEMAFULL`
2. Write core SurrealQL: SELECT, CREATE, UPDATE, DELETE, UPSERT
3. Create graph relationships with `RELATE`
4. Define and query indexes
5. Use computed fields and default values
6. Understand why SurrealDB is an agent runtime, not just a database

## Lessons

| # | Lesson | File |
|---|---|---|
| 1 | Why SurrealDB | [01-why-surrealdb.surql](./lessons/01-why-surrealdb.surql) |
| 2 | Defining schemas | [02-schema.surql](./lessons/02-schema.surql) |
| 3 | CRUD operations | [03-crud.surql](./lessons/03-crud.surql) |
| 4 | Graph relationships | [04-relate.surql](./lessons/04-relate.surql) |
| 5 | Indexes and performance | [05-indexes.surql](./lessons/05-indexes.surql) |
| 6 | Events and triggers | [06-events.surql](./lessons/06-events.surql) |

## Exercises

See [exercises/](./exercises/) — complete them before checking [solutions/](./solutions/).

## Key Takeaways

- `SCHEMAFULL` tables reject unknown fields — strict data contracts by default
- `ASSERT` enforces business rules at write time, not in application code
- `RELATE` creates first-class graph edges, not just foreign keys
- `DEFINE EVENT` fires reactive SurrealQL on CREATE/UPDATE/DELETE
- SurrealDB replaces a document DB, graph DB, relational DB, and rules engine in one
