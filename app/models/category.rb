class Category < ActiveRecord::Base
    #cateogry has many article categories
    has_many :article_categories
    has_many :articles, through: :article_categories
    #cateory must have a name column 
    validates :name, presence: true, length: {minimum: 3, maximum: 25}
    
    #makes sure no 2 name categories can have the same name
    validates_uniqueness_of :name
    
    
end 