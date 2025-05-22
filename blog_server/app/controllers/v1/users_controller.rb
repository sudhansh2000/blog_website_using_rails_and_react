class V1:: UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :update ]
  skip_before_action :authenticate_user!, if: -> { Rails.env.test? }
  before_action :authorize_user!, only: [ :update ]
  skip_before_action :authorize_user!, if: -> { Rails.env.test? }

  # get user data for adminx


  def index
    users = User.where(role: "user").select("id, first_name, last_name, user_name")
    if params[:page_no].present? && params[:page_size].present?
      page_size = params[:page_size].to_i
      page_offset = (params[:page_no].to_i - 1) * page_size
      users = users.offset(page_offset).limit(page_size)
    end
    render json: users, status: 200
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
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: { user: user.slice(:id, :first_name, :last_name, :email), message: "User created successfully" }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def authorize_user!
    user = User.find_by(id: params[:id])
    unless user && user == current_user
      render json: { errors: "unauthorized user" }, status: :unauthorized and return
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
