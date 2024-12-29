CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS cest (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(7) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    created_by UUID,
    updated_by UUID,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna code
CREATE INDEX IF NOT EXISTS idx_cest_code ON cest(code);