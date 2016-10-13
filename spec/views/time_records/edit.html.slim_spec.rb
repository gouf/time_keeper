require 'rails_helper'

RSpec.describe "time_records/edit", type: :view do
  before(:each) do
    @time_record = assign(:time_record, TimeRecord.create!())
  end

  it "renders the edit time_record form" do
    render

    assert_select "form[action=?][method=?]", time_record_path(@time_record), "post" do
    end
  end
end
