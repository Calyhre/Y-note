class AddCorrectionStateToTest < ActiveRecord::Migration
  def change
    add_column :tests, :correction_state, :string, default: 'not_done'
  end
end
