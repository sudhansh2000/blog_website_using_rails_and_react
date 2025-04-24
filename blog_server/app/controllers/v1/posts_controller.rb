class V1:: PostsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    page_size = 2

    if params[:category_id].present?
      category = Category.find(params[:category_id])
      posts = category.posts

    elsif params[:user_id].present?
      user = User.find(params[:user_id])
      posts = user.posts

    else
      posts = Post.all
    end

    if params[:page_no].present?
      page_offset = (params[:page_no].to_i -1) * page_size
      posts = posts.offset(page_offset).limit(page_size)
    end

    render json: posts
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
    end

    if post.save
      render json: { post: post, message: "Post created successfully" }, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    post = Post.find(params[:id])

    if params[:post][:tags].present?
      temp = (params[:post][:tags]).split(" ")
      temp.each do |tag|
        post.tags.push(tag)
        puts post.tags
      end
    end

    post.tags.uniq!

    if post.update(category_id: params[:post][:category_id],
       title: params[:post][:title],
       content: params[:post][:content],
       is_private: params[:post][:is_private]
    )
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
