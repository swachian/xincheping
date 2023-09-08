class CreateDaogoulists < ActiveRecord::Migration[4.2]
  def change
    create_table :daogoulists do |t|
      t.string :title
      t.string :link
      t.integer :alltotalpage
      t.integer :zjtotalpage

      t.timestamps
    end

  end
end
