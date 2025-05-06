require 'rails_helper'

RSpec.describe "V1::Bookmarks", type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:post1) { create(:post, category: category, user: user) }
  let(:post2) { create(:post, category: category, user: user) }

  let(:bookmark) { create(:bookmark, user: user, post: post1) }

  describe "GET /index" do
    it "returns http ok" do
      get "/v1/users/#{user.id}/bookmarks"
      expect(response).to have_http_status(:ok)
      # json = JSON.parse(response.body)
      # expect(json[0]["user_id"]).to be(user.id)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      params = {
        post_id: post2.id
      }
      post "/v1/users/#{user.id}/bookmarks", params: params
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["bookmark"]["user_id"]).to be(user.id)
    end
  end
end
