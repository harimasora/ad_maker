class Banner < ActiveRecord::Base
  mount_uploader :image, LogotypeUploader

  def kind_enum
    Api::Util.select_formatted(CodeTable.where(name: 'Tipo de Banner').first.code_items, 'description', 'short_description')
  end

  def state_enum
    Banner.state_machine.states.map { |s| [s.human_name, s.name] }
  end

  belongs_to :production_order

  state_machine :state, :initial => :active do

    event :activate do
      transition :inactive => :active
    end

    event :deactivate do
      transition :active => :inactive
    end

  end
end
