CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS company_contacts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    mobile VARCHAR(20),
    position VARCHAR(50),
    created_by UUID NOT NULL,
    updated_by UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (company_id) REFERENCES workspace_companies(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna company_id
CREATE INDEX IF NOT EXISTS idx_company_contacts_company_id ON company_contacts(company_id);

-- Adiciona um índice para a coluna email
CREATE INDEX IF NOT EXISTS idx_company_contacts_email ON company_contacts(email);