class ChangeColumnAttributeWorkPatterns < ActiveRecord::Migration[5.0]
  def change
    change_column :work_patterns, :work_started_at, :time
    change_column :work_patterns, :work_ended_at, :time
  end
end
