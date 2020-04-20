require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    it "returns http success" do
      get articles_path
      expect(response).to have_http_status(:success)
    end 
  end
end
