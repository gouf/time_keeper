class CreateTransportationExpensePatterns < ActiveRecord::Migration[5.0]
  def change
    create_table :transportation_expense_patterns do |t|
      t.string :name
      t.integer :transportation_expense_id
    end
  end
end
