require 'test_helper'
    
    class CategoryTest < ActiveSupport::TestCase
       # runs setup before every test starts
        def setup
            @category = Category.new(name: "sports")
        end
        #checks to make sure there is a @category instance variable 
        test "category should be valid" do 
                assert @category.valid?
        end
        #checks to make sure the validation the checks that the categories name is not blank works
        test "name should be present" do
            @category.name = " "
            assert_not @category.valid?
        end
        
        #you can have 2 categories with the same name
        test "name should be unique" do
            @category.save
            category2 = Category.new(name: "sports")
            assert_not category2.valid?
        end
        
        test "name should not be too long" do
            @category.name = "a" * 26
            assert_not @category.valid?
        end
        
        test "name should not be too short" do
            @category.name = "aa"
            assert_not @category.valid?
        end 
    end 