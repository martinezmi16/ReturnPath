class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.boolean :zoo_member

      t.timestamps null: false
    end
  end
end
