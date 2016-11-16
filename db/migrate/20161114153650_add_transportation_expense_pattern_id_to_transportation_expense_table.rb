class AddTransportationExpensePatternIdToTransportationExpenseTable < ActiveRecord::Migration[5.0]
  def change
    add_column :transportation_expenses, :transportation_expense_pattern_id, :integer
  end
end
