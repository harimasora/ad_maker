class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references :production_order
      t.string :name
      t.string :subcategory_name
      t.integer :api_id
      t.integer :subcategory_api_id

      t.timestamps null: false
    end
  end
end
