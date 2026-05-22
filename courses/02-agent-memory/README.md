# Course 02: Agent Memory

**Level:** Intermediate | **Duration:** ~2 hours | **Prerequisites:** Course 01

## Learning Objectives

1. Understand the four memory types: episodic, semantic, procedural, working
2. Store and retrieve memories using full-text search (BM25)
3. Store and retrieve memories using vector similarity (MTREE cosine)
4. Auto-seed memory on agent registration via SurrealDB events
5. Implement memory decay and importance scoring

## Lessons

| # | Lesson | File |
|---|---|---|
| 1 | Memory types and why they matter | [01-memory-types.surql](./lessons/01-memory-types.surql) |
| 2 | Full-text search memory | [02-fts-memory.surql](./lessons/02-fts-memory.surql) |
| 3 | Vector memory with MTREE | [03-vector-memory.surql](./lessons/03-vector-memory.surql) |
| 4 | Auto-seeding memory on registration | [04-auto-seed.surql](./lessons/04-auto-seed.surql) |
| 5 | Memory access patterns and decay | [05-memory-access.surql](./lessons/05-memory-access.surql) |

## Key Takeaways

- Agents have four memory types, each with a different role and retrieval pattern
- SurrealDB replaces a dedicated vector database with its MTREE index
- SurrealDB replaces Elasticsearch/Typesense with its built-in BM25 FTS
- Memory is auto-seeded on agent registration — implicit, not configured
- Memory access is tracked via SurrealDB events — importance and recency drive retrieval
