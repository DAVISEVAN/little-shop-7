class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.enabled
    @disabled_merchants = Merchant.disabled
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    if Merchant.create!(name: params[:name])
      flash[:notice] = 'Merchant Successfully Created!'
      redirect_to admin_merchants_path
    else
      render :new
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
      redirect_to admin_merchant_path(@merchant)
      flash[:notice] = "Merchant information has been successfully updated."
    else
      render :edit
    end
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
