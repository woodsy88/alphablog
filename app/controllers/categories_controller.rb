class CategoriesController < ApplicationController
    before_action :require_admin, except: [:index, :show]
    
    def index
        @categories = Category.paginate(page: params[:page], per_page: 5)
    end
    
    def new 
        @category = Category.new
    end
    
    def show
        
    end 
    
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:success] = "Category was created succesfully"
            redirect_to categories_path
        else
            render 'new'
        end 
    end

    private
    
    def category_params
        params.require(:category).permit(:name)
        
    end
    
    
    def require_admin
        # if not logged in OR logged in and current user is not an admin then show error message and redirect to categories path
        if !logged_in? || (logged_in? and !current_user.admin?)
            flash[:danger] = "only admins can perform that action"
            redirect_to categories_path
        end
        
    end
    
end 