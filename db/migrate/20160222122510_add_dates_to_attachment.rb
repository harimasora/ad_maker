class AddDatesToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :start_date, :date
    add_column :attachments, :end_date, :date
  end
end
