-- Lesson 01: LIVE SELECT Basics
-- ─────────────────────────────────────────────────────────────────────────────
-- LIVE SELECT opens a persistent WebSocket subscription.
-- The DB pushes changes (CREATE, UPDATE, DELETE) to the subscriber.
-- No polling. No event bus. SurrealDB is the real-time layer.
-- ─────────────────────────────────────────────────────────────────────────────

-- Setup
DEFINE TABLE objective SCHEMAFULL;
DEFINE FIELD goal       ON TABLE objective TYPE string;
DEFINE FIELD status     ON TABLE objective TYPE string DEFAULT 'pending';
DEFINE FIELD created_at ON TABLE objective TYPE datetime DEFAULT time::now();

-- Open a live query (returns a UUID — use it to kill the subscription later)
-- LIVE SELECT * FROM objective;
-- Returns: { id: "550e8400-..." }

-- More targeted live query — only running/pending
-- LIVE SELECT * FROM objective WHERE status IN ['running', 'pending'];

-- Live with specific fields
-- LIVE SELECT id, goal, status FROM objective;

-- Each change arrives as:
-- { action: 'CREATE', result: { id: '...', goal: '...', status: 'pending' } }
-- { action: 'UPDATE', result: { id: '...', status: 'running' } }
-- { action: 'DELETE', result: { id: '...' } }

-- Simulate changes (these push to all active live subscribers)
CREATE objective SET goal = 'Write product overview', status = 'pending';
UPDATE objective SET status = 'running' WHERE goal = 'Write product overview';
UPDATE objective SET status = 'completed' WHERE goal = 'Write product overview';

-- Kill a live query when done
-- KILL "550e8400-e29b-41d4-a716-446655440000";

-- TAKEAWAY: LIVE SELECT + WebSocket = real-time push from SurrealDB.
-- The dashboard never polls. It subscribes once and receives all changes.
