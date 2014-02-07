class CreateGroupSubjects < ActiveRecord::Migration
  def change
    create_table :group_subjects do |t|
      t.integer :teacher_id
      t.belongs_to :group
      t.belongs_to :subject

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
