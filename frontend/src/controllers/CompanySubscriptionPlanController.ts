import axios from 'axios';

import { CompanySubscriptionPlan } from '../types/CompanySubscriptionPlan';

class CompanySubscriptionPlanController {
  private serverUrl: string;

  constructor() {
    this.serverUrl = process.env.REACT_APP_SERVER_URL || '';
  }

  async listAll(): Promise<CompanySubscriptionPlan[]> {
    try {
      const response = await axios.get(`${this.serverUrl}/company_subscription_plans`);
      return response.data;
    } catch (error) {
      throw new Error('Failed to list all subscription plans');
    }
  }

  async getById(id: string): Promise<CompanySubscriptionPlan> {
    try {
      const response = await axios.get(`${this.serverUrl}/company_subscription_plans/${id}`);
      return response.data;
    } catch (error) {
      throw new Error('Failed to get subscription plan by ID');
    }
  }

  async create(data: Omit<CompanySubscriptionPlan, 'id' | 'created_at' | 'updated_at'>): Promise<CompanySubscriptionPlan> {
    try {
      const response = await axios.post(`${this.serverUrl}/company_subscription_plans`, data);
      return response.data;
    } catch (error) {
      throw new Error('Failed to create subscription plan');
    }
  }

  async updateById(id: string, data: Partial<Omit<CompanySubscriptionPlan, 'id' | 'created_at' | 'updated_at'>>): Promise<CompanySubscriptionPlan> {
    try {
      const response = await axios.put(`${this.serverUrl}/company_subscription_plans/${id}`, data);
      return response.data;
    } catch (error) {
      throw new Error('Failed to update subscription plan by ID');
    }
  }

  async deleteById(id: string): Promise<void> {
    try {
      await axios.delete(`${this.serverUrl}/company_subscription_plans/${id}`);
    } catch (error) {
      throw new Error('Failed to delete subscription plan by ID');
    }
  }
}

export default new CompanySubscriptionPlanController();