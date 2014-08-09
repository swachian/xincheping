class CreateGuandians < ActiveRecord::Migration
  def change
    create_table :guandians do |t|
      t.integer :editor_id
      t.timestamp :c_at
      t.string :link
      t.string :title
      t.text :context

      t.timestamps
    end
    add_index :guandians, :editor_id
  end
end
