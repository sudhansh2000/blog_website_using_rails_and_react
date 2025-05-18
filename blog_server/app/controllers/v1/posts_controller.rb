class V1:: PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :update, :destroy ]
  skip_before_action :authenticate_user!, if: -> { Rails.env.test? }
  before_action :authorize_user!, only: [ :update, :destroy ]
  skip_before_action :authorize_user!, if: -> { Rails.env.test? }

  def index
    posts = if params[:category_id].present?
      Post.where(category_id: params[:category_id], is_private: false).select_post
    elsif params[:user_id].present?
      Post.where(user_id: params[:user_id]).select_post
    else
      Post.where(is_private: false).select_post
    end

    if params[:page_no].present? && params[:page_size].present?
      page_size = params[:page_size].to_i
      page_offset = (params[:page_no].to_i - 1) * page_size
      posts = posts.offset(page_offset).limit(page_size)
    end

    render json: posts
  end

  def show
    post = Post.joins(:category, :user).
      where("posts.id = ?", params[:id]).
      select("posts.id, posts.title,
        users.id as user_id,
        posts.content,
        posts.created_at,
        posts.is_private,
        user_name,
        users.first_name,
        users.last_name,
        categories.cat_name,
        tags").first

    render json: post
  end

  def create
    post = Post.new(post_params)
    post.user_id = params[:user_id]

    if post.save
      render json: { post: post, message: "Post created successfully" }, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    post = Post.find_by(id: params[:id])

    if post.update(post_params)
      post.tags.uniq!
      render json: { post: post, message: "Post updated successfully" }, status: :ok
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:id])

    if post.destroy
      render json: { message: "Post deleted successfully" }, status: :ok
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def authorize_user!
    post = Post.find_by(id: params[:id])
    unless post && post.user == current_user
      render json: { errors: "unauthorized user" }, status: :unauthorized and return
    end
  end

  def post_params
    params.require(:post).permit(
      :category_id, :title, :content, :is_private, tags: []
    )
  end
end
