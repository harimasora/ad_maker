class Category < ActiveRecord::Base
  belongs_to :production_order

  def api_id_enum
    Api::Group.select_formatted
  end

  def subcategory_api_id_enum
    if self.api_id.nil?
      []
    else
      Api::Subgroup.select_formatted(self.api_id)
    end
  end

  rails_admin do
    list do
      configure :api_id do
        hide
      end
      configure :subcategory_api_id do
        hide
      end
    end

    show do
      configure :api_id do
        hide
      end
      configure :subcategory_api_id do
        hide
      end
    end
  end
end
