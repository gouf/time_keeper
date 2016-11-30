require 'rails_helper'

RSpec.describe "work_patterns/show", type: :view do
  before(:each) do
    @work_pattern = assign(:work_pattern, WorkPattern.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
