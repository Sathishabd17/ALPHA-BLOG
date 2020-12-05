require 'test_helper.rb'

class CategoryTest < ActiveSupport::TestCase
    def setup
        @category = Category.new(name: "Sports")
    end

    test "category should be valid" do
        assert @category.valid?, "category is not valid"
    end

    test "name should be present" do
        @category.name = " "
        assert_not @category.valid?, "name is not present"
    end

    test "name should be unique" do
        @category.save
        @category2 = Category.new(name: "Sports")
        assert_not @category2.valid?, "already this name taken"
    end

    test "name should not be too long" do
        @category.name = "a" * 30
        assert_not @category.valid?, "name is too long"   
    end

    test "name should not be too short" do
        @category.name = "aa"
        assert_not @category.valid?, "name is too short"
    end

end