require 'rails_helper'

RSpec.describe "work_patterns/new", type: :view do
  before(:each) do
    assign(:work_pattern, WorkPattern.new(
      :name => "MyString"
    ))
  end

  it "renders new work_pattern form" do
    render

    assert_select "form[action=?][method=?]", work_patterns_path, "post" do

      assert_select "input#work_pattern_name[name=?]", "work_pattern[name]"
    end
  end
end
