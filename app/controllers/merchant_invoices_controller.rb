class MerchantInvoicesController < ApplicationController
  before_action :set_merchant
  before_action :set_invoice_item, only: [:update]
  before_action :set_invoice, only: [:show]

    def index
      @merchant = Merchant.find(params[:merchant_id])
      @invoices = @merchant.invoices.distinct
    end
  
    def show
      @merchant = Merchant.find(params[:merchant_id])
      @invoice = @merchant.invoices.find(params[:id])
      @invoice_items = @invoice.invoice_items
    end

    def update
      @invoice_item.update(status: params[:invoice_item][:status])
      redirect_to merchant_invoice_path(@invoice_item.invoice.merchant, @invoice_item.invoice)
    end

      private

    def set_merchant
      @merchant = Merchant.find(params[:merchant_id])
    end

    def set_invoice
      @invoice = @merchant.invoices.find(params[:id])
    end

    def set_invoice_item
      @invoice_item = InvoiceItem.find(params[:invoice_item_id])
    end
  
end
  