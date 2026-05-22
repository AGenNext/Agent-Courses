# Course 08: Evaluation, Trust & Provenance

**Level:** Advanced | **Duration:** ~2 hours | **Prerequisites:** Courses 01, 06

## Learning Objectives

1. Implement the CLEAR evaluation framework in SurrealDB
2. Create trust records (schema:Rating) for every artifact
3. Build provenance chains linking artifacts to objectives and agents
4. Gate artifact surfacing behind trust threshold
5. Use SurrealDB events to auto-emit trust signals

## CLEAR Framework

| Letter | Criterion | SurrealDB field |
|---|---|---|
| C | Correct | `correct_score` |
| L | Logical | `logical_score` |
| E | Evidence-backed | `evidence_score` |
| A | Aligned | `aligned_score` |
| R | Readable | `readable_score` |

Overall trust = mean(C, L, E, A, R). Must be >= 0.7 to surface.

## Lessons

| # | Lesson | File |
|---|---|---|
| 1 | CLEAR scoring schema | [01-clear-schema.surql](./lessons/01-clear-schema.surql) |
| 2 | Provenance chain | [02-provenance.surql](./lessons/02-provenance.surql) |
| 3 | Trust gate | [03-trust-gate.surql](./lessons/03-trust-gate.surql) |

## Key Takeaways

- Every artifact must have a trust_record before it can be surfaced
- CLEAR scores are stored as structured fields — queryable, aggregatable
- Provenance is a graph: artifact → task → objective → agent
- Trust gates are enforced in SurrealDB PERMISSION rules, not in application code
