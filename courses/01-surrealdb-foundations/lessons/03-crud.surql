-- Lesson 03: CRUD Operations in SurrealQL
-- ─────────────────────────────────────────────────────────────────────────────

-- Setup: reuse the agent table from lesson 02

-- ─── CREATE ──────────────────────────────────────────────────────────────────

-- CREATE generates a random ID
CREATE agent CONTENT {
    agent_id: 'agent-researcher',
    tenant_id: 'tenant-acme',
    name: 'Researcher',
    status: 'active'
};

-- CREATE with a specific ID
CREATE agent:orchestrator CONTENT {
    agent_id: 'agent-orchestrator',
    tenant_id: 'tenant-acme',
    name: 'Orchestrator',
    status: 'active',
    capabilities: { analytics: true, billing: true, health: true }
};

-- INSERT IGNORE — idempotent, no error if already exists
INSERT IGNORE INTO agent [{
    agent_id: 'agent-writer',
    tenant_id: 'tenant-acme',
    name: 'Writer',
    status: 'registered'
}];

-- ─── SELECT ──────────────────────────────────────────────────────────────────

-- Select all
SELECT * FROM agent;

-- Select specific fields
SELECT name, status, tenant_id FROM agent;

-- Filter
SELECT * FROM agent WHERE status = 'active';

-- Filter with nested field
SELECT * FROM agent WHERE capabilities.analytics = true;

-- Order and limit
SELECT * FROM agent ORDER BY created_at DESC LIMIT 10;

-- Count
SELECT count() FROM agent GROUP ALL;

-- ─── UPDATE ──────────────────────────────────────────────────────────────────

-- Update a specific record
UPDATE agent:orchestrator SET status = 'active', version = '0.2.0';

-- Update all matching records
UPDATE agent SET status = 'active' WHERE tenant_id = 'tenant-acme';

-- UPSERT — create if not exists, update if exists
UPSERT agent:monitor CONTENT {
    agent_id: 'agent-monitor',
    tenant_id: 'tenant-acme',
    name: 'Monitor',
    status: 'active'
};

-- MERGE — only update provided fields, keep the rest
UPDATE agent:orchestrator MERGE { version: '0.3.0' };

-- ─── DELETE ──────────────────────────────────────────────────────────────────

-- Delete a specific record
-- DELETE agent:monitor;

-- Delete matching records
-- DELETE agent WHERE status = 'inactive';

-- ─── TRANSACTIONS ────────────────────────────────────────────────────────────

-- All-or-nothing execution
BEGIN TRANSACTION;
    CREATE agent:evaluator CONTENT {
        agent_id: 'agent-evaluator',
        tenant_id: 'tenant-acme',
        name: 'Evaluator',
        status: 'registered'
    };
    UPDATE agent:orchestrator SET version = '0.4.0';
COMMIT TRANSACTION;

-- TAKEAWAY: SurrealQL is SQL-like but with graph, document, and reactive features.
-- UPSERT and INSERT IGNORE make seed data idempotent.
