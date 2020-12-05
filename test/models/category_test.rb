require 'test_helper.rb'

class CategoryTest < ActiveSupport::TestCase
    test "category should be valid" do
        @category = Category.new
        assert @category.valid?, "category is not valid"
    end
end