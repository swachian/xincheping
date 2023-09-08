class CreateFiveks < ActiveRecord::Migration[4.2]
  def change
    create_table :fiveks do |t|
      t.string :t1
      t.string :cont, length: 2000

      t.timestamps null: false
    end
  end
end
