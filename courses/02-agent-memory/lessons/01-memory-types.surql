-- Lesson 01: The Four Memory Types
-- ─────────────────────────────────────────────────────────────────────────────
-- Agents need different types of memory for different purposes.
-- SurrealDB stores all four types in one table with a memory_type field.
--
-- episodic   — what happened (events, interactions, objective outcomes)
-- semantic   — what I know (facts, concepts, platform knowledge)
-- procedural — how I work (my role, capabilities, operating procedures)
-- working    — what I'm doing right now (scratchpad, current task context)
-- ─────────────────────────────────────────────────────────────────────────────

DEFINE TABLE memory SCHEMAFULL;
DEFINE FIELD agent_id    ON TABLE memory TYPE string ASSERT $value != NONE;
DEFINE FIELD tenant_id   ON TABLE memory TYPE string ASSERT $value != NONE;
DEFINE FIELD content     ON TABLE memory TYPE string ASSERT $value != NONE;
DEFINE FIELD summary     ON TABLE memory TYPE option<string>;
DEFINE FIELD memory_type ON TABLE memory TYPE string DEFAULT 'episodic'
    ASSERT $value IN ['episodic', 'semantic', 'procedural', 'working'];
DEFINE FIELD importance  ON TABLE memory TYPE float DEFAULT 0.5
    ASSERT $value >= 0.0 AND $value <= 1.0;
DEFINE FIELD tags        ON TABLE memory TYPE array DEFAULT [];
DEFINE FIELD embedding   ON TABLE memory TYPE option<array>;
DEFINE FIELD access_count ON TABLE memory TYPE int DEFAULT 0;
DEFINE FIELD created_at  ON TABLE memory TYPE datetime DEFAULT time::now();
DEFINE FIELD accessed_at ON TABLE memory TYPE datetime DEFAULT time::now();

-- Procedural: who I am and what I do
CREATE memory SET
    agent_id    = 'agent-researcher',
    tenant_id   = 'tenant-acme',
    memory_type = 'procedural',
    content     = 'I am the Researcher agent. I discover and synthesise information from sources. I produce research artifacts with full citation provenance.',
    importance  = 1.0,
    tags        = ['identity', 'role', 'capabilities'];

-- Semantic: what I know about the platform
CREATE memory SET
    agent_id    = 'agent-researcher',
    tenant_id   = 'tenant-acme',
    memory_type = 'semantic',
    content     = 'The AGenNext platform stores all data as Schema.org JSON-LD in SurrealDB. Objectives are schema:Action. Artifacts are schema:CreativeWork. Trust records are schema:Rating.',
    importance  = 1.0,
    tags        = ['platform', 'schema', 'surrealdb'];

-- Episodic: what happened
CREATE memory SET
    agent_id    = 'agent-researcher',
    tenant_id   = 'tenant-acme',
    memory_type = 'episodic',
    content     = 'Completed research objective: "Write a product overview for SurrealDB". Produced 3 source artifacts. Trust score: 0.92.',
    importance  = 0.8,
    tags        = ['objective', 'completed', 'surrealdb'];

-- Working: current task scratchpad
CREATE memory SET
    agent_id    = 'agent-researcher',
    tenant_id   = 'tenant-acme',
    memory_type = 'working',
    content     = 'Currently researching: SurrealDB vector search capabilities. Sources found: 3. Still needed: benchmark comparisons.',
    importance  = 0.6,
    tags        = ['current-task', 'in-progress'];

-- Query by type
SELECT content, importance FROM memory WHERE agent_id = 'agent-researcher' AND memory_type = 'procedural';

-- Query most important memories first
SELECT content, memory_type, importance FROM memory
WHERE agent_id = 'agent-researcher'
ORDER BY importance DESC;

-- TAKEAWAY: Four memory types. One table. Queried by type or importance.
