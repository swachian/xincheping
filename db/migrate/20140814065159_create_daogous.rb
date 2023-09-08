class CreateDaogous < ActiveRecord::Migration[4.2]
  def change
    create_table :daogous do |t|
      t.integer :daogoulist_id
      t.timestamp :c_at
      t.string :title
      t.text :wenti
      t.text :zjhd
      t.integer :editor_id
      t.string :link

      t.timestamps
    end
    add_index :daogous, :daogoulist_id
    add_index :daogous, :editor_id
    add_index :daogous, :c_at
  end
end
