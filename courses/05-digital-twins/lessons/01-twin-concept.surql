-- Lesson 01: What Is a Digital Twin?
-- ─────────────────────────────────────────────────────────────────────────────
-- A digital twin is a virtual representation of a real-world entity.
-- In the Agent Platform:
--   - Every agent has a twin (its representation in the knowledge graph)
--   - Every artifact has a twin (its semantic identity)
--   - Every objective has a twin (its business goal as a graph node)
--
-- Twins are connected via RELATE edges — forming the knowledge backbone.
-- SurrealDB IS the twin platform. No separate IoT twin service needed.
-- ─────────────────────────────────────────────────────────────────────────────

DEFINE TABLE twin SCHEMAFULL;
DEFINE FIELD `@context`  ON TABLE twin TYPE string DEFAULT 'https://schema.org';
DEFINE FIELD `@type`     ON TABLE twin TYPE string DEFAULT 'Thing';
DEFINE FIELD twin_id     ON TABLE twin TYPE string ASSERT $value != NONE;
DEFINE FIELD tenant_id   ON TABLE twin TYPE string ASSERT $value != NONE;
DEFINE FIELD name        ON TABLE twin TYPE string;
DEFINE FIELD entity_type ON TABLE twin TYPE string
    ASSERT $value IN ['agent', 'objective', 'artifact', 'task', 'user', 'document', 'process'];
DEFINE FIELD entity_ref  ON TABLE twin TYPE option<string>;
DEFINE FIELD state       ON TABLE twin TYPE object DEFAULT {};
DEFINE FIELD sync_status ON TABLE twin TYPE string DEFAULT 'synced'
    ASSERT $value IN ['synced', 'stale', 'error'];
DEFINE FIELD created_at  ON TABLE twin TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at  ON TABLE twin TYPE datetime DEFAULT time::now();

-- Edge table: twin relationships
DEFINE TABLE twin_relates_to SCHEMAFULL TYPE RELATION IN twin OUT twin;
DEFINE FIELD relation_type ON TABLE twin_relates_to TYPE string DEFAULT 'related';
DEFINE FIELD weight        ON TABLE twin_relates_to TYPE float DEFAULT 1.0;
DEFINE FIELD created_at    ON TABLE twin_relates_to TYPE datetime DEFAULT time::now();

-- Create twins for platform entities
CREATE twin:agent_researcher SET
    twin_id     = 'agent-researcher-001',
    tenant_id   = 'tenant-acme',
    name        = 'Researcher Agent',
    entity_type = 'agent',
    entity_ref  = 'agent:researcher',
    state       = { status: 'active', capabilities: ['search', 'summarize', 'cite'] };

CREATE twin:objective_blog SET
    twin_id     = 'objective-blog-001',
    tenant_id   = 'tenant-acme',
    name        = 'Write SurrealDB blog post',
    entity_type = 'objective',
    entity_ref  = 'objective:write_blog',
    state       = { status: 'running', progress: 0.6 };

CREATE twin:artifact_draft SET
    twin_id     = 'artifact-draft-001',
    tenant_id   = 'tenant-acme',
    name        = 'Blog post draft',
    entity_type = 'artifact',
    entity_ref  = 'artifact:blog_draft',
    state       = { schema_type: 'BlogPosting', trust_score: null };

-- Connect twins with edges
RELATE twin:agent_researcher -> twin_relates_to -> twin:objective_blog
    SET relation_type = 'executes', weight = 1.0;

RELATE twin:objective_blog -> twin_relates_to -> twin:artifact_draft
    SET relation_type = 'produces', weight = 1.0;

-- Traverse: what does the researcher produce?
SELECT ->twin_relates_to->twin.name AS related_twins FROM twin:agent_researcher;

-- Two-hop: researcher → objective → artifact
SELECT
    ->twin_relates_to->twin AS objectives,
    ->twin_relates_to->twin->twin_relates_to->twin AS artifacts
FROM twin:agent_researcher;

-- TAKEAWAY: Every entity has a twin. Twins form a traversable knowledge graph.
-- The graph reveals relationships that span the entire platform.
