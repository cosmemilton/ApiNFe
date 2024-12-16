CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    workspace_id UUID NOT NULL,
    ncm_id UUID,
    cest_id UUID,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    sku VARCHAR(50) UNIQUE,
    created_by UUID NOT NULL,
    updated_by UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (workspace_id) REFERENCES workspaces(id),
    FOREIGN KEY (ncm_id) REFERENCES ncm(id),
    FOREIGN KEY (cest_id) REFERENCES cest(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna workspace_id
CREATE INDEX IF NOT EXISTS idx_products_workspace_id ON products(workspace_id);

-- Adiciona um índice para a coluna sku
CREATE INDEX IF NOT EXISTS idx_products_sku ON products(sku);