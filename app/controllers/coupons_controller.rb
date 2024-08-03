class CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @active_coupons = @merchant.coupons.active_coupons
    @inactive_coupons = @merchant.coupons.inactive
  end

  def show
    @coupon = Coupon.find(params[:id])
  end
end
