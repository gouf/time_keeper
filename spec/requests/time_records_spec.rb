require 'rails_helper'

RSpec.describe "TimeRecords", type: :request do
  describe "GET /time_records" do
    it "works! (now write some real specs)" do
      get time_records_path
      expect(response).to have_http_status(200)
    end
  end
end
