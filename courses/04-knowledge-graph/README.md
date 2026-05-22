# Course 04: Knowledge Graph with Schema.org JSON-LD

**Level:** Intermediate | **Duration:** ~2.5 hours | **Prerequisites:** Courses 01, 02

## Learning Objectives

1. Understand why Schema.org JSON-LD is the right vocabulary for agent data
2. Model objectives, artifacts, and agents as Schema.org types
3. Use `RELATE` to build a knowledge graph with semantic edges
4. Traverse the knowledge graph with SurrealQL graph operators
5. Understand: the semantic web IS the knowledge graph

## Lessons

| # | Lesson | File |
|---|---|---|
| 1 | Schema.org types for agents | [01-schemaorg-types.surql](./lessons/01-schemaorg-types.surql) |
| 2 | JSON-LD records in SurrealDB | [02-jsonld-records.surql](./lessons/02-jsonld-records.surql) |
| 3 | Building the knowledge graph | [03-knowledge-graph.surql](./lessons/03-knowledge-graph.surql) |
| 4 | Graph traversal queries | [04-graph-traversal.surql](./lessons/04-graph-traversal.surql) |

## Schema.org Type Mapping

| Agent Concept | Schema.org Type |
|---|---|
| Objective | `schema:Action` |
| Artifact | `schema:CreativeWork` |
| Agent | `schema:SoftwareAgent` |
| Trust record | `schema:Rating` |
| Skill | `schema:HowToStep` |
| Analytics event | `schema:Event` |
| Blueprint | `schema:HowTo` |
| Health check | `schema:CheckAction` |
| Twin | `schema:Thing` |

## Key Takeaways

- Schema.org types give your data universal semantic meaning
- JSON-LD = JSON with a `@context` that links to Schema.org definitions
- The knowledge graph IS the semantic web — no separate ontology needed
- SurrealDB's RELATE turns tables into a traversable knowledge graph
