require 'rails_helper'

RSpec.describe StatusesController, type: :controller do

  describe "GET #watched" do
    it "returns http success" do
      get :watched
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #unwatched" do
    it "returns http success" do
      get :unwatched
      expect(response).to have_http_status(:success)
    end
  end

end
