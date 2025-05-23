class V1:: CategoriesController < ApplicationController
  # before_action :authenticate_user!, only: [ :create, :update, :destroy ]
  # skip_before_action :authenticate_user!, if: -> { Rails.env.test? }
  before_action :authorize_admin!, only: [ :create, :update, :destroy ]
  skip_before_action :authorize_admin!, if: -> { Rails.env.test? }

  def index
    categories = Category.all
    render json: categories
  end

  def create
    category = Category.new(cat_name: params[:category][:cat_name])
    if category.save
      render json: { category: category, message: "Category created successfully" }, status: :created
    else
      render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    category = Category.find_by(id: params[:id])
    if category.update(cat_name: params[:category][:cat_name])
      render json: { category: category, message: "Category updated successfully" }, status: :ok
    else
      render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    category = Category.find_by(id: params[:id])
    unless category.nil?
      category.destroy
      render json: { message: "Category deleted successfully" }, status: :ok
    else
      render json: { message: "Category Not found" }, status: :not_found
    end
  end

  private

  def authorize_admin!
    unless current_user && current_user.role == "admin"
      render json: { error: "Admins only" }, status: :unauthorized
    end
  end
end
