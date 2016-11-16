class TimeRecord < ApplicationRecord
  belongs_to :work_time_pattern
  # note: only works on postgres
  scope :find_by_work_date_in_month_year, ->(month, year) { where(%(work_date::text like '#{year}-#{month}-%')) }
end
