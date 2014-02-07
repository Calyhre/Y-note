class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.string :title

      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
