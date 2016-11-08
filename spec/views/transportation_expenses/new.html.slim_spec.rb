require 'rails_helper'

RSpec.describe "transportation_expenses/new", type: :view do
  before(:each) do
    assign(:transportation_expense, TransportationExpense.new(
      :destination => "MyString",
      :route => "MyString",
      :destination_from => "MyString",
      :destination_to => "MyString",
      :is_round_trip => false,
      :cost => 1
    ))
  end

  it "renders new transportation_expense form" do
    render

    assert_select "form[action=?][method=?]", transportation_expenses_path, "post" do

      assert_select "input#transportation_expense_destination[name=?]", "transportation_expense[destination]"

      assert_select "input#transportation_expense_route[name=?]", "transportation_expense[route]"

      assert_select "input#transportation_expense_destination_from[name=?]", "transportation_expense[destination_from]"

      assert_select "input#transportation_expense_destination_to[name=?]", "transportation_expense[destination_to]"

      assert_select "input#transportation_expense_is_round_trip[name=?]", "transportation_expense[is_round_trip]"

      assert_select "input#transportation_expense_cost[name=?]", "transportation_expense[cost]"
    end
  end
end
