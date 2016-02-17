class CreateProductionOrders < ActiveRecord::Migration
  def change
    create_table :production_orders do |t|
      t.references :business_unit
      t.references :soliciting_user
      t.references :responsible_user
      t.string :code
      t.string :name
      t.string :address
      t.string :zip
      t.string :phone1
      t.string :phone2
      t.string :phone3
      t.string :email
      t.string :website
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email
      t.string :facebook
      t.text :publicity_text
      t.text :description
      t.string :youtube_video
      t.string :category1
      t.string :category2
      t.string :category3
      t.string :subcategory1
      t.string :subcategory2
      t.string :subcategory3
      t.string :state

      t.timestamps null: false
    end
  end
end
