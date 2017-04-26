class ArticlesController < ApplicationController
 # the before actions run in order  
   #makes the set_article method from the bottom of the page(private) avaialble at the start of the 4 actions listed
   # the order of actions between [ ] is important, order them in the order you want them to execute
before_action :set_article, only: [:edit, :update, :show, :destroy]

 
 # require_user restricts controller actions to certain users 
 # require someone be logged in as a user, except for the index and show actions 
 #except for the index and show actions you need to be logged in 
 before_action :require_user,  except: [:index, :show]
 
 #this requires that it be the same user that created the article to edit, update and destroy it
 #require_same_use is in articles controller
 before_action :require_same_user, only: [:edit, :update, :destroy]

#Index shows a list of all the articles created, it needs an index.html.erb
#/articles***
    def index
        #grabs all articles in database
       # @articles = Article.all
       #by default this will only load 20 single @article per page
       @articles = Article.paginate(page: params[:page], per_page: 5)
    end 


#is the html page for entering and creating a new article. new.html.erb
#/articles/new***
    def new
        @article = Article.new
    end

#Create is what actually creates the new article from the new action. no html.erb
    def create
     
        @article = Article.new(article_params)
        
         #ensures article has a user
         @article.user = User.last
       
        #redirect to articles controler, #show path with the @article
       # redirect_to article_path(@article)
        
        if @article.save
            #this flash is in the partial layouts/_messages.html.erb
            flash[:success] = "Article was succesfully created"
            redirect_to article_path(@article)
            
        else
            # this just re-renders a new template
            render 'new'
        end 
    end 

# Show - finds and shows a single article details using show.html.erb 
# articles/id***
    def show
      #finds articles based on their id and shows them in views/articles/show.html.erb
      # @article = Article.find(params[:id]) 
      
    end

# edit is the action that shows the individual article you want to edit. it has edit.html.erb
# articles/id/edit***
    def edit
       # @article = Article.find(params[:id])
       
    end 

#update is the action that actually updates the article with the new info from the edit action. it does not have an html.erb
    def update
      #@article = Article.find(params[:id])  
    
      if @article.update(article_params)
           #this flash is in the partial layouts/_messages.html.erb
          flash[:success] = "Article was succesfully updated"
          redirect_to article_path(@article)
      else
          render 'edit'
      end
    end 

    def destroy
        #@article = Article.find(params[:id])
        
        @article.destroy
         #this flash is in the partial layouts/_messages.html.erb
        flash[:danger] = "Article was succesfully deleted"
        redirect_to articles_path
    end




private

    def set_article
       @article = Article.find(params[:id]) 
    end
    
    def article_params
        #for the article (@article) object permit params title and description
        params.require(:article).permit(:title, :description)
    end
    
    def require_same_user
        # != not equal to
        if current_user != @article.user
            flash[:danger] = "You can only edit or delete your own articles"
            redirect_to root_path
        end 
    end
    


end