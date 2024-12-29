CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS company_invoice_settings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL,
    document_type VARCHAR(4) NOT NULL CHECK (document_type IN ('NFe', 'NFCe')),
    environment VARCHAR(12) NOT NULL CHECK (environment IN ('homologacao', 'producao')),
    series INTEGER NOT NULL,
    initial_number INTEGER NOT NULL,
    final_number INTEGER NOT NULL,
    next_number INTEGER NOT NULL,
    certificate BYTEA NOT NULL,
    certificate_password VARCHAR(255) NOT NULL,
    certificate_expiration DATE NOT NULL,
    csc VARCHAR(255),
    id_csc VARCHAR(6),
    created_by UUID NOT NULL,
    updated_by UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (company_id) REFERENCES companies(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna company_id
CREATE INDEX IF NOT EXISTS idx_company_invoice_settings_company_id ON company_invoice_settings(company_id);