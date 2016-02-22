class AddRankingToProductionOrder < ActiveRecord::Migration
  def change
    add_column :production_orders, :ranking, :integer
  end
end
