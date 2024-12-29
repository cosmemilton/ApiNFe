CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS operation_ii (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    operation_id UUID NOT NULL,
    vBC NUMERIC(15, 2), -- Valor da Base de Cálculo do II
    vDespAdu NUMERIC(15, 2), -- Valor das Despesas Aduaneiras
    vII NUMERIC(15, 2), -- Valor do Imposto de Importação
    vIOF NUMERIC(15, 2), -- Valor do IOF
    created_by UUID NOT NULL,
    updated_by UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (operation_id) REFERENCES operations(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna operation_id
CREATE INDEX IF NOT EXISTS idx_operation_ii_operation_id ON operation_ii(operation_id);