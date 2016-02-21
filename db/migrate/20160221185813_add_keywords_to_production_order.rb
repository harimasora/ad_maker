class AddKeywordsToProductionOrder < ActiveRecord::Migration
  def change
    add_column :production_orders, :keywords, :string
  end
end
