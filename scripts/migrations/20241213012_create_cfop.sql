CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS cfop (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(4) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    type VARCHAR(10) NOT NULL CHECK (type IN ('entrada', 'saida')),
    active BOOLEAN DEFAULT TRUE NOT NULL,
    created_by UUID,
    updated_by UUID,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES admin_users(id),
    FOREIGN KEY (updated_by) REFERENCES admin_users(id)
);

-- Adiciona um índice para a coluna code
CREATE INDEX IF NOT EXISTS idx_cfop_code ON cfop(code);