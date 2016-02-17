class CreateCodeTables < ActiveRecord::Migration
  def change
    create_table :code_tables do |t|
      t.string :name, limit: 50
      t.string :kind, limit: 10

      t.timestamps null: false
    end
  end
end
