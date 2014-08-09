class CreateChangces < ActiveRecord::Migration
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
  end
end
