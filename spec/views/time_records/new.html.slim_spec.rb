require 'rails_helper'

RSpec.describe "time_records/new", type: :view do
  before(:each) do
    assign(:time_record, TimeRecord.new())
  end

  it "renders new time_record form" do
    render

    assert_select "form[action=?][method=?]", time_records_path, "post" do
    end
  end
end
