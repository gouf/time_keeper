class WorkTimePattern < ApplicationRecord
  has_one :time_record
  has_many :transportation_expense
end
