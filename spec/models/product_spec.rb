require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    let (:category) {Category.create(name: "Big_tree")}
    let (:product) {Product.new(name: "Rzydbt valniler", description: "very big tree with significant influence with world economy", price_cents: 1999, quantity: 100, category_id: category.id)}
    it "is valid with valid attributes" do
      expect(product).to be_valid
    end
    it "is not valid without a name" do
      product.name = nil
      product.save
      expect(product.errors.full_messages).to include("Name can't be blank")
      expect(product).to_not be_valid
    end
    it "is not valid without a price" do
      product.price_cents = nil
      product.save
      expect(product.errors.full_messages).to include("Price can't be blank")
      expect(product).to_not be_valid
    end
    it "is not valid without a quantity" do
      product.quantity = nil
      product.save
      expect(product.errors.full_messages).to include("Quantity can't be blank")
      expect(product).to_not be_valid
    end
    it "is not valid without category" do
      product.category = nil
      product.save
      expect(product.errors.full_messages).to include("Category can't be blank")
      expect(product).to_not be_valid
    end
  end
end
