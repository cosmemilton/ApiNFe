CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS subscription_plans (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    notes_per_month INTEGER NOT NULL,
    excess_cost NUMERIC(10, 2) NOT NULL,
    excess_notes INTEGER NOT NULL,
    unlisted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insere os três planos de assinatura
INSERT INTO subscription_plans (id, name, price, notes_per_month, excess_cost, excess_notes, unlisted, created_at, updated_at)
VALUES
    ('221e5e1f-df1b-4309-ae33-becda677e3b4'::uuid, 'Plano Básico', 9.90, 50, 1.99, 10, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('63942acd-301d-4ff5-942d-c497b24c68ef'::uuid, 'Plano Intermediário', 99.00, 800, 1.25, 10, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('bf501662-ff26-44eb-a1a3-faa1dfc8f54a'::uuid, 'Plano Avançado', 998.00, 10000, 0.99, 10, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT DO NOTHING;