class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to  :test

      t.string      :title
      t.text        :instruction
      t.text        :correction
      t.string      :question_type
      t.integer     :position
      t.float       :max_points
      t.string      :penalty_type
      t.float       :penalty

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
