require 'rails_helper'

RSpec.describe "work_patterns/index", type: :view do
  before(:each) do
    assign(:work_patterns, [
      WorkPattern.create!(
        :name => "Name"
      ),
      WorkPattern.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of work_patterns" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
