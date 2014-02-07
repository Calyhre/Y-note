class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.belongs_to :question

      t.string  :title
      t.boolean :correct
      t.integer :position

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
