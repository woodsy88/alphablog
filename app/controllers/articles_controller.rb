class ArticlesController < ApplicationController
    
def new
    @article = Article.new
end

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


def show
    #finds articles based on their id and shows them in views/articles/show.html.erb
   @article = Article.find(params[:id]) 
end




private

    def article_params
        #for the article (@article) object permit params title and description
        params.require(:article).permit(:title, :description)
    end


end