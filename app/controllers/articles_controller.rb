class ArticlesController < ApplicationController
    

#Index shows a list of all the articles created, it needs an index.html.erb
    def index
        #grabs all articles in database
        @articles = Article.all
    end 


#is the html page for entering and creating a new article. new.html.erb
    def new
        @article = Article.new
    end

#Create is what actually creates the new article from the new action. no html.erb
    def create
        @article = Article.new(article_params)
       
       
        #redirect to articles controler, #show path with the @article
       # redirect_to article_path(@article)
        
        if @article.save
            
            flash[:notice] = "Article was succesfully created"
            redirect_to article_path(@article)
            
        else
            # this just re-renders a new template
            render 'new'
        end 
    end 

# Show - finds and shows a single article details using show.html.erb 
    def show
        #finds articles based on their id and shows them in views/articles/show.html.erb
       @article = Article.find(params[:id]) 
    end

# edit is the action that shows the individual article you want to edit. it has edit.html.erb
    def edit
        @article = Article.find(params[:id])
    end 

#update is the action that actually updates the article with the new info from the edit action. it does not have an html.erb
    def update
      @article = Article.find(params[:id])  
    
      if @article.update(article_params)
          flash[:notice] = "Article was succesfully updated"
          redirect_to article_path(@article)
      else
          render 'edit'
      end
    end 

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        
        flash[:notice] = "Article was succesfully deleted"
        redirect_to articles_path
    end




private

    def article_params
        #for the article (@article) object permit params title and description
        params.require(:article).permit(:title, :description)
    end


end