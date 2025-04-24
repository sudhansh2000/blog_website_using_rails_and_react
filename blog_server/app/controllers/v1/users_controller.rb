class V1:: UsersController < ApplicationController
  # skip the authetication part in the controller
  skip_before_action :verify_authenticity_token
  def index
    page_size = 2
    user = User.all
    if params[:page_no].present?
      page_offset = (params[:page_no].to_i - 1) * page_size
      user = user.offset(page_offset).limit(page_size)
    end
    render json: user
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: { user: user, message: "User updated successfully" }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { user: user, message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :user_name,
      :email, :phone_number, :password,
      :dob, :is_active
    )
  end
end
