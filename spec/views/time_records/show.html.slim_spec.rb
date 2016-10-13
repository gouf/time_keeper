require 'rails_helper'

RSpec.describe "time_records/show", type: :view do
  before(:each) do
    @time_record = assign(:time_record, TimeRecord.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
