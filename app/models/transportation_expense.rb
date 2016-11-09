class TransportationExpense < ApplicationRecord
  has_one :work_time_pattern
  scope :find_by_use_date_in_month_year, ->(month, year) { where(%Q(use_date::text like '#{year}-#{month}-%')) }
end
