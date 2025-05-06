class V1::SharePostsController < ApplicationController
  before_action :authenticate_user!, only: [ :create ]
  skip_before_action :authenticate_user!, if: -> { Rails.env.test? }

  before_action :set_user, only: :index
  def index
    user_id = params[:user_id]

    shared_data = SharePost
      .joins(:post, sender: :posts)
      .where(receiver_id: user_id)
      .select(
        "share_posts.created_at AS shared_on,
        users.user_name AS sender_username,
        posts.title AS post_title,
        posts.tags"
      )
      .order("share_posts.created_at DESC")

    render json: shared_data.map do |shared_on, username, title, tags|
      {
        shared_on: shared_on.strftime("%Y-%m-%d %H:%M:%S"),
        sender_username: username,
        post_title: title,
        tags: JSON.parse(tags || "[]")
      }
    end
  end

  def create
    sender_id = params[:user_id].to_i
    receiver_id = params[:receiver_id].to_i

    if sender_id == receiver_id
      return render json: { error: "Cannot send post to yourself" }, status: :bad_request
    end

    share_post = SharePost.new(
      sender_id: sender_id,
      receiver_id: receiver_id,
      post_id: params[:post_id]
    )

    if share_post.save
      render json: share_post, status: :created
    else
      render json: { error: share_post.errors.full_messages }, status: :unprocessable_entity
    end

  rescue ActiveRecord::RecordNotUnique
    render json: { error: "Post has already been shared with this user" }, status: :unprocessable_entity
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
    render json: { error: "User not found" }, status: :not_found unless @user
  end
end
