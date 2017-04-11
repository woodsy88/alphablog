class User < ActiveRecord::Base
    #associates user with articles with a 1 to many association
    has_many :articles
    #before users email is saved to the database it is set to lowercase characters
    before_save {self.email = email.downcase}
       #validates user name
        validates :username, presence: true,
        uniqueness: { case_sensitive: false },
        length: { minimum: 3, maximum: 25 }
       #validates email
        VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        validates :email, presence: true, length: { maximum: 105 },
        uniqueness: { case_sensitive: false },
        format: { with: VALID_EMAIL_REGEX }
end
