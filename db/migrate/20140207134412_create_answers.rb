class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :returned_exam
      t.belongs_to :question

      t.text  :answer
      t.float :points

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
