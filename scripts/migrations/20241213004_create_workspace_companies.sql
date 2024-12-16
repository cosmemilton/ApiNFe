CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS workspace_companies (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    workspace_id UUID NOT NULL,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    inscricao_estadual VARCHAR(20),
    inscricao_municipal VARCHAR(20),
    name VARCHAR(255) NOT NULL,
    alias VARCHAR(20) NOT NULL UNIQUE,
    cnae VARCHAR(50) NOT NULL,    
    created_by UUID NOT NULL,
    updated_by UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (workspace_id) REFERENCES workspaces(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna workspace_id
CREATE INDEX IF NOT EXISTS idx_workspace_companies_workspace_id ON workspace_companies(workspace_id);

-- Adiciona um índice para a coluna cnpj
CREATE INDEX IF NOT EXISTS idx_workspace_companies_cnpj ON workspace_companies(cnpj);

-- Adiciona um índice para a coluna alias
CREATE INDEX IF NOT EXISTS idx_workspace_companies_alias ON workspace_companies(alias);