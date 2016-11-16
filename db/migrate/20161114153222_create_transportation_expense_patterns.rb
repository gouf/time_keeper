class CreateTransportationExpensePatterns < ActiveRecord::Migration[5.0]
  def change
    create_table :transportation_expense_patterns do |t|
      t.integer :transportation_expense_id

      t.timestamps
    end
  end
end
