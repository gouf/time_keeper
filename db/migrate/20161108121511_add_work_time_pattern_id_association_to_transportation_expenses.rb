class AddWorkTimePatternIdAssociationToTransportationExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :transportation_expenses, :work_time_pattern_id, :integer
  end
end
