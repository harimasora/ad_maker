class BusinessUnit < ActiveRecord::Base
  has_many :users
  has_many :production_orders

  def federation_unit_id_enum
    Api::FederationUnit.select_formatted
  end

  def city_id_enum
    if self.federation_unit_id.nil?
      []
    else
      Api::City.select_formatted(self.federation_unit_id)
    end
  end

  def kind_enum
    Api::Util.select_formatted(CodeTable.where(name: 'Tipo de Unidade de Negócio').first.code_items, 'description', 'short_description')
  end

  rails_admin do
    list do
      configure :federation_unit_id do
        hide
      end
      configure :city_id do
        hide
      end
    end

    show do
      configure :federation_unit_id do
        hide
      end
      configure :city_id do
        hide
      end
    end
  end

  validates :name, presence: true, length: { maximum: 50 }
  validates :code, length: { maximum: 8 }
  validates :federation_unit_name, length: { maximum: 2 }
  validates :city_name, length: { maximum: 50 }
  validates :kind, length: { maximum: 10 }

  def self.options_for_select(city_id)
    where(city_id: city_id).order('LOWER(name)').map { |e| [e.name, e.id] }
  end
end
