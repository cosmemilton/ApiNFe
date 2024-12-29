CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS operation_cofinsst (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    operation_id UUID NOT NULL,
    vBC NUMERIC(15, 2), -- Valor da Base de Cálculo do COFINS ST
    pCOFINS NUMERIC(5, 2), -- Alíquota do COFINS ST (em percentual)
    qBCProd NUMERIC(15, 4), -- Quantidade Vendida (BC COFINS ST)
    vAliqProd NUMERIC(15, 4), -- Alíquota do COFINS ST (em reais)
    vCOFINS NUMERIC(15, 2), -- Valor do COFINS ST
    indSomaCOFINSST VARCHAR(50) CHECK (indSomaCOFINSST IN (
        'Nanhum', 'COFINSSTNaoCompoe', 'COFINSSTCompoe'
    )), -- Indicador de Soma do COFINS ST
    created_by UUID NOT NULL,
    updated_by UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (operation_id) REFERENCES operations(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna operation_id
CREATE INDEX IF NOT EXISTS idx_operation_cofinsst_operation_id ON operation_cofinsst(operation_id);