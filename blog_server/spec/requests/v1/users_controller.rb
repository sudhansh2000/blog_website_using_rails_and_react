require 'rails_helper'

RSpec.describe "V1::UsersController", type: :request do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }

  sign_in user1

  context "for index users" do
    it "returns a list of users" do
      get "/v1/users"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to be_an(Array)
      expect(json.length).to be >= 1
    end
  end

  describe "show user" do
    it "get v1/user/:id" do
      get "/v1/users/#{user1.id}"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(user1.id)
    end
  end

  describe "update user" do
    it "patch users/:id" do
      params = {
        user: {
          first_name: "spider"
        }
      }
      patch "/v1/users/#{user1.id}", params: params
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to be_a(Hash)
      puts json
      expect(json["user"]["first_name"]).to eq("spider")
    end
  end


  describe "create user" do
    it "post users/" do
      param1 = {
        user: {
          user_name: "newuser99",
          first_name: "something",
          last_name: "else",
          email: "email@gmail.com",
          phone_number: "1234567890",
          password: "password",
          dob: "1990-01-01"
        }
      }
      post "/v1/users", params: param1
      expect(response).to have_http_status(:created)
    end

    it "post users/ error chaeking" do
      param = {
        user: {
          user_name: user1.user_name,
          first_name: "something",
          last_name: "else",
          email: "email@gmail.com",
          phone_number: "1234567890",
          password: "password",
          dob: "1990-01-01"
        }
      }
      post "/v1/users", params: param
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
