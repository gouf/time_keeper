require 'rails_helper'

RSpec.describe "transportation_expenses/show", type: :view do
  before(:each) do
    @transportation_expense = assign(:transportation_expense, TransportationExpense.create!(
      :destination => "Destination",
      :route => "Route",
      :destination_from => "Destination From",
      :destination_to => "Destination To",
      :is_round_trip => false,
      :cost => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Destination/)
    expect(rendered).to match(/Route/)
    expect(rendered).to match(/Destination From/)
    expect(rendered).to match(/Destination To/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2/)
  end
end
