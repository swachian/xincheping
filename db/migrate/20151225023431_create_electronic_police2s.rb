class CreateElectronicPolice2s < ActiveRecord::Migration
  def change
    create_table :electronic_police2s do |t|
      t.string :position
      t.string :wddm
      t.string :gps
      t.string :cjsj
      t.string :gxsj

      t.timestamps null: false
    end
    add_index :electronic_police2s, :position
  end
end
