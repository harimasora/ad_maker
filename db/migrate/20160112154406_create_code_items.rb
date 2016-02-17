class CreateCodeItems < ActiveRecord::Migration
  def change
    create_table :code_items do |t|
      t.references :code_table
      t.string :short_description, limit: 10
      t.string :description, limit: 50
      t.string :dependent, limit: 10

      t.timestamps null: false
    end
    add_index :code_items, :short_description, unique: true
  end
end
