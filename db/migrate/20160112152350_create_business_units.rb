class CreateBusinessUnits < ActiveRecord::Migration
  def change
    create_table :business_units do |t|
      t.integer :federation_unit_id
      t.integer :city_id
      t.string :name, limit: 50
      t.string :code, limit: 8
      t.string :federation_unit_name, limit: 2
      t.string :city_name, limit: 50
      t.string :kind, limit: 10

      t.timestamps null: false
    end
  end
end
