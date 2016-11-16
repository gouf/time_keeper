class TransportationExpense < ApplicationRecord
  has_one :work_time_pattern
  belongs_to :transportation_expense_pattern
  scope :find_by_use_date_in_month_year, ->(month, year) { where(%(use_date::text like '#{year}-#{month}-%')) }
end
