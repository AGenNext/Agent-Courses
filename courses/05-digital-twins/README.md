# Course 05: Digital Twin Backbone

**Level:** Advanced | **Duration:** ~2 hours | **Prerequisites:** Courses 01, 04

## Learning Objectives

1. Understand the digital twin pattern — every real-world entity has a DB twin
2. Auto-create twins via SurrealDB events on agent/artifact registration
3. Connect twins with `RELATE` graph edges
4. Sync twin state with the real-world entity
5. Traverse the twin graph for relationship discovery

## Lessons

| # | Lesson | File |
|---|---|---|
| 1 | What is a digital twin | [01-twin-concept.surql](./lessons/01-twin-concept.surql) |
| 2 | Auto-creating twins via events | [02-auto-twin.surql](./lessons/02-auto-twin.surql) |
| 3 | Twin graph traversal | [03-twin-graph.surql](./lessons/03-twin-graph.surql) |
| 4 | Twin state sync | [04-twin-sync.surql](./lessons/04-twin-sync.surql) |

## Key Takeaways

- Every agent, objective, and artifact has a twin record auto-created on INSERT
- Twins are connected via `twin_relates_to` edges — forming the knowledge backbone
- Twin graph traversal reveals relationships across the entire platform
- SurrealDB is the data backbone — twins live here, not in a separate twin platform
