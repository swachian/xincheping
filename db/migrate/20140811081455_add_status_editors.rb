class AddStatusEditors < ActiveRecord::Migration
  def change
    add_column :editors, :status, :integer, default: 0
    add_index :editors, :status
  end
end
