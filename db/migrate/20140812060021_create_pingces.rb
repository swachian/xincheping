class CreatePingces < ActiveRecord::Migration
  def change
    create_table :pingces do |t|
      t.integer :editor_id
      t.timestamp :c_at
      t.string :title
      t.text :context
      t.string :link
      t.integer :clicks
      t.string :jielun

      t.timestamps
    end
    add_index :pingces, :editor_id
    add_index :pingces, :c_at
    add_index :pingces, :jielun
    add_index :pingces, :clicks
  end
end
