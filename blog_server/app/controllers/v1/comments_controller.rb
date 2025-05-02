class V1:: CommentsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :update, :destroy ]
  skip_before_action :authenticate_user!, if: -> { Rails.env.test? }

  def index
    comments = if params[:post_id].present?
      comment_replies_count = Comment.group(:parent_id).count

      Comment.joins(:user).
        where(post_id: params[:post_id], parent_id: nil).map do |comment|
          {
            id: comment.id,
            user_name: comment.user.user_name,
            content: comment.content,
            parent_id: comment.parent_id,
            created_at: comment.created_at,
            replies_count: comment_replies_count[comment.id]
          }
        end

    elsif params[:user_id].present?
      Comment.joins(:post).
      where("comments.user_id = ?", params[:user_id]).
      select("comments.id, title, comments.content, parent_id, comments.created_at, post_id")

    elsif params[:comment_id].present?

      comment_replies_count = Comment.group(:parent_id).count

      Comment.joins(:user).
        where(parent_id: params[:comment_id]).map do |comment|
          {
            id: comment.id,
            user_name: comment.user.user_name,
            content: comment.content,
            parent_id: comment.parent_id,
            created_at: comment.created_at,
            replies_count: comment_replies_count[comment.id]
          }
        end

    else
      Comment.all
    end

    render json: comments
  end

  def create
    if params[:comment_id].present?
      parent_comment = Comment.find(params[:comment_id])
      comment = parent_comment.replies.new(post_id: parent_comment.post_id,
                                           parent_id: params[:comment_id],
                                           user_id: params[:comment][:user_id],
                                           content: params[:comment][:content]
                                          )
    else
      comment = Comment.new(comment_params)
      comment.post_id = params[:post_id]
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

  private
  def comment_params
    params.require(:comment).permit(
      :user_id, :post_id, :parent_id, :content
    )
  end
end
