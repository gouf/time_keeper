class AddColumnNameWorkTimePatterns < ActiveRecord::Migration[5.0]
  def change
    add_column :work_time_patterns, :name, :string
  end
end
