class MerchantDashboardsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @top_customers = @merchant.top_customers
    @items_ready_to_ship = @merchant.items_ready_to_ship
  end
end
