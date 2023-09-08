class AddStatusEditors < ActiveRecord::Migration[4.2]
  def change
    add_column :editors, :status, :integer, default: 0
    add_index :editors, :status
  end
end
