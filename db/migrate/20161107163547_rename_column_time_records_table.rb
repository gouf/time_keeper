class RenameColumnTimeRecordsTable < ActiveRecord::Migration[5.0]
  def change
    rename_column :time_records, :work_start_at, :work_started_at
    rename_column :time_records, :work_end_at, :work_ended_at
  end
end
