-- Lesson 02: Cost Aggregation Queries
-- ─────────────────────────────────────────────────────────────────────────────
-- SurrealQL aggregations replace Lago/Metabase for cost reporting.
-- math::sum(), GROUP BY, and time functions give real-time cost visibility.
-- ─────────────────────────────────────────────────────────────────────────────

-- Total spend per tenant
SELECT
    tenant_id,
    math::sum(cost_usd) AS total_spend_usd,
    math::sum(tokens_in + tokens_out) AS total_tokens,
    count() AS total_calls
FROM usage_record
GROUP BY tenant_id;

-- Spend per objective (cost breakdown for a single run)
SELECT
    objective_id,
    math::sum(cost_usd) AS objective_cost_usd,
    math::sum(tokens_in) AS total_tokens_in,
    math::sum(tokens_out) AS total_tokens_out,
    count() AS model_calls
FROM usage_record
WHERE tenant_id = 'tenant-acme'
GROUP BY objective_id;

-- Spend per model (model cost comparison)
SELECT
    model_id,
    provider,
    math::sum(cost_usd) AS total_cost_usd,
    math::mean(cost_usd) AS avg_cost_per_call,
    count() AS call_count
FROM usage_record
WHERE tenant_id = 'tenant-acme'
GROUP BY model_id, provider;

-- Spend per agent (which agents cost the most?)
SELECT
    agent_id,
    math::sum(cost_usd) AS agent_cost_usd,
    count() AS calls
FROM usage_record
WHERE tenant_id = 'tenant-acme'
GROUP BY agent_id
ORDER BY agent_cost_usd DESC;

-- Daily spend (cost over time)
SELECT
    time::day(recorded_at) AS day,
    time::month(recorded_at) AS month,
    math::sum(cost_usd) AS daily_spend_usd
FROM usage_record
WHERE tenant_id = 'tenant-acme'
GROUP BY time::day(recorded_at), time::month(recorded_at)
ORDER BY day DESC;

-- Spend in the last 30 days
SELECT math::sum(cost_usd) AS spend_30d
FROM usage_record
WHERE tenant_id = 'tenant-acme'
  AND recorded_at >= time::now() - 30d;

-- TAKEAWAY: SurrealQL GROUP BY + math::sum() = real-time cost dashboard.
-- No data warehouse. No Metabase sync. Query the live ledger directly.
