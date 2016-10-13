require 'rails_helper'

RSpec.describe "time_records/index", type: :view do
  before(:each) do
    assign(:time_records, [
      TimeRecord.create!(),
      TimeRecord.create!()
    ])
  end

  it "renders a list of time_records" do
    render
  end
end
