require "rails_helper"

RSpec.describe WorkPatternsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/work_patterns").to route_to("work_patterns#index")
    end

    it "routes to #new" do
      expect(:get => "/work_patterns/new").to route_to("work_patterns#new")
    end

    it "routes to #show" do
      expect(:get => "/work_patterns/1").to route_to("work_patterns#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/work_patterns/1/edit").to route_to("work_patterns#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/work_patterns").to route_to("work_patterns#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/work_patterns/1").to route_to("work_patterns#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/work_patterns/1").to route_to("work_patterns#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/work_patterns/1").to route_to("work_patterns#destroy", :id => "1")
    end

  end
end
