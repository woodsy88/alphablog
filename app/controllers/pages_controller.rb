class PagesController < ApplicationController
    
    def home
        #if a user is logged in then redirect them to the articles page
        #this controls the user seeing articles page if logged in and home page if logged out 
        redirect_to articles_path if logged_in?
    end
    
    def about
    end
    
    def blog
    end 
    
end