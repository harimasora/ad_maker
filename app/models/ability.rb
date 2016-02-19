class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    else
      # CREATE
      if user.master? || user.franchisee? || user.representative? || user.marketing?
        can :create, ProductionOrder
      end

      # READ
      # Can read own ProductionOrders
      can :read, ProductionOrder, :soliciting_user => user

      if user.master?
        can :read, ProductionOrder, :business_unit => {:federation_unit_id => user.business_unit.federation_unit_id}
      elsif user.franchisee?
        can :read, ProductionOrder, :business_unit => user.business_unit
      elsif user.designer?
        can :read, ProductionOrder, :responsible_user => user, :state => %w(rejected designing)
      end

      # UPDATE
      can :update, ProductionOrder, :responsible_user => user

      if user.master?
        can :update, ProductionOrder, :soliciting_user => user
      elsif user.franchisee?
        can :update, ProductionOrder, :soliciting_user => user
        can :update, ProductionOrder, :business_unit => user.business_unit
      elsif user.representative?
        can :update, ProductionOrder, :soliciting_user => user, :state => %w(submitted)
      end

      # DELETE

      # ACTIONS
      can :cancel, ProductionOrder, :soliciting_user => user, :state => %w(submitted)

      if user.marketing?
        can :approve, ProductionOrder
        can :reject, ProductionOrder
        can :cancel, ProductionOrder
      elsif user.designer?
        can :check_design, ProductionOrder, :responsible_user => user
      end
    end


  end
end
