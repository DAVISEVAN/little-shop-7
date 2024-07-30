class ItemInvoiceStatusesController < ApplicationController
  before_action :set_invoice_item

  def update
    @invoice_item.update(status: params[:invoice_item][:status])
    redirect_to merchant_invoice_path(@invoice_item.invoice.merchant, @invoice_item.invoice)
  end

  private

  def set_invoice_item
    @invoice_item = InvoiceItem.find(params[:invoice_item_id])
  end
end
