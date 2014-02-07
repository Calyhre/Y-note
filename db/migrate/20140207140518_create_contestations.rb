class CreateContestations < ActiveRecord::Migration
  def change
    create_table :contestations do |t|
      t.belongs_to :user
      t.belongs_to :test

      t.text    :content

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
