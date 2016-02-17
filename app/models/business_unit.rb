class BusinessUnit < ActiveRecord::Base
  has_many :users
  has_many :production_orders

  validates :name, presence: true, length: { maximum: 50 }
  validates :code, length: { maximum: 8 }
  validates :federation_unit_name, length: { maximum: 2 }
  validates :city_name, length: { maximum: 50 }
  validates :kind, length: { maximum: 10 }

  def self.options_for_select(city_id)
    where(city_id: city_id).order('LOWER(name)').map { |e| [e.name, e.id] }
  end
end
