require 'rails_helper'

RSpec.describe "transportation_expenses/index", type: :view do
  before(:each) do
    assign(:transportation_expenses, [
      TransportationExpense.create!(
        :destination => "Destination",
        :route => "Route",
        :destination_from => "Destination From",
        :destination_to => "Destination To",
        :is_round_trip => false,
        :cost => 2
      ),
      TransportationExpense.create!(
        :destination => "Destination",
        :route => "Route",
        :destination_from => "Destination From",
        :destination_to => "Destination To",
        :is_round_trip => false,
        :cost => 2
      )
    ])
  end

  it "renders a list of transportation_expenses" do
    render
    assert_select "tr>td", :text => "Destination".to_s, :count => 2
    assert_select "tr>td", :text => "Route".to_s, :count => 2
    assert_select "tr>td", :text => "Destination From".to_s, :count => 2
    assert_select "tr>td", :text => "Destination To".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
