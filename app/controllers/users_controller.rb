class UsersController < ApplicationController
   
   #this before_action replaces @user = User.find(params[:id]) for the edit, update and show action
      #set_user is a private method at the bottom that holds @user = User.find(params[:id])
   before_action :set_user, only: [:edit, :update, :show]
  
  
  before_action :require_same_user, only: [:edit, :update]
  
  
   #New and Create share the new.html.erb
  #this initiates a new user, then create saves it, both sharing new.html.erb
  #/signup***
   def new
       @user = User.new 
   end 
   #create saves the user from the new action to the database
   def create
    @user = User.new(user_params)
            if @user.save 
                #signs user in after they signup
                session[:user_id] = @user.id
                
                flash[:success] = "Welcome to the alpha blog #{@user.username}"
                #sends user to their  user show page - profile page after signing up
                redirect_to user_path(@user)
            else
                #renders the new user template again
                render 'new'
            end 
   end
   
   
   #Edit and Update share thew edit.html.erb
        #edit finds the user, then update actually updates the user to the database
        # users/id/edit***
   def edit
       #@user = User.find(params[:id]) 
       #replced by the before_action at the top
   end
   
   #edit and update go together, edit shows the form with the users info from edit.html.er 
   # update send the information from the edit action to the database
   def update
       #finds the existing user by its params
       #@user = User.find(params[:id])
            #replced by the before_action at the top
      
      
       #updates user
       if @user.update(user_params)
           flash[:succes] = "Your Account Was Updated Successfully"
           redirect_to articles_path 
       else
           render 'edit'
       end
   end
   
   
   #Show action shows a single users information
   # /users/id***
   def show
       #@user = User.find(params[:id])
       #replced by the before_action at the top
       
       
       # 1 -we cant use pagination like we do in index, since there is only 1 user, 
       # 1.1 - this instead sets @user_articles to hold all the articles the user created. 
       #1.3 then it paginates that list  of the users articles, not the user
       #1.4 - because you store all the @user.articles in an instance varianble @user_articles 
       # 1.5 - it can be used in the view - show.html.erb 
       @user_articles = @user.articles.paginate(page: params[:page], per_page: 2)
   end 
   
   # Index shows all the users data
   # /users****
   def index
       #finds all users
       #@users = User.all
       @users = User.paginate(page: params[:page], per_page: 5)
   end
   
   
   private
       def user_params
           # require user controller, permit the parameters(columns) username, email, password
          params.require(:user).permit(:username, :email, :password) 
       end
    
       # finds user by its ID and sets it to @user
            def set_user
                @user = User.find(params[:id])
            end
            
            def require_same_user
               if current_user != @user
                   flash[:danger] = "You can only edit your own account"
                   redirect_to root_path
               end 
            end
end