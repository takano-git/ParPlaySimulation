require 'rails_helper'

RSpec.describe "Holes", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/holes/new"
      expect(response).to have_http_status(:success)
    end
  end

end
