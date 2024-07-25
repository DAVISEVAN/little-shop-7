class MerchantDashboardsController < ApplicationController
    def show
      @merchant = Merchant.find(params[:merchant_id])
      @top_customers = @merchant.top_customers
    end
  end
  