class ArticlesController < ApplicationController
    
def new
    @article = Article.new
end

def create
    @article = Article.new(article_params)
    @article.save
    #redirect to articles controler, #show path with the @article
    redirect_to articles_show(@article)
end 




private

    def article_params
        #for the article (@article) object permit params title and description
        params.require(:article).permit(:title, :description)
    end


end