class CreateChangces < ActiveRecord::Migration[4.2]
  def change
    create_table :changces do |t|
      t.integer :editor_id
      t.timestamp :c_at
      t.string :link
      t.string :title
      t.text :context
      t.string :chexin

      t.timestamps
    end
    add_index :changces, :editor_id
    add_index :changces, :link
    add_index :changces, :c_at
    add_index :changces, :chexin
  end
end
