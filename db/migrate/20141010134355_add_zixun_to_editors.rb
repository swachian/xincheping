class AddZixunToEditors < ActiveRecord::Migration
  def change
    add_column :editors , :zixun_first_at, :timestamp #资讯收入的最后时间
    add_column :editors, :zixun_last_at, :timestamp #
    add_column :editors, :zixuncount, :integer, :default => 0 #资讯回答计数
  end
end
