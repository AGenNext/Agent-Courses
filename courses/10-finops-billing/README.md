# Course 10: FinOps & Cost Attribution

**Level:** Advanced | **Duration:** ~1.5 hours | **Prerequisites:** Courses 01, 06

## Learning Objectives

1. Record every model call as a `usage_record` in SurrealDB
2. Attribute cost to tenant, objective, and agent
3. Aggregate spend per tenant with SurrealQL GROUP BY
4. Define and enforce budget limits
5. Use SurrealDB events to auto-emit billing records

## Governing Rule

```
No objective runs without cost attribution.
No model call runs without a usage_record.
Billing records are immutable — no UPDATE, no DELETE.
```

## Lessons

| # | Lesson | File |
|---|---|---|
| 1 | Usage record schema | [01-usage-records.surql](./lessons/01-usage-records.surql) |
| 2 | Cost aggregation queries | [02-cost-aggregation.surql](./lessons/02-cost-aggregation.surql) |
| 3 | Budget enforcement | [03-budget-enforcement.surql](./lessons/03-budget-enforcement.surql) |

## Key Takeaways

- `usage_record` is append-only — enforced via PERMISSION FOR update NONE, FOR delete NONE
- SurrealQL GROUP BY + math::sum() replaces Lago for basic cost aggregation
- Budget alerts fire via SurrealDB events when spend approaches the limit
- Cost attribution is mandatory — enforced by platform policy rule
