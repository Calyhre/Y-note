class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user

      t.integer :parent_id
      t.string  :parent_type

      t.text    :content

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
