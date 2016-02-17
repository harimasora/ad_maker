class AddLogotypeToProductionOrders < ActiveRecord::Migration
  def change
    add_column :production_orders, :logotype, :string
  end
end
