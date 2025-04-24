class V1:: LikesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    if params[:post_id].present?
      post = Post.find(params[:post_id])
      likes = post.likes.count
    elsif params[:comment_id].present?
      comment = Comment.find(params[:comment_id])
      likes = comment.likes.count
    else params[:user_id].present?
      user = User.find(params[:user_id])
      likes = User.joins(:likes).where(user_id: params[:user_id]).select()
      likes = user.likes
    end

    render json: likes
  end

  def show
    like = Like.find(params[:id])
    render json: likes
  end

  def create
    if params[:post_id].present?
      post = Post.find(paraams[:post_id])
      post.likes.create(user_id: params[:user_id])
    else
      comment = Comment.find(params[comment: id])
      comment.likes.create(user_id: params[:user_id])
    end

    like = Like.new(user_id: params[:user_id],).save
    like.user_id = params[:user_id]

    if like.save
      render json: { like: like, message: "Like created successfully" }, status: :created
    else
      render json: { errors: like.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # def update
  #   like = Like.find(params[:id])
  #   if like.update(like_params)
  #     render json: { like: like, message: "Like updated successfully" }, status: :ok
  #   else
  #     render json: { errors: like.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end
  # def destroy
  #   like = Like.find(params[:id])
  #   if like.destroy
  #     render json: { message: "Like deleted successfully" }, status: :ok
  #   else
  #     render json: { errors: like.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end
  def like_params
    params.require(:like).permit(:post_id, :comment_id, :user_id)
  end
end
