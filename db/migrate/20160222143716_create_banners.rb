class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :kind
      t.string :description
      t.string :state
      t.string :keywords
      t.integer :rank
      t.string :image
      t.references :production_order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
