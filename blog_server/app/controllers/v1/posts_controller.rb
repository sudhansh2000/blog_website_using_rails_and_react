class V1:: PostsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:category_id].present?
      category = Category.find(params[:category_id])
      posts = category.posts.select("posts.id, title, tags, created_at")

    elsif params[:user_id].present?
      user = User.find(params[:user_id])
      posts = user.posts.select("posts.id, title, tags, created_at")

    else
      posts = Post.all.select("posts.id, title, tags, created_at")
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
    post = Post.find(params[:id])

    post.tags.uniq!

    if post.update(post_params)
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
  def post_params
    params.require(:post).permit(
      :user_id, :category_id, :title, :content, :is_private, :tags
    )
  end
end
