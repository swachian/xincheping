class CreateEditors < ActiveRecord::Migration
  def change
    create_table :editors do |t|
      t.string :name
      t.timestamp :first_at #观点的最后时间
      t.timestamp :last_at #观点的初始时间
      t.timestamp :cc_first_at #长测的最后时间
      t.timestamp :cc_last_at #长测的初始时间
      t.integer :guandiancount, :default => 0 #观点文章计数
      t.integer :changcecount, :default => 0 #长测文章技术

      t.timestamps
    end

    add_index :editors, :name
  end
end
