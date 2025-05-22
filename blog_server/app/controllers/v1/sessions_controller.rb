class V1::SessionsController < ApplicationController
  def create
    user = User.find_for_database_authentication(email: params[:user][:email])

    if user&.valid_password?(params[:user][:password])
      token = encode_token(user_id: user.id)
    user_data = user.slice(:id, :first_name, :last_name, :role, :user_name)
      render json: { user: user_data, token: token }, status: :ok
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  def destroy
    render json: { message: "Successfully logged out" }, status: :ok
  end

  private

  # Your encode_token method
  def encode_token(payload)
    payload[:exp] = 24.hours.from_now.to_i
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end
