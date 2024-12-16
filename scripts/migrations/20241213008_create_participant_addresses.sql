CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS participant_addresses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    participant_id UUID NOT NULL,
    street VARCHAR(255) NOT NULL,
    number VARCHAR(10) NOT NULL,
    complement VARCHAR(255),
    neighborhood VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(2) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    created_by UUID NOT NULL,
    updated_by UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (participant_id) REFERENCES participants(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna participant_id
CREATE INDEX IF NOT EXISTS idx_participant_addresses_participant_id ON participant_addresses(participant_id);

-- Adiciona um índice para a coluna postal_code
CREATE INDEX IF NOT EXISTS idx_participant_addresses_postal_code ON participant_addresses(postal_code);