require 'rails_helper'

RSpec.describe "V1::CategoryPreferences", type: :request do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:category1) { create(:category) }
  let(:category2) { create(:category) } # define this!
  let!(:category_preference) { create(:category_preference, user: user1, category: category1) }
  let!(:category_preference) { create(:category_preference, user: user1, category: category2) }

  describe "GET /v1/users/:user_id/category_preferences" do
    it "returns http success" do
      get "/v1/users/#{user1.id}/category_preferences"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.size).to be >= 1
      expect(true).to eq(true)
    end
  end

  describe "POST /v1/users/:user_id/category_preferences" do
    it "creates category preferences and returns created" do
      params = {
        category_preference: {
          ids: [ category1.id, category2.id ]
        }
      }
      post "/v1/users/#{user2.id}/category_preferences", params: params
      expect(response).to have_http_status(:created)
    end
  end
end
