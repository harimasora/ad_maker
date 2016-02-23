class AddOriginalDesignerToProductionOrder < ActiveRecord::Migration
  def change
    add_column :production_orders, :original_designer_id, :integer
  end
end
