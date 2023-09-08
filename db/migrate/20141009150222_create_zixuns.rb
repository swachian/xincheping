class CreateZixuns < ActiveRecord::Migration[4.2]
  def change
    create_table :zixuns do |t|
      t.integer :editor_id
      t.timestamp :c_at
      t.string :title
      t.string :link
      t.text :context

      t.timestamps null: true
    end

    add_index :zixuns, :editor_id
    add_index :zixuns, :c_at
  end
end
