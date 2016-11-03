class TimeRecord < ApplicationRecord
  # note: only works on postgres
  scope :find_by_work_date_in_month_year, ->(month, year) { where(%Q(work_date::text like '#{year}-#{month}-%')) }
end
