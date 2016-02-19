class Category < ActiveRecord::Base
  belongs_to :production_order
  # accepts_nested_attributes_for :sub_category, allow_destroy: true
end
