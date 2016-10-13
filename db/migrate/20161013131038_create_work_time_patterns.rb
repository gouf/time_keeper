class CreateWorkTimePatterns < ActiveRecord::Migration[5.0]
  def change
    create_table :work_time_patterns do |t|
      t.time :work_start_at
      t.time :work_end_at

      t.timestamps
    end
  end
end
