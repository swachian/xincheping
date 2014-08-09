class CreateEditors < ActiveRecord::Migration
  def change
    create_table :editors do |t|
      t.string :name
      t.timestamp :first_at
      t.timestamp :last_at
      t.integer :guandiancount, :default => 0 #观点文章计数
      t.integer :changcecount, :default => 0 #长测文章技术

      t.timestamps
    end

    add_index :editors, :name
  end
end
