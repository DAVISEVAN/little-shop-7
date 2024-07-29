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