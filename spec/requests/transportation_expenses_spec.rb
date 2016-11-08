require 'rails_helper'

RSpec.describe "TransportationExpenses", type: :request do
  describe "GET /transportation_expenses" do
    it "works! (now write some real specs)" do
      get transportation_expenses_path
      expect(response).to have_http_status(200)
    end
  end
end
