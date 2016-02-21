class AddAddressAttributesToProductionOrder < ActiveRecord::Migration
  def change
    add_column :production_orders, :federation_unit_id, :integer
    add_column :production_orders, :city_id, :integer
    add_column :production_orders, :district_id, :integer
    add_column :production_orders, :federation_unit_name, :string
    add_column :production_orders, :city_name, :string
    add_column :production_orders, :district_name, :string
  end
end
