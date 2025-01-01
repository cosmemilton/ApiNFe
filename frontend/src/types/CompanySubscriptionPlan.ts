export interface CompanySubscriptionPlan {
  id: string;
  company_id: string;
  subscription_plan_id: string;
  start_date: string;
  end_date?: string;
  created_at: string;
  updated_at: string;
}