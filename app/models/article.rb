class Article < ActiveRecord::Base 

#associates the article id with the user 
belongs_to :user

#each article can have many categories
has_many :article_categories
# has many categories through article categories
has_many :categories, through: :article_categories

#makes sure when you create an article it contains a title and a description.
#before a new article hits the database this ensures that it has an title, description
validates :title, presence: true, length: {minimum: 3, maximum: 50}

validates :description, presence: true, length: {minimum: 10, maximum: 300}

#makes sure each article has a user id present
validates :user_id, presence: true
end
