class AddColumnToTimeRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :time_records, :work_time_pattern_id, :integer
    add_column :time_records, :rest_time, :time, default: '1:00:00'
    add_column :time_records, :work_start_at, :time
    add_column :time_records, :work_end_at, :time
    add_column :time_records, :description, :text, default: ''
  end
end
