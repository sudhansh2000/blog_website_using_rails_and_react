require 'rails_helper'

RSpec.describe V1::SharePostsController, type: :request do
  let!(:sender) { create(:user) }
  let!(:receiver) { create(:user) }
  let!(:category) { create(:category) }
  let!(:post1) { create(:post, user: sender, category: category) }
  let!(:share_post) { create(:share_post, sender: sender, receiver: receiver) }

  # puts share_post.sender_id

  describe "POST /v1/share_posts" do
    context "when sharing post with another user" do
      it "creates a new SharePost" do
        post "/v1/users/#{sender.id}/share_posts", params: {
          receiver_id: receiver.id,
          post_id: post1.id
        }
        expect(response).to have_http_status(:created)
      end
    end

    context "when trying to share with self" do
      it "returns a bad request error" do
        post "/v1/users/#{sender.id}/share_posts", params: {
          receiver_id: sender.id,
          post_id: post1.id
        }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)["error"]).to eq("Cannot send post to yourself")
      end
    end
  end

  describe "GET /v1/SharePost" do
    it "returns a list of shared posts with metadata" do
      get "/v1/users/#{receiver.id}/share_posts", params: { user_id: receiver.id }

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
    end

    it "returns an error if user not found" do
      get "/v1/users/99/share_posts"
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("User not found")
    end
  end
end
