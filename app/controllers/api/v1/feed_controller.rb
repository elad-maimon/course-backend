class API::V1::FeedController < API::APIController
  def index
    posts = Post.order(created_at: :desc).select do |post|
      current_user.following.include? post.user
    end

    respond_with posts, each_serializer: ::V1::PostShortSerializer
  end
end
