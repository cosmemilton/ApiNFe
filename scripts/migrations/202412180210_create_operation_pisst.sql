CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS operation_pisst (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    operation_id UUID NOT NULL,
    vBC NUMERIC(15, 2), -- Valor da Base de Cálculo do PIS ST
    pPIS NUMERIC(5, 2), -- Alíquota do PIS ST (em percentual)
    qBCProd NUMERIC(15, 4), -- Quantidade Vendida (BC PIS ST)
    vAliqProd NUMERIC(15, 4), -- Alíquota do PIS ST (em reais)
    vPIS NUMERIC(15, 2), -- Valor do PIS ST
    indSomaPISST VARCHAR(50) CHECK (indSomaPISST IN (
        'Nenhum', 'PISSTNaoCompoe', 'PISSTCompoe'
    )), -- Indicador de Soma do PIS ST
    created_by UUID NOT NULL,
    updated_by UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (operation_id) REFERENCES operations(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna operation_id
CREATE INDEX IF NOT EXISTS idx_operation_pisst_operation_id ON operation_pisst(operation_id);