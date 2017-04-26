class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  #methods in the application controller are usable by all your controllers, but are not usable by default by your views
  
  #the helper method allows these 2 methods to be used by the views 
  helper_method :current_user, :logged_in?
  
      def current_user
                            #return this user if there is a user id stored in the database
          @current_user ||= User.find(session[:user_id]) if session[:user_id]
          
          #the above @current_user method first checks if there is already a current user logged in then ||= moving on to the User.find
      end
      
      def logged_in?
      #will return true if there is a user logged in and false if there is no user logged in
        !!current_user
      end
      
      #allows you to restirct actions if the user is not logged in
      
      def require_user
       #if not logged in 
        if !logged_in?
          flash[:danger] = "You must be logged in to perform that action"
          redirect_to root_path
        end
        
        
      end 
  
  
  
  
end
