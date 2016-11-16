class AddTransportationExpensePatternIdColumnToTimeRecordTable < ActiveRecord::Migration[5.0]
  def change
    add_column :time_records, :transportation_expense_pattern_id, :integer
  end
end
