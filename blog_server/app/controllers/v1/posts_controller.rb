class V1:: PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  # def index
  #   @posts = Post.includes(:comments)
  #   respond_to do |format|
  #     format.html
  #     format.json { render json: @posts }
  #   end
  # end

  def index
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @posts = @user.posts
    elsif params[:category_id].present?
      @category = Category.find(params[:category_id])
      @posts = @category.posts
    else
      @posts = Post.joins(:user).select("posts.*, first_name, last_name")
    end
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @post=Post.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = params[:user_id]
    if @post.tags.present?
      @post.tags = params[:post][:tags].split(" ")
      puts @post.tags.length
    end
    # puts params[:tags]
    if @post.save
      render json: { post: @post, message: "Post created successfully" }, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    # tags_param = params.dig(:post, :tags)
    # if tags_param.present?
    #   @post.tags = tags_param.is_a?(String) ? tags_param.split(" ") : tags_param[:tags]
    # end
    # if @post.update(post_params.except(:tags))
    #   render json: { post: @post, message: "Post updated successfully" }, status: :ok
    # else
    #   render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    # end
    @post = Post.find(params[:id])
    # @post.category_id = params[:category_id]
    if params[:post][:tags].present?
      temp = (params[:post][:tags]).split(" ")
      puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      puts @post.tags
      temp.each do |tag|
        @post.tags << tag unless @post.tags.include?(tag)
      end
      # @post.tags = @post.tags.uniq
      puts @post.tags.length
    end
    # puts params[:tags]

    if @post.update(params[:post])
      respond_to do |format|
        format.html { redirect_to @post }
        format.json { render json: @post, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post=Post.find(params[:id])
    if @post.destroy
      render json: { message: "Post deleted successfully" }, status: :ok
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def post_params
    params.require(:post).permit(
      :user_id, :category_id, :title, :content, :is_private, :tags
    )
  end
end
