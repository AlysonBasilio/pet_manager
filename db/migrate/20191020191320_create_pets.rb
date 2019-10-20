class CreatePets < ActiveRecord::Migration[6.0]
  def change
    create_table :pets do |t|
      t.string :name, null: false
      t.decimal :monthly_cost, null: false
      t.string :kind, null: false

      t.integer :owner_id, null: false

      t.timestamps
    end
  end
end
