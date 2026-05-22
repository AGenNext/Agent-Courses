# Course 09: Agent Skills & Blueprints

**Level:** Intermediate | **Duration:** ~1.5 hours | **Prerequisites:** Course 01

## Learning Objectives

1. Define skills as schema:HowToStep records in SurrealDB
2. Create agent blueprints (schema:HowTo) as templates
3. Register an agent from a blueprint
4. Validate skill declarations at registration
5. Seed skill registry on startup with INSERT IGNORE

## Lessons

| # | Lesson | File |
|---|---|---|
| 1 | Skill registry | [01-skill-registry.surql](./lessons/01-skill-registry.surql) |
| 2 | Agent blueprints | [02-blueprints.surql](./lessons/02-blueprints.surql) |
| 3 | Register agent from blueprint | [03-register-from-blueprint.surql](./lessons/03-register-from-blueprint.surql) |

## Platform Agent Blueprints

| Blueprint | Role |
|---|---|
| `agent.orchestrator` | Decomposes objectives, assigns tasks |
| `agent.researcher` | Web research, document retrieval |
| `agent.writer` | Artifact generation (blog, deck, doc) |
| `agent.evaluator` | CLEAR scoring, trust assignment |
| `agent.router` | Model routing, cost governance |
| `agent.knowledge` | RAG, semantic search, graph traversal |
| `agent.trust` | Provenance, evidence chains |
| `agent.monitor` | Health checks, alerts |

## Key Takeaways

- Skills are first-class records — not strings or enums
- Blueprints define the contract for an agent type
- Registration validates skills against the registry
- INSERT IGNORE seeds default skills idempotently on every startup
