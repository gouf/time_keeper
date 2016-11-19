class AddAbnormalStateColumnsToTimeRecordsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :time_records, :is_late, :boolean
    add_column :time_records, :is_leave_work_early, :boolean
    add_column :time_records, :is_absent, :boolean
  end
end
