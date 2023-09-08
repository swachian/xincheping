class CreateElectronicPolices < ActiveRecord::Migration[4.2]
  def change
    create_table :electronic_polices do |t|
      t.string :position

      t.timestamps null: false
    end

    add_index :electronic_polices, :position
  end
end
