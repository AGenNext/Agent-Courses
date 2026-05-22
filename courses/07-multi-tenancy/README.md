# Course 07: Multi-tenancy & Scoped Auth

**Level:** Advanced | **Duration:** ~1.5 hours | **Prerequisites:** Course 06

## Learning Objectives

1. Use SurrealDB namespaces for hard tenant isolation
2. Define JWT-based scopes with `DEFINE SCOPE`
3. Implement SIGNUP and SIGNIN within a scope
4. Enforce tenant_id checks via `DEFINE PERMISSION`
5. Understand namespace vs database vs scope isolation

## Lessons

| # | Lesson | File |
|---|---|---|
| 1 | Namespace isolation | [01-namespaces.surql](./lessons/01-namespaces.surql) |
| 2 | DEFINE SCOPE — JWT auth | [02-scope-auth.surql](./lessons/02-scope-auth.surql) |
| 3 | Tenant-scoped queries | [03-tenant-queries.surql](./lessons/03-tenant-queries.surql) |

## Isolation Levels

```
Namespace     → hard tenant boundary (separate DB engine context)
Database      → product domain within a namespace
Scope         → user/agent auth with JWT, record-level enforcement
Permissions   → fine-grained field-level control within a scope
```

## Key Takeaways

- Each tenant gets their own namespace — complete data isolation, no leakage
- `DEFINE SCOPE` issues JWT tokens scoped to a namespace/database
- `DEFINE PERMISSION` uses `$auth` to enforce per-record tenant checks
- SurrealDB replaces an external auth service for multi-tenant agent platforms
