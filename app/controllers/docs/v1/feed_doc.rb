class Docs::V1::FeedDoc < Docs::V1::Base
  resource_description do
    resource_id 'Feed'
    description <<-EOS
      Feed includes posts of users that are followed by the logged in user.

      Feed posts are ordered by creation date in a descending order and are limited up to 10 posts
    EOS
  end

  api :GET, '/feed', 'Show logged in user feed'
  def index; end
end
