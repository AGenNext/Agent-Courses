-- Lesson 06: Events and Reactive Triggers
-- ─────────────────────────────────────────────────────────────────────────────
-- DEFINE EVENT fires SurrealQL automatically when records change.
-- This replaces application-level event handling, webhooks, and message queues
-- for internal state transitions.
-- ─────────────────────────────────────────────────────────────────────────────

-- Setup tables
DEFINE TABLE objective SCHEMAFULL;
DEFINE FIELD goal       ON TABLE objective TYPE string;
DEFINE FIELD status     ON TABLE objective TYPE string DEFAULT 'pending';
DEFINE FIELD tenant_id  ON TABLE objective TYPE string;
DEFINE FIELD created_at ON TABLE objective TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at ON TABLE objective TYPE datetime DEFAULT time::now();

DEFINE TABLE audit_log SCHEMAFULL;
DEFINE FIELD entity     ON TABLE audit_log TYPE string;
DEFINE FIELD entity_id  ON TABLE audit_log TYPE string;
DEFINE FIELD action     ON TABLE audit_log TYPE string;
DEFINE FIELD before     ON TABLE audit_log TYPE option<object>;
DEFINE FIELD after      ON TABLE audit_log TYPE option<object>;
DEFINE FIELD timestamp  ON TABLE audit_log TYPE datetime DEFAULT time::now();

DEFINE TABLE analytics_event SCHEMAFULL;
DEFINE FIELD name       ON TABLE analytics_event TYPE string;
DEFINE FIELD category   ON TABLE analytics_event TYPE string;
DEFINE FIELD label      ON TABLE analytics_event TYPE option<string>;
DEFINE FIELD timestamp  ON TABLE analytics_event TYPE datetime DEFAULT time::now();

-- ─── Event 1: Audit every change ──────────────────────────────────────────────

DEFINE EVENT audit_objective ON TABLE objective
    WHEN $event IN ['CREATE', 'UPDATE', 'DELETE']
    THEN (
        CREATE audit_log SET
            entity    = 'objective',
            entity_id = <string>$after.id,
            action    = $event,
            before    = $before,
            after     = $after
    );

-- ─── Event 2: Analytics on status transitions ─────────────────────────────────

DEFINE EVENT objective_status ON TABLE objective
    WHEN $event = 'UPDATE' AND $before.status != $after.status
    THEN (
        CREATE analytics_event SET
            name     = string::concat('objective.', $after.status),
            category = 'objective',
            label    = $after.goal
    );

-- ─── Event 3: Auto-update timestamp ───────────────────────────────────────────

DEFINE EVENT objective_updated_at ON TABLE objective
    WHEN $event = 'UPDATE'
    THEN (
        UPDATE $after.id SET updated_at = time::now()
    );

-- ─── Test the events ──────────────────────────────────────────────────────────

-- Create an objective — audit_log fires
CREATE objective:test1 SET
    goal = 'Write a product overview',
    tenant_id = 'acme',
    status = 'pending';

-- Update status — audit_log AND analytics_event fire
UPDATE objective:test1 SET status = 'running';
UPDATE objective:test1 SET status = 'completed';

-- Check audit log — automatically populated
SELECT * FROM audit_log ORDER BY timestamp ASC;

-- Check analytics events — automatically emitted
SELECT * FROM analytics_event ORDER BY timestamp ASC;

-- TAKEAWAY: Events fire reactive SurrealQL — audit logs, analytics, and
-- state transitions happen automatically in the DB.
-- The application sends one UPDATE. The DB handles the rest.
