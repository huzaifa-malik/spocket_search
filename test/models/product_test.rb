require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test "missing country" do
    @product = products(:one)
    @product_dup = @product.dup
    @product_dup.country_id = nil
    assert_raises ActiveRecord::RecordInvalid do
      @product_dup.save!
    end
  end

  test "missing title" do
    @product = products(:one)
    @product_dup = @product.dup
    @product_dup.title = nil
    assert_raises ActiveRecord::RecordInvalid do
      @product_dup.save!
    end
  end

  test "missing price" do
    @product = products(:one)
    @product_dup = @product.dup
    @product_dup.price = nil
    assert_raises ActiveRecord::RecordInvalid do
      @product_dup.save!
    end
  end
end
