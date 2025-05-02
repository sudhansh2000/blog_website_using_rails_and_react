require 'rails_helper'

RSpec.describe "V1::CateoriesController", type: :request do
  let!(:category) { create(:category) }

  it "show all categories" do
    get "/v1/categories"
    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)
    expect(json.length).to be >= 1
  end

  it "create category" do
    params = {
      category: {
        cat_name: "new catgory"
      }
    }
    post "/v1/categories", params: params
    expect(response).to have_http_status(:created)
    json = JSON.parse(response.body)
    expect(json["message"]).to eq("Category created successfully")
  end

  it "tests update category" do
    params = {
      category: {
        cat_name: "updated category"
      }
    }
    patch "/v1/categories/#{category.id}", params: params
    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)
    expect(json["message"]).to eq("Category updated successfully")
  end

  it "destroy category" do
    delete "/v1/categories/#{category.id}"
    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)
    expect(json["message"]).to eq("Category deleted successfully")
  end
end
