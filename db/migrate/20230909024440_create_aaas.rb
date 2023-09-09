class CreateAaas < ActiveRecord::Migration[7.0]
  def change
    create_table :aaas do |t|
      t.string :name

      t.timestamps
    end
  end
end
