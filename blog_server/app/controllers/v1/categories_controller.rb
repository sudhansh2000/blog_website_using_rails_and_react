class V1:: CategoriesController < ApplicationController
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
    category = Category.find(params[:id])
    if category.update(cat_name: params[:category][:cat_name])
      render json: { category: category, message: "Category updated successfully" }, status: :ok
    else
      render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    category = Category.find(params[:id])
    unless category.nil?
      category.destroy
      render json: { message: "Category deleted successfully" }, status: :ok
    else
      render json: { message: "Category Not found" }, status: :not_found
    end
  end
end
