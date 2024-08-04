class CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @active_coupons = @merchant.coupons.active_coupons
    @inactive_coupons = @merchant.coupons.inactive
  end

  def show
    @coupon = Coupon.find(params[:id])
    @successful_transactions_count = @coupon.successful_transactions_count
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

  def update
    @coupon = Coupon.find(params[:id])
    
    if params[:status] == 'activate'
      if @coupon.update(status: 'active')
        flash[:notice] = 'Coupon activated successfully'
      else
        flash[:alert] = 'Failed to activate coupon'
      end
    elsif params[:status] == 'deactivate'
      if @coupon.invoices.where(status: 'in progress').any?
        flash[:alert] = 'Cannot deactivate coupon with in-progress invoices'
      elsif @coupon.update(status: 'inactive')
        flash[:notice] = 'Coupon deactivated successfully'
      else
        flash[:alert] = 'Failed to deactivate coupon'
      end
    end

    redirect_to merchant_coupon_path(@coupon.merchant, @coupon)
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :code, :amount, :discount_type, :status)
  end
end
