class CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @active_coupons = @merchant.coupons.active_coupons
    @inactive_coupons = @merchant.coupons.inactive
  end

  def show
    @coupon = Coupon.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.new(coupon_params)

    if @coupon.save
      flash[:notice] = 'Coupon created successfully'
      redirect_to merchant_coupons_path(@merchant)
    else
      flash.now[:alert] = @coupon.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :code, :amount, :discount_type, :status)
  end
end
