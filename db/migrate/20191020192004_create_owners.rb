class CreateOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :owners do |t|
      t.string :name, null: false
      t.integer :document, null: false
      t.date :birth_date, null: false

      t.timestamps
    end
  end
end
