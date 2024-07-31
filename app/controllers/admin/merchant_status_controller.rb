class Admin::MerchantStatusController < ApplicationController

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.enabled?
      @merchant.disabled!
    else
      @merchant.enabled!
    end
    redirect_to admin_merchants_path
  end

  private
  def merchant_params
    params.require(:merchant).permit(:status)
  end
end