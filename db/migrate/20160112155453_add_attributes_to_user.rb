class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, limit: 50
    add_column :users, :kind, :string, limit: 10
    add_column :users, :situation, :string, limit: 10
    add_column :users, :state, :string
    add_reference :users, :business_unit
  end
end
