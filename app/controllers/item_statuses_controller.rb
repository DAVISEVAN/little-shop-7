class ItemStatusesController < ApplicationController
    def update
      @item = Item.find(params[:id])
      @item.update(status: @item.enabled? ? :disabled : :enabled)
      redirect_to merchant_items_path(@item.merchant)
    end
  end
  