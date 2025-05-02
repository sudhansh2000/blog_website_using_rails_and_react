class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  skip_before_action :verify_authenticity_token
  allow_browser versions: :modern
  include Devise::Controllers::Helpers

  SECRET_KEY = Rails.application.secret_key_base.to_s

  # Authenticate the user via JWT token
  def authenticate_user!
    token = request.headers["Authorization"]&.split(" ")&.last
    if token
      begin
        decoded_token = JWT.decode(token, SECRET_KEY, true, { algorithm: "HS256" })
        user_id = decoded_token.first["user_id"]
        @current_user = User.find_by(id: user_id)
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        render json: { error: "Invalid or expired token" }, status: :unauthorized
      end
    else
      render json: { error: "Token missing" }, status: :unauthorized
    end
  end

  # Helper to encode the JWT token
  def encode_token(payload)
    JWT.encode(payload, SECRET_KEY)
  end

  # Retrieve the current user from the decoded token
  def current_user
    @current_user ||= authenticate_user!  # This calls authenticate_user! only once and sets @current_user
  end

  # Helper method to get the authorization header
  def auth_header
    request.headers["Authorization"]
  end

  # Decodes the token, used to fetch current user
  def decoded_token
    if auth_header
      token = auth_header.split(" ")[1]
      begin
        JWT.decode(token, SECRET_KEY)[0]
      rescue JWT::DecodeError
        nil
      end
    end
  end
end
