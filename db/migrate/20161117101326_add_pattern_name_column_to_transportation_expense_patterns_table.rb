class AddPatternNameColumnToTransportationExpensePatternsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :transportation_expense_patterns, :name, :string
  end
end
