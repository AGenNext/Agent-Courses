-- Lesson 01: Why SurrealDB for AI Agents
-- ─────────────────────────────────────────────────────────────────────────────
-- SurrealDB is not competing with data warehouses or vector DBs.
-- It is an operational database for real-time agent infrastructure.
--
-- "Your data platform answers what happened.
--  SurrealDB answers what should happen next."
--
-- Key difference: context lives IN the database, not above it.
-- No middleware. No context layer service. The DB IS the context layer.
-- ─────────────────────────────────────────────────────────────────────────────

-- 1. SurrealDB is multi-model: document, graph, relational, vector, time-series
--    All in one query language. No joins between separate systems.

-- 2. Demonstrate: creating a record with nested data (document model)
CREATE person:alice SET
    name = 'Alice',
    role = 'engineer',
    skills = ['surrealql', 'python', 'agents'],
    address = {
        city: 'London',
        country: 'UK'
    };

-- 3. Demonstrate: querying with nested field access
SELECT name, address.city FROM person;

-- 4. Demonstrate: graph relationship (not a foreign key — a first-class edge)
CREATE person:bob SET name = 'Bob', role = 'researcher';
RELATE person:alice -> knows -> person:bob SET since = time::now();

-- 5. Traverse the graph
SELECT ->knows->person.name AS colleagues FROM person:alice;

-- 6. Demonstrate: reactive event (the DB makes decisions, not the app)
DEFINE TABLE activity SCHEMAFULL;
DEFINE FIELD actor ON TABLE activity TYPE record<person>;
DEFINE FIELD action ON TABLE activity TYPE string;
DEFINE FIELD at ON TABLE activity TYPE datetime DEFAULT time::now();

DEFINE EVENT person_activity ON TABLE person
    WHEN $event = 'UPDATE'
    THEN (
        CREATE activity SET actor = $after.id, action = 'profile_updated'
    );

-- Now update alice — the event fires automatically
UPDATE person:alice SET role = 'senior engineer';

-- Check the audit trail — created by the DB, not the application
SELECT * FROM activity;

-- TAKEAWAY: The database makes decisions (events, assertions, permissions).
-- Application code only calls the DB. Business logic lives here.
