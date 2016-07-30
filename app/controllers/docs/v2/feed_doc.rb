class Docs::V2::FeedDoc < Docs::V2::Base
  resource_description do
    resource_id 'Feed'
    description <<-EOS
      Feed includes posts with tags that match to the logged in user interests.

      Feed posts are ordered by creation date in a descending order and are limited up to 10 posts
    EOS
  end

  api :GET, '/feed', 'Show logged in user feed'
  def index; end
end
