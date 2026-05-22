-- Lesson 03: Vector Memory with MTREE
-- ─────────────────────────────────────────────────────────────────────────────
-- SurrealDB's MTREE index enables semantic similarity search over embeddings.
-- No external vector database (Pinecone, Weaviate, Qdrant) needed.
--
-- In production: generate embeddings via OpenAI, Anthropic, or Ollama.
-- In this lab: use small 4-dimensional vectors to demonstrate the pattern.
-- ─────────────────────────────────────────────────────────────────────────────

-- Define vector index (1536-dim for OpenAI ada-002; use 4 for this lab)
DEFINE INDEX idx_memory_vector ON TABLE memory
    FIELDS embedding
    MTREE DIMENSION 4;

-- Store memories with embeddings
-- (In production these come from your embedding model)
CREATE memory SET
    agent_id    = 'agent-researcher',
    tenant_id   = 'tenant-acme',
    memory_type = 'semantic',
    content     = 'SurrealDB supports vector search with MTREE indexes for semantic retrieval',
    embedding   = [0.9, 0.1, 0.8, 0.2],
    importance  = 0.9,
    tags        = ['surrealdb', 'vector', 'search'];

CREATE memory SET
    agent_id    = 'agent-researcher',
    tenant_id   = 'tenant-acme',
    memory_type = 'semantic',
    content     = 'Agent memory requires episodic, semantic, procedural, and working memory types',
    embedding   = [0.2, 0.8, 0.3, 0.7],
    importance  = 0.85,
    tags        = ['memory', 'agents'];

CREATE memory SET
    agent_id    = 'agent-researcher',
    tenant_id   = 'tenant-acme',
    memory_type = 'episodic',
    content     = 'Successfully completed objective: generate a product overview for SurrealDB',
    embedding   = [0.85, 0.15, 0.75, 0.25],
    importance  = 0.7,
    tags        = ['objective', 'completed'];

-- Semantic similarity search
-- Query vector represents "how does SurrealDB handle vector search?"
SELECT
    content,
    memory_type,
    importance,
    vector::similarity::cosine(embedding, [0.88, 0.12, 0.82, 0.18]) AS score
FROM memory
WHERE agent_id = 'agent-researcher'
ORDER BY score DESC
LIMIT 5;

-- Combined: vector similarity + importance weighting
SELECT
    content,
    memory_type,
    (vector::similarity::cosine(embedding, [0.88, 0.12, 0.82, 0.18]) * 0.7
     + importance * 0.3) AS weighted_score
FROM memory
WHERE agent_id = 'agent-researcher' AND embedding != NONE
ORDER BY weighted_score DESC
LIMIT 5;

-- TAKEAWAY: Semantic retrieval in SurrealDB uses MTREE cosine similarity.
-- Combine with importance weighting for better memory recall.
-- No external vector DB. No sync. No pipeline.
