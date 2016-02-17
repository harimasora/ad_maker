class CodeTable < ActiveRecord::Base
  has_many :code_items

  validates :name, presence: true, length: {maximum: 50}
  validates :kind, length: {maximum: 10}
end
