CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS participants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    workspace_id UUID NOT NULL,
    type_registration VARCHAR(10) NOT NULL CHECK (type_registration IN ('ambos','cliente', 'fornecedor')),
    person_type VARCHAR(10) NOT NULL CHECK (person_type IN ('fisica', 'juridica')),
    name VARCHAR(255) NOT NULL,
    document VARCHAR(20) NOT NULL UNIQUE, -- CPF ou CNPJ
    email VARCHAR(100),
    phone VARCHAR(20),
    mobile VARCHAR(20),
    created_by UUID NOT NULL,
    updated_by UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (workspace_id) REFERENCES workspaces(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna workspace_id
CREATE INDEX IF NOT EXISTS idx_participants_workspace_id ON participants(workspace_id);

-- Adiciona um índice para a coluna document
CREATE INDEX IF NOT EXISTS idx_participants_document ON participants(document);