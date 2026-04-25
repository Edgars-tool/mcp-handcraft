-- Background agent job persistence schema (PostgreSQL)
-- Purpose: persist in-memory JOBS metadata for audit/recovery in production

CREATE TABLE IF NOT EXISTS agent_jobs (
    job_id TEXT PRIMARY KEY,
    tool_name TEXT NOT NULL,
    task TEXT NOT NULL,
    working_dir TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('queued', 'running', 'succeeded', 'failed')),
    is_error BOOLEAN NOT NULL DEFAULT FALSE,
    output TEXT NOT NULL DEFAULT '',
    attempts_json JSONB NOT NULL DEFAULT '[]'::jsonb,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    expires_at TIMESTAMPTZ NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_agent_jobs_status_updated_at
    ON agent_jobs(status, updated_at DESC);

CREATE INDEX IF NOT EXISTS idx_agent_jobs_expires_at
    ON agent_jobs(expires_at);
