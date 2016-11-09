class AddColumnUseDateToTransportationExpensesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :transportation_expenses, :use_date, :date
  end
end
