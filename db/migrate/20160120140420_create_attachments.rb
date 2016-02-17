class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments, force: true do |t|
      t.integer  'attached_item_id'
      t.string   'attached_item_type'
      t.string   'attachment',         null: false
      t.string   'original_filename'
      t.string   'content_type'

      t.string   'description'
      t.string   'state'
      t.integer  'rank', default: 0

      t.timestamps null: false
    end

    add_index :attachments, ['attached_item_type', 'attached_item_id']
  end
end
