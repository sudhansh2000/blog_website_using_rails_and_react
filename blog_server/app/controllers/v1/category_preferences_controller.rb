class V1::CategoryPreferencesController < ApplicationController
  def index
    category_preferences = CategoryPreference.where(user_id: params[:user_id])
    render json: category_preferences
  end

  def create
    user_id = params[:user_id]
    category_ids = params.dig(:category_preference, :ids) || []

    created = []

    category_ids.each do |category_id|
      pref = CategoryPreference.find_or_initialize_by(user_id: user_id, category_id: category_id)
      created << pref if pref.new_record? && pref.save
    end

    if created.any?
      render json: { message: "Preferences created", created_count: created.count }, status: :created
    else
      render json: { message: "No new preferences created" }, status: :ok
    end
  
  end
end
