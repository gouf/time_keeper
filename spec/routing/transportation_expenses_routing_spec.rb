require "rails_helper"

RSpec.describe TransportationExpensesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/transportation_expenses").to route_to("transportation_expenses#index")
    end

    it "routes to #new" do
      expect(:get => "/transportation_expenses/new").to route_to("transportation_expenses#new")
    end

    it "routes to #show" do
      expect(:get => "/transportation_expenses/1").to route_to("transportation_expenses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/transportation_expenses/1/edit").to route_to("transportation_expenses#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/transportation_expenses").to route_to("transportation_expenses#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/transportation_expenses/1").to route_to("transportation_expenses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/transportation_expenses/1").to route_to("transportation_expenses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/transportation_expenses/1").to route_to("transportation_expenses#destroy", :id => "1")
    end

  end
end
