class RemoveCategories123FromProductionOrder < ActiveRecord::Migration
  def change
    remove_column :production_orders, :category1, :string
    remove_column :production_orders, :category2, :string
    remove_column :production_orders, :category3, :string
    remove_column :production_orders, :subcategory1, :string
    remove_column :production_orders, :subcategory2, :string
    remove_column :production_orders, :subcategory3, :string
  end
end
