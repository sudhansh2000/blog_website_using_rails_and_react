class V1::Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    users = User.unscoped.where(role: "user").select(:id, :first_name, :last_name, :user_name, :email, :is_active, :created_at)
    render json: users
  end

  def update
    user = User.unscoped.find(params[:id])
    new_is_active = !user.is_active

    if user.update(is_active: new_is_active)
      render json: { user: user, message: "User updated by admin successfully" }
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def authorize_admin!
    unless current_user&.role == "admin"
      render json: { error: "Admins only" }, status: :unauthorized
    end
  end

  # def user_params
  #   params.require(:user).permit(:first_name, :last_name, :user_name, :email, :is_active)
  # end
end
