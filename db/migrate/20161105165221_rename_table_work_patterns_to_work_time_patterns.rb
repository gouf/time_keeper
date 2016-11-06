class RenameTableWorkPatternsToWorkTimePatterns < ActiveRecord::Migration[5.0]
  def change
    rename_column :work_time_patterns, :work_start_at, :work_started_at
    rename_column :work_time_patterns, :work_end_at, :work_ended_at
  end
end
