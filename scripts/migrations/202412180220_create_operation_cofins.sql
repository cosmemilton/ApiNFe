CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS operation_cofins (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    operation_id UUID NOT NULL,
    CST VARCHAR(50) NOT NULL CHECK (CST IN (
        'cof01', 'cof02', 'cof03', 'cof04', 'cof05', 'cof06', 'cof07', 'cof08', 'cof09', 'cof49', 'cof50', 'cof51', 'cof52', 'cof53',
        'cof54', 'cof55', 'cof56', 'cof60', 'cof61', 'cof62', 'cof63', 'cof64', 'cof65', 'cof66', 'cof67', 'cof70', 'cof71', 'cof72',
        'cof73', 'cof74', 'cof75', 'cof98', 'cof99'
    )), -- Código da Situação Tributária do COFINS
    vBC NUMERIC(15, 2), -- Valor da Base de Cálculo do COFINS
    pCOFINS NUMERIC(5, 2), -- Alíquota do COFINS (em percentual)
    vCOFINS NUMERIC(15, 2), -- Valor do COFINS
    vBCProd NUMERIC(15, 4), -- Valor da Base de Cálculo do COFINS
    qBCProd NUMERIC(15, 4), -- Quantidade Vendida (BC COFINS)
    vAliqProd NUMERIC(15, 4), -- Alíquota do COFINS (em reais)
    created_by UUID NOT NULL,
    updated_by UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (operation_id) REFERENCES operations(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna operation_id
CREATE INDEX IF NOT EXISTS idx_operation_cofins_operation_id ON operation_cofins(operation_id);