class CreateReturnedExams < ActiveRecord::Migration
  def change
    create_table :returned_exams do |t|
      t.belongs_to :user
      t.belongs_to :test

      t.float :grade
      t.text  :appreciation

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
