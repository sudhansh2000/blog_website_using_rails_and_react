class V1:: LikesController < ApplicationController
  before_action :authenticate_user!, only: [ :create ]
  skip_before_action :authenticate_user!, if: -> { Rails.env.test? }

  def index
    likes = if params[:post_id].present?
      post = Post.find(params[:post_id])
      { total_likes: post.likes.count }
    elsif params[:comment_id].present?
      comment = Comment.find(params[:comment_id])
      { total_likes: comment.likes.count }
    elsif params[:user_id].present?
      Post.joins(:likes).where("likes.user_id = ?", params[:user_id]).
        select("posts.id, title, likes.created_at")
    end
    render json: likes
  end

  def create
    if params[:post_id].present?
      post = Post.find(params[:post_id])
      like = post.likes.create(user_id: params[:user_id])
      render json: like, status: :created
    elsif params[:comment_id].present?
      comment = Comment.find(params[:comment_id])
      like = comment.likes.create(user_id: params[:user_id])
      render json: like, status: :created
    else
      render json: { error: "Missing parameter: post_id or comment_id" }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotUnique
    render json: { error: "alrady liked this post" }, status: :unprocessable_entity
  end
end
