require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to :item}
    it { should belong_to :invoice}
  end

  describe "validations" do
    it { should define_enum_for(:status).with_values([:pending, :packaged, :shipped]) }
  end

  describe "instance methods" do
    it "#total_revenue" do
      item = Merchant.create!(name: "Test Merchant").items.create!(name: "Item 1", description: "Description 1", unit_price: 100, status: :enabled)
      customer = Customer.create!(first_name: "John", last_name: "Doe")
      invoice = Invoice.create!(status: 0, customer: customer, created_at: "2023-07-18")

      invoice_item = InvoiceItem.create!(quantity: 5, unit_price: 100, item: item, invoice: invoice, status: 0)

      expect(invoice_item.total_revenue).to eq(500)
    end

    it "converted_price" do
      merchant1 = create(:merchant)
      item1 = create(:item)
      customer = create(:customer)
      invoice1 = create(:invoice, customer: customer)
      ii1 = InvoiceItem.create!(quantity: 2, unit_price: 500, item_id: item1.id, invoice_id: invoice1.id, status: 0)

      expect(ii1.converted_price).to eq(5)
    end
  end
end