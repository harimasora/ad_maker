module ApplicationHelper
  def code_item_description(code_item_short_description)
    CodeItem.find_by_short_description(code_item_short_description).description
  end
end
