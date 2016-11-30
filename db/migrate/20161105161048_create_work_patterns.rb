class CreateWorkPatterns < ActiveRecord::Migration[5.0]
  def change
    create_table :work_patterns do |t|
      t.string :name
      t.datetime :work_started_at
      t.datetime :work_ended_at

      t.timestamps
    end
  end
end
