class RenameTableTimeRecordsTableToWorkTimeRecords < ActiveRecord::Migration[5.0]
  def change
    rename_table :time_records, :work_time_records
  end
end
