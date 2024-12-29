CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS operation_ipi (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    operation_id UUID NOT NULL,
    FclEnq VARCHAR(255), -- Código de Enquadramento Legal do IPI
    FCNPJProd VARCHAR(14), -- CNPJ do produtor
    FcSelo VARCHAR(255), -- Código do selo de controle
    FqSelo INTEGER, -- Quantidade de selo de controle
    FcEnq VARCHAR(255), -- Código de enquadramento do IPI
    FCST VARCHAR(3), -- Código da Situação Tributária do IPI
    FvBC NUMERIC(15, 2), -- Valor da Base de Cálculo do IPI
    FqUnid NUMERIC(15, 4), -- Quantidade total na unidade padrão para tributação
    FvUnid NUMERIC(15, 4), -- Valor por unidade tributável
    FpIPI NUMERIC(5, 2), -- Alíquota do IPI
    FvIPI NUMERIC(15, 2), -- Valor do IPI
    created_by UUID NOT NULL,
    updated_by UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (operation_id) REFERENCES operations(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna operation_id
CREATE INDEX IF NOT EXISTS idx_operation_ipi_operation_id ON operation_ipi(operation_id);