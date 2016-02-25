class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :business_unit
  has_many :soliciting_orders, class_name: 'ProductionOrder', foreign_key: 'soliciting_user_id'
  has_many :responsible_orders, class_name: 'ProductionOrder', foreign_key: 'responsible_user_id'

  scope :admin, -> { where(kind: 'PUAdminist') }
  scope :master, -> { where(kind: 'PUMaster') }
  scope :franchisee, -> { where(kind: 'PUFranquea') }
  scope :representative, -> { where(kind: 'PURepresen') }
  scope :designer, -> { where(kind: 'PUDesigner') }
  scope :marketing, -> { where(kind: 'PUMarketin') }
  scope :idle, -> { joins("LEFT OUTER JOIN production_orders ON production_orders.responsible_user_id = users.id").where("production_orders.responsible_user_id IS null") }

  validates :kind, presence: :true, length: {maximum: 10}
  validates :name, presence: :true, length: {maximum: 50}
  validates :situation, length: {maximum: 10}

  def kind_enum
    Api::Util.select_formatted(CodeTable.where(name: 'Perfil de Usuário').first.code_items, 'description', 'short_description')
  end

  def state_enum
    User.state_machine.states.map { |s| [s.human_name, s.name] }
  end

  state_machine :state, :initial => :active do

    event :activate do
      transition :inactive => :active
    end

    event :deactivate do
      transition :active => :inactive
    end

  end

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

  def self.options_for_responsible_select(business_unit_id)
    where(business_unit_id: business_unit_id).order('LOWER(name)').map { |e| [e.name, e.id] }
  end

  def admin?
    kind == 'PUAdminist'
  end

  def master?
    kind == 'PUMaster'
  end

  def franchisee?
    kind == 'PUFranquea'
  end

  def representative?
    kind == 'PURepresen'
  end

  def designer?
    kind == 'PUDesigner'
  end

  def marketing?
    kind == 'PUMarketin'
  end

end
