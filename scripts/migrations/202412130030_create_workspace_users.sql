CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS workspace_users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    workspace_id UUID NOT NULL,
    nome VARCHAR(255) NOT NULL,
    login VARCHAR(100) NOT NULL UNIQUE,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    celular VARCHAR(20),
    email_confirmado BOOLEAN NOT NULL DEFAULT FALSE,
    celular_confirmado BOOLEAN NOT NULL DEFAULT FALSE,
    created_by UUID,
    updated_by UUID,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (workspace_id) REFERENCES workspaces(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna workspace_id
CREATE INDEX IF NOT EXISTS idx_workspace_users_workspace_id ON workspace_users(workspace_id);

-- Trigger function to set email_confirmado to false if email is changed
CREATE OR REPLACE FUNCTION set_email_confirmado_false()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.email IS DISTINCT FROM OLD.email THEN
        NEW.email_confirmado := FALSE;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger function to set celular_confirmado to false if celular is changed
CREATE OR REPLACE FUNCTION set_celular_confirmado_false()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.celular IS DISTINCT FROM OLD.celular THEN
        NEW.celular_confirmado := FALSE;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to call the function when email is updated
CREATE TRIGGER trg_set_email_confirmado_false
BEFORE UPDATE OF email ON workspace_users
FOR EACH ROW
EXECUTE FUNCTION set_email_confirmado_false();

-- Trigger to call the function when celular is updated
CREATE TRIGGER trg_set_celular_confirmado_false
BEFORE UPDATE OF celular ON workspace_users
FOR EACH ROW
EXECUTE FUNCTION set_celular_confirmado_false();