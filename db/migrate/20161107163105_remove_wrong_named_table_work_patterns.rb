class RemoveWrongNamedTableWorkPatterns < ActiveRecord::Migration[5.0]
  def change
    drop_table :work_patterns
  end
end
