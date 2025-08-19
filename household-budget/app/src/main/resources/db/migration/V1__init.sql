-- V1__init.sql
-- Initial database schema for household budget application

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Households table
CREATE TABLE households (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Memberships table (many-to-many relationship between users and households)
CREATE TABLE memberships (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    household_id UUID NOT NULL,
    role TEXT NOT NULL DEFAULT 'MEMBER',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    UNIQUE(user_id, household_id)
);

-- Transactions table
CREATE TABLE transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    household_id UUID NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('INCOME', 'EXPENSE')),
    amount NUMERIC(18,2) NOT NULL CHECK (amount >= 0),
    currency CHAR(3) NOT NULL DEFAULT 'KRW',
    category TEXT NOT NULL,
    method TEXT NOT NULL,
    occurred_at TIMESTAMPTZ NOT NULL,
    memo TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE
);

-- Budgets table
CREATE TABLE budgets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    household_id UUID NOT NULL,
    month CHAR(7) NOT NULL, -- Format: YYYY-MM
    category TEXT NOT NULL,
    amount NUMERIC(18,2) NOT NULL CHECK (amount >= 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    UNIQUE(household_id, month, category)
);

-- Outbox table for event sourcing/async processing
CREATE TABLE outbox (
    id BIGSERIAL PRIMARY KEY,
    type TEXT NOT NULL,
    payload JSONB NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    processed_at TIMESTAMPTZ
);

-- Indexes for performance
CREATE INDEX idx_transactions_household_occurred_at 
    ON transactions (household_id, occurred_at DESC);

CREATE INDEX idx_budgets_household_month 
    ON budgets (household_id, month);

CREATE INDEX idx_memberships_user_id 
    ON memberships (user_id);

CREATE INDEX idx_memberships_household_id 
    ON memberships (household_id);

CREATE INDEX idx_outbox_created_at 
    ON outbox (created_at);

CREATE INDEX idx_outbox_processed_at 
    ON outbox (processed_at) 
    WHERE processed_at IS NULL;

-- Add comments for documentation
COMMENT ON TABLE users IS 'User accounts in the system';
COMMENT ON TABLE households IS 'Household groups that share budgets';
COMMENT ON TABLE memberships IS 'User membership in households with roles';
COMMENT ON TABLE transactions IS 'Income and expense transactions';
COMMENT ON TABLE budgets IS 'Monthly budget limits by category';
COMMENT ON TABLE outbox IS 'Event outbox for async processing';

COMMENT ON COLUMN transactions.type IS 'Transaction type: INCOME or EXPENSE';
COMMENT ON COLUMN transactions.amount IS 'Transaction amount (always positive)';
COMMENT ON COLUMN transactions.currency IS 'ISO 4217 currency code';
COMMENT ON COLUMN budgets.month IS 'Budget month in YYYY-MM format';
COMMENT ON COLUMN outbox.processed_at IS 'NULL if not processed yet';
