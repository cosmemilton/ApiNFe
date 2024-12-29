CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS operation_icmsufdest (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    operation_id UUID NOT NULL,
    vBCUFDest NUMERIC(15, 2), -- Valor da Base de Cálculo do ICMS na UF de destino
    vBCFCPUFDest NUMERIC(15, 2), -- Valor da Base de Cálculo do FCP na UF de destino
    pFCPUFDest NUMERIC(5, 2), -- Percentual do FCP na UF de destino
    pICMSUFDest NUMERIC(5, 2), -- Percentual do ICMS na UF de destino
    pICMSInter NUMERIC(5, 2), -- Percentual do ICMS interestadual
    pICMSInterPart NUMERIC(5, 2), -- Percentual de partilha do ICMS interestadual
    vFCPUFDest NUMERIC(15, 2), -- Valor do FCP na UF de destino
    vICMSUFDest NUMERIC(15, 2), -- Valor do ICMS na UF de destino
    vICMSUFRemet NUMERIC(15, 2), -- Valor do ICMS na UF do remetente
    created_by UUID NOT NULL,
    updated_by UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (operation_id) REFERENCES operations(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna operation_id
CREATE INDEX IF NOT EXISTS idx_operation_icmsufdest_operation_id ON operation_icmsufdest(operation_id);
