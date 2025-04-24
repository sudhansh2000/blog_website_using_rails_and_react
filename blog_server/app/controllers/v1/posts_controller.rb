class V1:: PostsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:user_id].present?
      user = User.find(params[:user_id])
      posts = user.posts
    elsif params[:category_id].present?
      category = Category.find(params[:category_id])
      posts = category.posts
    else
      posts = Post.joins(:user).select("posts.*, first_name, last_name")
    end
    render json: posts, include: [ :user, :category ]
  end

  def show
    post=Post.find(params[:id])
    render json: post
  end

  def create
    post = Post.new(post_params)
    post.user_id = params[:user_id]
    if post.tags.present?
      post.tags = params[:post][:tags].split(" ")
      puts post.tags.length
    end
    # puts params[:tags]
    if post.save
      render json: { post: post, message: "Post created successfully" }, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    post = Post.find(params[:id])
    # post.category_id = params[:category_id]
    if params[:post][:tags].present?
      temp = (params[:post][:tags]).split(" ")
      # puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      # puts post.tags
      temp.each do |tag|
        post.tags << tag unless post.tags.include?(tag)
      end
      # post.tags = post.tags.uniq
      puts post.tags.length
    end
    # puts params[:tags]

    if post.update(params[:post])
      render json: { post: post, message: "Post updated successfully" }, status: :ok
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    post=Post.find(params[:id])
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
