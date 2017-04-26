class SessionsController < ApplicationController
        
        
        #renders form for a new login
        def new 
        end 
            #new and create share the same new.html.erb file in the view
        #submits form 
        def create
            user = User.find_by(email: params[:session][:email].downcase)
            
            #this saves the current users id within your browser session
            #stored by your browser and then used for requests
            # to simulate a user being logged in
            # your basically saving the users id in the sessions hash which is backed by your browsers cookies
            session[:user_id] = user.id
            
            #need to create varification that the email exists
            # if user exists && the user password autheticates
            if user && user.authenticate(params[:session][:password])
                flash[:success] = "You have succesfully logged in"
                #after login succesfully is sends the user to their user controller, show action, show.html.erb
                redirect_to user_path(user)
                
            else
                #flash persists for 1 http request, when your rendering new, its not considered a new request
                #flash.now makes sure the message only shows up on this 1 page, and not the next 1
                flash.now[:danger] = "there was something wrong with your login information"
                render 'new'
            
            end 
        end
       
        #log outs, stops sessions and moves user to logged out state
        def destroy
            session[:user_id] = nil
            flash[:success] = "You have logged out"
            redirect_to root_path
        end 
end
