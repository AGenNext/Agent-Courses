-- Lesson 01: DEFINE PARAM — Global Platform Constants
-- ─────────────────────────────────────────────────────────────────────────────
-- DEFINE PARAM stores database-wide constants accessible in all SurrealQL.
-- These are the platform's source of truth for thresholds, versions, and rules.
-- Change a PARAM and every query using it updates instantly.
-- ─────────────────────────────────────────────────────────────────────────────

-- Define platform-wide constants
DEFINE PARAM $PLATFORM_VERSION        VALUE '0.1.0';
DEFINE PARAM $MIN_TRUST_SCORE         VALUE 0.7;
DEFINE PARAM $MAX_PRIORITY            VALUE 10;
DEFINE PARAM $MAX_COST_PER_OBJECTIVE  VALUE 50.0;
DEFINE PARAM $REQUIRED_CAPABILITIES  VALUE ['analytics','billing','health','tracing','auth','artifacts','skills','trust'];
DEFINE PARAM $MEMORY_EMBEDDING_DIM    VALUE 1536;

-- Use params in queries
SELECT $PLATFORM_VERSION AS version;
SELECT $MIN_TRUST_SCORE AS min_trust;

-- Use in ASSERT — trust score must meet the platform minimum
DEFINE TABLE trust_record SCHEMAFULL;
DEFINE FIELD ratingValue ON TABLE trust_record TYPE float
    ASSERT $value >= 0.0 AND $value <= 1.0;

-- Use in validation queries
SELECT * FROM trust_record WHERE ratingValue >= $MIN_TRUST_SCORE;

-- Use in policy evaluation
SELECT * FROM artifact
WHERE trust_score >= $MIN_TRUST_SCORE;

-- Params survive DB restart (stored in schema)
-- REMOVE PARAM $MIN_TRUST_SCORE;  -- removes it

-- TAKEAWAY: DEFINE PARAM = single source of truth for platform constants.
-- Every query, assertion, and rule references the same value.
