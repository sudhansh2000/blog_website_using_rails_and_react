# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def create
    user = User.find_for_database_authentication(email: params[:email])

    if user&.valid_password?(params[:password])
      token = encode_token(user_id: user.id)
      render json: { user: user, token: token }, status: :ok
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  def destroy
    # You could implement token invalidation logic here if needed
    render json: { message: "Successfully logged out" }, status: :ok
  end
end
