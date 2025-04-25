class V1:: LikesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:post_id].present?
      post = Post.find(params[:post_id])
      likes = { total_likes: post.likes.count }

    elsif params[:comment_id].present?
      comment = Comment.find(params[:comment_id])
      likes = { total_likes: comment.likes.count }

    else params[:user_id].present?
      likes = Post.joins(:likes).where("likes.user_id = ?", params[:user_id]).
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
  end
end
