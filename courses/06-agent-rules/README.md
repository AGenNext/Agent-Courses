# Course 06: Agent Rules & Hard Governance

**Level:** Advanced | **Duration:** ~2 hours | **Prerequisites:** Courses 01, 02

## Learning Objectives

1. Define global platform parameters with `DEFINE PARAM`
2. Enforce business rules with `ASSERT` at the schema level
3. Apply record-level permissions with `DEFINE PERMISSION`
4. Store executable policy rules in a `policy` table
5. Understand: hard rules live in the DB, not in application code

## Lessons

| # | Lesson | File |
|---|---|---|
| 1 | DEFINE PARAM — global constants | [01-params.surql](./lessons/01-params.surql) |
| 2 | ASSERT — schema-level rule enforcement | [02-assert.surql](./lessons/02-assert.surql) |
| 3 | DEFINE PERMISSION — record-level access | [03-permissions.surql](./lessons/03-permissions.surql) |
| 4 | Policy table — runtime rules | [04-policy.surql](./lessons/04-policy.surql) |

## The 9 Hard Platform Rules

1. No objective without tenant attribution
2. No artifact surfaced without trust evaluation
3. No agent executes without registry entry + all capabilities
4. Audit log is immutable
5. Usage records are immutable
6. Memory is agent-scoped
7. Trust score must be in [0.0, 1.0]
8. Skill declarations must exist in registry
9. Policy blocks evaluated before objective runs

## Key Takeaways

- `ASSERT` makes invalid data impossible to write — no app-layer validation needed
- `DEFINE PERMISSION` enforces tenant isolation at the record level — no middleware
- `DEFINE PARAM` stores platform constants accessible in all SurrealQL
- Immutable tables (`FOR update NONE FOR delete NONE`) make audit/billing tamper-proof
