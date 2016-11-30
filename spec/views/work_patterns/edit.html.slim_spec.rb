require 'rails_helper'

RSpec.describe "work_patterns/edit", type: :view do
  before(:each) do
    @work_pattern = assign(:work_pattern, WorkPattern.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit work_pattern form" do
    render

    assert_select "form[action=?][method=?]", work_pattern_path(@work_pattern), "post" do

      assert_select "input#work_pattern_name[name=?]", "work_pattern[name]"
    end
  end
end
