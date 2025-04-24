class V1:: CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    if params[:post_id].present?
      post = Post.find(params[:post_id])
      comments = post.comments

    elsif params[:user_id].present?
      user = User.find(params[:user_id])
      comments = user.comments

    else
      comments = Comment.all
    end

    render json: comments, include: [ :user, :post ]
  end

  def create
    if params[:comment_id].present?
      parent_comment = Comment.find(params[:comment_id])
      comment = parent_comment.replies.new(post_id: parent_comment.post_id, parent_id: params[:parent_id], user_id: params[:user_id], content: params[:comment][:content])
    else
      comment = Comment.new(post_id: params[:post_id], user_id: params[:user_id], parent_id: params[:parent_id], content: params[:comment][:content])
    end

    if comment.save
      render json: { comment: comment, message: "Comment created successfully" }, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update(content: params[:comment][:content])
      render json: { comment: comment, message: "Comment updated successfully" }, status: :ok
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      render json: { message: "Comment deleted successfully" }, status: :ok
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
