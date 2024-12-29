CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE IF NOT EXISTS admin_users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    master BOOLEAN DEFAULT FALSE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by UUID,
    updated_by UUID,
    FOREIGN KEY (created_by) REFERENCES admin_users(id),
    FOREIGN KEY (updated_by) REFERENCES admin_users(id)
);

-- Adiciona um indice para a coluna username
CREATE INDEX IF NOT EXISTS idx_admin_users_username ON admin_users(username);

-- Adiciona um indice para a coluna email
CREATE INDEX IF NOT EXISTS idx_admin_users_email ON admin_users(email);

-- Insere o primeiro usuario admin
INSERT INTO admin_users (id, name, username, email, password_hash, master, created_at, updated_at)
VALUES (uuid_generate_v4(), 'Admin', 'admin', 'admin@example.com', crypt('999999', 'md5'), true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT DO NOTHING;