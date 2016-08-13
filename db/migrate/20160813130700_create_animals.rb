class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :name
      t.integer :leg_count
      t.integer :lifespan
      t.boolean :is_endangered

      t.timestamps null: false
    end
  end
end
