class V1::CategoryPreferencesController < ApplicationController
  def index
    category_preferences = CategoryPreference.where(user_id: params[:user_id])
    render json: category_preferences
  end

  def create
    user_id = params[:user_id]
    category_ids = params.dig(:category_preference, :ids) || []

    category_ids.each do |category_id|
      CategoryPreference.create(user_id: user_id, category_id: category_id)
    end

    render json: { message: "Preferences created" }, status: :created
  end
end
