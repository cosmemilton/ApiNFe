CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS operation_pis (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    operation_id UUID NOT NULL,
    CST VARCHAR(50) NOT NULL CHECK (CST IN (
        'pis01', 'pis02', 'pis03', 'pis04', 'pis05', 'pis06', 'pis07', 'pis08', 'pis09', 'pis49', 'pis50', 'pis51', 'pis52', 'pis53', 'pis54', 'pis55', 'pis56', 'pis60', 'pis61', 'pis62', 'pis63', 'pis64', 'pis65', 'pis66', 'pis67', 'pis70', 'pis71', 'pis72', 'pis73', 'pis74', 'pis75', 'pis98', 'pis99'
    )), -- Código da Situação Tributária do PIS
    vBC NUMERIC(15, 2), -- Valor da Base de Cálculo do PIS
    pPIS NUMERIC(5, 2), -- Alíquota do PIS (em percentual)
    vPIS NUMERIC(15, 2), -- Valor do PIS
    qBCProd NUMERIC(15, 4), -- Quantidade Vendida (BC PIS)
    vAliqProd NUMERIC(15, 4), -- Alíquota do PIS (em reais)
    created_by UUID NOT NULL,
    updated_by UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (operation_id) REFERENCES operations(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna operation_id
CREATE INDEX IF NOT EXISTS idx_operation_pis_operation_id ON operation_pis(operation_id);