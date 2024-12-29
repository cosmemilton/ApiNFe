DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'unique_operation_cfop_per_company'
    ) THEN
        ALTER TABLE operation_cfop
        ADD CONSTRAINT unique_operation_cfop_per_company UNIQUE (operation_id, cfop_id, company_id);
    END IF;
END $$;