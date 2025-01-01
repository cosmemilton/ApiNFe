CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS company_subscription_plans (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL,
    subscription_plan_id UUID NOT NULL,
    start_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    end_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (company_id) REFERENCES companies(id),
    FOREIGN KEY (subscription_plan_id) REFERENCES subscription_plans(id)
);

-- Adiciona um índice para a coluna company_id
CREATE INDEX IF NOT EXISTS idx_company_subscription_plans_company_id ON company_subscription_plans(company_id);

-- Adiciona um índice para a coluna subscription_plan_id
CREATE INDEX IF NOT EXISTS idx_company_subscription_plans_subscription_plan_id ON company_subscription_plans(subscription_plan_id);