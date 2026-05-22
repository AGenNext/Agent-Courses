-- Lesson 01: Usage Records — Native Billing in SurrealDB
-- ─────────────────────────────────────────────────────────────────────────────
-- Every model call is recorded as a usage_record.
-- Records are immutable — PERMISSION FOR update NONE, FOR delete NONE.
-- This is the platform's billing ledger. It cannot be altered after creation.
-- ─────────────────────────────────────────────────────────────────────────────

DEFINE TABLE usage_record SCHEMAFULL;

DEFINE FIELD `@context`    ON TABLE usage_record TYPE string DEFAULT 'https://schema.org';
DEFINE FIELD `@type`       ON TABLE usage_record TYPE string DEFAULT 'Invoice';

-- Required cost attribution
DEFINE FIELD tenant_id     ON TABLE usage_record TYPE string ASSERT $value != NONE;
DEFINE FIELD objective_id  ON TABLE usage_record TYPE option<string>;
DEFINE FIELD agent_id      ON TABLE usage_record TYPE option<string>;
DEFINE FIELD model_id      ON TABLE usage_record TYPE option<string>;
DEFINE FIELD provider      ON TABLE usage_record TYPE option<string>;

-- Metering
DEFINE FIELD tokens_in     ON TABLE usage_record TYPE int DEFAULT 0;
DEFINE FIELD tokens_out    ON TABLE usage_record TYPE int DEFAULT 0;
DEFINE FIELD cost_usd      ON TABLE usage_record TYPE float DEFAULT 0.0;
DEFINE FIELD duration_ms   ON TABLE usage_record TYPE option<int>;
DEFINE FIELD recorded_at   ON TABLE usage_record TYPE datetime DEFAULT time::now();

-- Immutable billing ledger — no updates, no deletes
DEFINE TABLE usage_record PERMISSIONS
    FOR select WHERE tenant_id = $auth.tenant_id OR $auth.role = 'admin'
    FOR create FULL
    FOR update NONE
    FOR delete NONE;

-- Record a model call
CREATE usage_record SET
    tenant_id    = 'tenant-acme',
    objective_id = 'objective:write_blog',
    agent_id     = 'agent-researcher',
    model_id     = 'claude-sonnet-4-6',
    provider     = 'anthropic',
    tokens_in    = 1200,
    tokens_out   = 800,
    cost_usd     = 0.012;

CREATE usage_record SET
    tenant_id    = 'tenant-acme',
    objective_id = 'objective:write_blog',
    agent_id     = 'agent-writer',
    model_id     = 'claude-sonnet-4-6',
    provider     = 'anthropic',
    tokens_in    = 2000,
    tokens_out   = 3000,
    cost_usd     = 0.035;

-- Try to update — this will fail (immutable)
-- UPDATE usage_record SET cost_usd = 0.0 WHERE tenant_id = 'tenant-acme';
-- Error: IAM permissions denied

-- Read the ledger
SELECT tenant_id, agent_id, model_id, tokens_in, tokens_out, cost_usd
FROM usage_record
WHERE tenant_id = 'tenant-acme'
ORDER BY recorded_at DESC;

-- TAKEAWAY: usage_record is a billing ledger. Append-only. Cannot be altered.
-- Every model call must produce one record. No record = no cost attribution.
