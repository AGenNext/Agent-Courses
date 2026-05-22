# Agent Courses

Structured learning curriculum for building AI agent systems on SurrealDB and the AGenNext Agent Platform.

## Who This Is For

Engineers building agent systems who want to deeply understand:
- SurrealDB as an agent runtime (not just a database)
- Schema.org JSON-LD as a knowledge graph data model
- Hard rule enforcement at the database layer
- Agent memory, trust, governance, and FinOps from first principles

## Prerequisites

- SurrealDB running locally (see Quick Start)
- Basic SQL/query language familiarity
- Optional: Python or JavaScript for integration exercises

## Quick Start

```bash
# Docker
docker run -p 8000:8000 surrealdb/surrealdb:latest start --user root --pass root memory

# Surrealist GUI (recommended for courses)
# https://surrealdb.com/surrealist

# SurrealDB CLI
surreal sql --conn http://localhost:8000 --user root --pass root --ns courses --db lab
```

## Curriculum

| Course | Title | Duration | Level |
|---|---|---|---|
| [01](./courses/01-surrealdb-foundations) | SurrealDB Foundations | 2h | Beginner |
| [02](./courses/02-agent-memory) | Agent Memory | 2h | Intermediate |
| [03](./courses/03-live-queries) | Live Queries & Real-Time Presence | 1.5h | Intermediate |
| [04](./courses/04-knowledge-graph) | Knowledge Graph with Schema.org JSON-LD | 2.5h | Intermediate |
| [05](./courses/05-digital-twins) | Digital Twin Backbone | 2h | Advanced |
| [06](./courses/06-agent-rules) | Agent Rules & Hard Governance | 2h | Advanced |
| [07](./courses/07-multi-tenancy) | Multi-tenancy & Scoped Auth | 1.5h | Advanced |
| [08](./courses/08-eval-trust) | Evaluation, Trust & Provenance | 2h | Advanced |
| [09](./courses/09-agent-skills) | Agent Skills & Blueprints | 1.5h | Intermediate |
| [10](./courses/10-finops-billing) | FinOps & Cost Attribution | 1.5h | Advanced |

## Learning Path

```
01 → 02 → 03          Core runtime and memory
04 → 05               Knowledge graph and twins
06 → 07               Rules and governance
08 → 09 → 10          Trust, skills, and economics
```

## Core Principles

Every course reinforces these:

```
SurrealDB is the runtime — data and decisions at the same layer.
Schema.org JSON-LD is the graph data model.
The semantic web IS the knowledge graph.
Hard rules live in the DB schema, not in application code.
Every agent ships with memory, analytics, billing, health, and trust by default.
```

## Connection to Agent-Platform

Courses teach the exact patterns used in production:
- `AGenNext/Agent-Platform` — the production platform
- `AGenNext/Agent-Labs` — quick experiments and POCs
- `AGenNext/Agent-Courses` — this repo (structured learning)
