class Article < ActiveRecord::Base 
#makes sure when you create an article it contains a title and a description.
#before a new article hits the database this ensures that it has an title, description
validates :title, presence: true, length: {minimum: 3, maximum: 50}

validates :description, presence: true, length: {minimum: 10, maximum: 300}
end
