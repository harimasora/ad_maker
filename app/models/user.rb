class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :business_unit

  validates :kind, presence: :true, length: {maximum: 10}
  validates :name, presence: :true, length: {maximum: 50}
  validates :situation, length: {maximum: 10}

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
