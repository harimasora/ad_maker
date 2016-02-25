class Setting < ActiveRecord::Base
  def delegate_method_enum
    Api::Util.select_formatted(CodeTable.where(name: 'Método de Atribuição').first.code_items, 'description', 'short_description')
  end
end
