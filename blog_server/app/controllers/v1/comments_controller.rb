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
    respond_to do |format|
      format.html
      format.json { render json: comments }
    end
  end

  def show
  end

  def create

    # post = Post.find(param[:post_id])

  end

  def update
    comment = Comment.find(params[:id])
    if comment.update(comment_params)
      render json: { comment: comment, message: "Comment updated successfully" }, status: :ok
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
  end

  def comment_params
    params.require(:comment).permit(:post_id, :user_id, :parent_id, :content)
  end
end
