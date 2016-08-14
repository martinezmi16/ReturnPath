class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.integer :tenure
      t.string :department

      t.timestamps null: false
    end
  end
end
