FactoryGirl.define do
  factory :transportation_expense do
    destination "MyString"
    route "MyString"
    destination_from "MyString"
    destination_to "MyString"
    is_round_trip false
    cost 1
  end
end
