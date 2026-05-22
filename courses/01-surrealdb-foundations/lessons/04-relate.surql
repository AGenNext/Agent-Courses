-- Lesson 04: Graph Relationships with RELATE
-- ─────────────────────────────────────────────────────────────────────────────
-- RELATE creates a first-class edge record between two nodes.
-- The edge itself can hold data (weight, timestamp, metadata).
-- This makes SurrealDB a native graph database — no separate graph DB needed.
-- ─────────────────────────────────────────────────────────────────────────────

-- Setup: create some agents and objectives
CREATE agent:orchestrator CONTENT { agent_id: 'orch', tenant_id: 'acme', name: 'Orchestrator', status: 'active' };
CREATE agent:researcher   CONTENT { agent_id: 'res',  tenant_id: 'acme', name: 'Researcher',   status: 'active' };
CREATE agent:writer       CONTENT { agent_id: 'wrt',  tenant_id: 'acme', name: 'Writer',       status: 'active' };

CREATE objective:obj1 CONTENT {
    goal: 'Write a blog post about SurrealDB',
    status: 'running',
    tenant_id: 'acme'
};

-- ─── Define edge tables ───────────────────────────────────────────────────────

-- Agent executes objective
DEFINE TABLE executes SCHEMAFULL TYPE RELATION IN agent OUT objective;
DEFINE FIELD assigned_at ON TABLE executes TYPE datetime DEFAULT time::now();
DEFINE FIELD role        ON TABLE executes TYPE string DEFAULT 'executor';

-- Agent delegates to agent (A2A handoff)
DEFINE TABLE delegates_to SCHEMAFULL TYPE RELATION IN agent OUT agent;
DEFINE FIELD task        ON TABLE delegates_to TYPE string;
DEFINE FIELD delegated_at ON TABLE delegates_to TYPE datetime DEFAULT time::now();

-- ─── Create relationships ─────────────────────────────────────────────────────

-- Orchestrator executes the objective
RELATE agent:orchestrator -> executes -> objective:obj1 SET role = 'orchestrator';

-- Orchestrator delegates research to researcher
RELATE agent:orchestrator -> delegates_to -> agent:researcher SET
    task = 'Research SurrealDB features';

-- Orchestrator delegates writing to writer
RELATE agent:orchestrator -> delegates_to -> agent:writer SET
    task = 'Write the blog post from research';

-- ─── Traverse the graph ───────────────────────────────────────────────────────

-- What objectives is the orchestrator executing?
SELECT ->executes->objective.* FROM agent:orchestrator;

-- What agents does the orchestrator delegate to?
SELECT ->delegates_to->agent.name AS delegates_to FROM agent:orchestrator;

-- Who delegates TO the researcher? (reverse traversal)
SELECT <-delegates_to<-agent.name AS delegated_from FROM agent:researcher;

-- Multi-hop: find all agents connected to an objective (2 hops)
SELECT ->executes->objective<-executes<-agent.name AS co_executors
FROM agent:orchestrator;

-- Get full edge data
SELECT *, ->delegates_to.* FROM agent:orchestrator;

-- ─── Graph traversal for knowledge graph ─────────────────────────────────────

-- Find shortest path between two agents
-- SELECT * FROM graph::shortest_path(agent:orchestrator, agent:writer, 'delegates_to');

-- TAKEAWAY: RELATE is not a foreign key. It is a first-class edge with its own data.
-- Graph traversal is built into SurrealQL with -> and <- operators.
-- No separate graph database needed.
