class API::V2::FeedController < API::APIController
  def index
    posts = Post.order(created_at: :desc).select do |post|
      (post.tags & current_user.interests).any?
    end

    respond_with posts, each_serializer: ::V2::PostShortSerializer
  end
end
