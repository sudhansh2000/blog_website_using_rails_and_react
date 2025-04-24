class V1:: CategoriesController < ApplicationController
  def index
    @categories = Category.all
    respond_to do |format|
      format.html
      format.json { render json: @categories }
    end
  end

  def show
    Category.find(params[:id])
    categories = Category.allocate
    respond_to do |format|
      format.html
      format.json { render json: @categories }
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      render json: { category: @category, message: "Category created successfully" }, status: :created
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      render json: { category: @category, message: "Category updated successfully" }, status: :ok
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def category_params
    params.require(:category).permit(:cat_name)
  end
end
