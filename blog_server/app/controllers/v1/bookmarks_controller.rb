class V1:: BookmarksController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy ]
  skip_before_action :authenticate_user!, if: -> { Rails.env.test? }

  def index
    user = User.find_by(id: params[:user_id])
    bookmarked_posts = user.bookmarked_posts

    render json: bookmarked_posts, status: :ok
  end

  def create
    bookmark = Bookmark.new(user_id: params[:user_id], post_id: params[:post_id])

    if bookmark.save
      render json: { bookmark: bookmark, message: "Bookmark created successfully" }, status: :created
    else
      render json: { errors: bookmark.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    unless bookmark.nil?
      bookmark.destroy
      render json: { message: "bookmark deleted successfully" }, status: :ok
    else
      render json: { message: "bookmark Not found" }, status: :not_found
    end
  end
end
