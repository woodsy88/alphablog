class UsersController < ApplicationController
   
   
   #New and Create share the new.html.erb
  #this initiates a new user, then create saves it, both sharing new.html.erb
   def new
       @user = User.new 
   end 
   #create saves the user from the new action to the database
   def create
    @user = User.new(user_params)
            if @user.save 
                flash[:success] = "Welcome to the alpha blog #{@user.username}"
                redirect_to articles_path
            else
                #renders the new user template again
                render 'new'
            end 
   end
   
   
   #Edit and Update share thew edit.html.erb
        #edit finds the user, then update actually updates the user to the database
   def edit
       @user = User.find(params[:id])
   end
   
   
   def update
       #finds the existing user by its params
       @user = User.find(params[:id])
       #updates user
       if @user.update(user_params)
           flash[:succes] = "Your Account Was Updated Successfully"
           redirect_to articles_path 
       else
           render 'edit'
       end
   end
   
   
   
   private
       def user_params
           # require user controller, permit the parameters(columns) username, email, password
          params.require(:user).permit(:username, :email, :password) 
       end
    
end