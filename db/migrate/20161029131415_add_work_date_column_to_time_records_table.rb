class AddWorkDateColumnToTimeRecordsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :time_records, :work_date, :date, after: :id
  end
end
