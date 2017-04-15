module ApplicationHelper
    #size is set here
    def gravatar_for(user, options = {size: 80})
        #hex digest method
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
          #size is set here
        size = options[:size]                                           #size is set here
        gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.username, class: "img-circle")
    end
end
