class Banner < ActiveRecord::Base
  mount_uploader :image, LogotypeUploader

  belongs_to :production_order
end
