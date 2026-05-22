-- Lesson 01: Schema.org Types for Agents
-- ─────────────────────────────────────────────────────────────────────────────
-- Schema.org is a vocabulary for structured data on the web.
-- It defines types like Action, CreativeWork, Person, Organization, Event.
-- Using Schema.org as our type system gives agent data universal semantic meaning.
-- Combined with JSON-LD (@context, @type, @id), every record is machine-readable
-- by any system that understands the semantic web.
--
-- The semantic web IS the knowledge graph.
-- No separate ontology. No custom vocabulary. Schema.org covers everything.
-- ─────────────────────────────────────────────────────────────────────────────

-- Objective = schema:Action
-- An Action is "an intentional, purposeful activity"
-- Fields: name, description, actionStatus, startTime, endTime, result
CREATE objective:write_blog SET
    `@context` = 'https://schema.org',
    `@type`    = 'Action',
    `@id`      = 'urn:agennext:objective:write-blog-001',
    name       = 'Write a blog post about SurrealDB',
    description = 'Research SurrealDB features and write a 1000-word blog post for the AGenNext blog',
    actionStatus = 'ActiveActionStatus',
    startTime  = time::now();

-- Artifact = schema:CreativeWork
-- A CreativeWork is "the most generic kind of creative work"
-- Fields: name, text, url, encodingFormat, author, dateCreated
CREATE artifact:blog_draft SET
    `@context`      = 'https://schema.org',
    `@type`         = 'BlogPosting',
    `@id`           = 'urn:agennext:artifact:blog-draft-001',
    name            = 'SurrealDB: The Database for AI Agents',
    encodingFormat  = 'text/markdown',
    dateCreated     = time::now();

-- Agent = schema:SoftwareAgent
CREATE agent:researcher SET
    `@context` = 'https://schema.org',
    `@type`    = 'SoftwareAgent',
    `@id`      = 'urn:agennext:agent:researcher-001',
    name       = 'Researcher Agent',
    description = 'Discovers and synthesises information from sources';

-- Trust = schema:Rating
CREATE trust:blog_trust SET
    `@context`   = 'https://schema.org',
    `@type`      = 'Rating',
    ratingValue  = 0.92,
    bestRating   = 1.0,
    worstRating  = 0.0,
    description  = 'CLEAR evaluation: Correct, Logical, Evidence-backed, Aligned, Readable';

-- Now query by @type
SELECT * FROM objective WHERE `@type` = 'Action';
SELECT * FROM artifact WHERE `@type` IN ['BlogPosting', 'CreativeWork'];

-- TAKEAWAY: Schema.org types are the vocabulary. @context links to the definition.
-- Every record is self-describing and interoperable.
