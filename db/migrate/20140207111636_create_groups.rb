class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.belongs_to :period

      t.string :title
      t.string :role

      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.timestamps
      t.datetime :deleted_at
    end

    create_table :groups_users do |t|
      t.belongs_to :user
      t.belongs_to :group
    end
  end
end
