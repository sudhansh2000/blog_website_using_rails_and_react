require 'rails_helper'

RSpec.describe "V1::CommentsController", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:post1) {  create(:post, user: user, category: category) }
  let!(:comment) { create(:comment, user: user, post: post1) }
  let!(:comment1) { create(:comment, user: user, post: post1) }

  describe "show all the comments" do
    it "show all comments" do
      get "/v1/comments"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.length).to be >= 1
      expect(json[0]["id"]).to eq(comment.id)
    end

    it "show all parent comments of specific post" do
      get "/v1/posts/#{post1.id}/comments"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.length).to be >= 1
    end

    it "show all the comments of perticular user" do
      get "/v1/users/#{user.id}/comments"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.length).to be >= 1
      expect(json[0]["id"]).to eq(comment.id)
    end
  end

  describe "create new comment" do
    it "post /posts/post_id/comments" do
      params1 = {
        comment: {
          # post_id: post1.id,
          user_id: user.id,
          content: "new comment"
        }
      }
      post "/v1/posts/#{post1.id}/comments", params: params1
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["comment"]["content"]).to eq("new comment")
    end

    it "post /comments/comment_id/comments" do
      params1 = {
        comment: {
          # post_id: post1.id,
          user_id: user.id,
          content: "new comment"
        }
      }
      post "/v1/comments/#{post1.id}/comments", params: params1
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["comment"]["content"]).to eq("new comment")
      expect(json["message"]).to eq("Comment created successfully")
    end
  end

  describe "update comment" do
    it "patch /comments/:id" do
      params = {
        comment: {
          content: "updated content"
        }
      }
      patch "/v1/comments/#{comment.id}", params: params
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["comment"]["content"]).to eq("updated content")
    end
  end

  describe "delete comment" do
    it "delete /comments/:id" do
      delete "/v1/comments/#{comment.id}"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Comment deleted successfully")
    end
  end
end
