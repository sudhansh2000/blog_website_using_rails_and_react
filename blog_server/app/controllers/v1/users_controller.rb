class V1:: UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :show, :update ]
  skip_before_action :authenticate_user!, if: -> { Rails.env.test? }

  def index
    users = User.all
    if params[:page_no].present? && params[:page_size].present?
      page_size = params[:page_size].to_i
      page_offset = (params[:page_no].to_i - 1) * page_size
      users = users.offset(page_offset).limit(page_size)
    end
    render json: users
  end

  def show
    user = User.find_by(id: params[:id])
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
