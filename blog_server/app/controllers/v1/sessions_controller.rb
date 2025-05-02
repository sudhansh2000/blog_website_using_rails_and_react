class V1::SessionsController < ApplicationController
  def create
    user = User.find_for_database_authentication(email: params[:user][:email])

    # If user exists and the password matches
    if user&.valid_password?(params[:user][:password])
      # Generate the JWT token
      token = encode_token(user_id: user.id)
      render json: { user: user, token: token }, status: :ok
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  # DELETE /sign_out
  def destroy
    # Logic for handling logout, if needed
    head :no_content
  end

  private

  # Your encode_token method
  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end
