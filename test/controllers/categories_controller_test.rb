require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
    
    def setup
        #creating a category instance variable for the test
        @category = Category.create(name: "sports")
        #creating a admin user for the test
        @user = User.create(username: "John", email: "john@example.com", password: "password", admin: true)
    end
        
        test "should get categories index" do
           get :index
           assert_response :success
        end   
        
        test "should get new" do
           #simulating a logged in user that is an admin, the @user is created in the setup method
            session[:user_id] = @user.id
            get :new
            assert_response :success
        end
        
        test "should get show" do
            get(:show, {'id' => @category.id })
            assert_response :success
        end 
        
          test "should redirect create when admin not logged in" do
            assert_no_difference 'Category.count' do
                post :create, category: { name: "sports" }
            end
            assert_redirected_to categories_path
          end
        
end