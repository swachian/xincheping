class CreateCantings < ActiveRecord::Migration[4.2]
  def change
    create_table :cantings do |t|
      t.string :title1
      t.string :title2
      t.string :yueshou
      t.string :imglink
      t.string :distance
      t.string :timeleft
      t.integer :isimgdownload, default: 0

      t.timestamps null: false
    end
  end
end
