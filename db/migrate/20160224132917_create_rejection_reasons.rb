class CreateRejectionReasons < ActiveRecord::Migration
  def change
    create_table :rejection_reasons do |t|
      t.string :description
      t.references :production_order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
