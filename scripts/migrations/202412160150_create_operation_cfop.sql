CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS operation_cfop (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    operation_id UUID NOT NULL,
    cfop_id UUID NOT NULL,
    company_id UUID NOT NULL,
    created_by UUID,
    updated_by UUID,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (operation_id) REFERENCES operations(id),
    FOREIGN KEY (cfop_id) REFERENCES cfop(id),
    FOREIGN KEY (company_id) REFERENCES companies(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna operation_id
CREATE INDEX IF NOT EXISTS idx_operation_cfop_operation_id ON operation_cfop(operation_id);

-- Adiciona um índice para a coluna cfop_id
CREATE INDEX IF NOT EXISTS idx_operation_cfop_cfop_id ON operation_cfop(cfop_id);