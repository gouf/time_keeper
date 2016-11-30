class CreateTransportationExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :transportation_expenses do |t|
      t.string :destination
      t.string :route
      t.string :destination_from
      t.string :destination_to
      t.boolean :is_round_trip
      t.integer :cost

      t.timestamps
    end
  end
end
