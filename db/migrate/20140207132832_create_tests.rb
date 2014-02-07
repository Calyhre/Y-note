class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.belongs_to :group_subject

      t.string  :title
      t.text    :instruction
      t.string  :penalty_type
      t.float   :penalty
      t.boolean :anonymous
      t.string  :grading_scheme
      t.float   :coefficient

      t.datetime :start_at
      t.datetime :end_at
      t.datetime :contestation_closed_at

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
