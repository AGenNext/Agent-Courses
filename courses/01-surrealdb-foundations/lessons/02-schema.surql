-- Lesson 02: Defining Schemas
-- ─────────────────────────────────────────────────────────────────────────────
-- SCHEMAFULL = strict schema. Fields not defined are rejected at write time.
-- SCHEMALESS = flexible schema. Any field is accepted (not recommended for agents).
-- ─────────────────────────────────────────────────────────────────────────────

-- 1. Define a strict table
DEFINE TABLE agent SCHEMAFULL;

-- 2. Define fields with types
DEFINE FIELD name       ON TABLE agent TYPE string;
DEFINE FIELD version    ON TABLE agent TYPE string DEFAULT '0.1.0';
DEFINE FIELD status     ON TABLE agent TYPE string DEFAULT 'registered'
    ASSERT $value IN ['registered', 'active', 'inactive'];

-- 3. Required field (ASSERT $value != NONE)
DEFINE FIELD agent_id   ON TABLE agent TYPE string ASSERT $value != NONE;
DEFINE FIELD tenant_id  ON TABLE agent TYPE string ASSERT $value != NONE;

-- 4. Optional field
DEFINE FIELD description ON TABLE agent TYPE option<string>;

-- 5. Nested object field
DEFINE FIELD capabilities ON TABLE agent TYPE object DEFAULT {
    analytics: false,
    billing: false,
    health: false
};

-- 6. Array field
DEFINE FIELD skill_ids  ON TABLE agent TYPE array DEFAULT [];

-- 7. Datetime field with automatic default
DEFINE FIELD created_at ON TABLE agent TYPE datetime DEFAULT time::now();

-- 8. Try inserting a valid record
CREATE agent SET
    agent_id = 'agent-001',
    tenant_id = 'tenant-acme',
    name = 'Research Agent',
    capabilities = { analytics: true, billing: true, health: true };

-- 9. Try inserting with an unknown field — this will be REJECTED
-- CREATE agent SET agent_id = 'agent-002', tenant_id = 'tenant-acme', unknown_field = 'test';
-- Error: Found field 'unknown_field' but field does not exist in strict table

-- 10. Try inserting with invalid status — ASSERT rejects it
-- CREATE agent SET agent_id = 'agent-003', tenant_id = 'tenant-acme', status = 'broken';
-- Error: Found 'broken' for field 'status', with check: $value IN [...]

-- TAKEAWAY: Schema validation happens in the DB. The application cannot write bad data.
-- No Pydantic, Zod, or validation layer needed — the DB enforces the contract.
