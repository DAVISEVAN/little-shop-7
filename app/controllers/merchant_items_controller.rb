class MerchantItemsController < ApplicationController
  before_action :set_merchant
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @enabled_items = @merchant.items.where(status: 'enabled')
    @disabled_items = @merchant.items.where(status: 'disabled')
    @top_items = @merchant.top_5_items_by_revenue
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new(item_params)
    @item.status = 'disabled' # Set default status to disabled
    if @item.save
      redirect_to merchant_items_path(@merchant), notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new
  end

  def update
    if params[:status]
      @item.update(status: params[:status])
      redirect_to merchant_items_path(@merchant), notice: 'Item status was successfully updated.'
    else
      if @item.update(item_params)
        redirect_to merchant_item_path(@merchant, @item), notice: 'Item was successfully updated.'
      else
        render :edit
      end
    end
  end


  private

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def set_item
    @item = @merchant.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end
end
