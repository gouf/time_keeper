require "rails_helper"

RSpec.describe TimeRecordsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/time_records").to route_to("time_records#index")
    end

    it "routes to #new" do
      expect(:get => "/time_records/new").to route_to("time_records#new")
    end

    it "routes to #show" do
      expect(:get => "/time_records/1").to route_to("time_records#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/time_records/1/edit").to route_to("time_records#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/time_records").to route_to("time_records#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/time_records/1").to route_to("time_records#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/time_records/1").to route_to("time_records#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/time_records/1").to route_to("time_records#destroy", :id => "1")
    end

  end
end
