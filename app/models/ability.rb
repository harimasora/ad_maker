class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)

    # if user.admin?
    #   can :manage, :all
    # elsif user.master?
    #   can :create, ProductionOrder
    #   can :read, ProductionOrder, :business_unit => {:federation_unit_id => user.business_unit.federation_unit_id}
    #
    #
    #   can :manage, ProductionOrder, :business_unit => {:federation_unit_id => user.business_unit.federation_unit_id}
    # elsif user.franchisee?
    #   can :manage, ProductionOrder, :business_unit => {:city_id => user.business_unit.city_id}
    # elsif user.representative?
    #   can :create, ProductionOrder
    #   can :read, ProductionOrder, :business_unit => user.business_unit
    #   can :edit, ProductionOrder, :soliciting_user_id => user.id
    # elsif user.designer?
    #   can :create, ProductionOrder, :business_unit_id => user.business_unit_id
    #   can [:read, :update], ProductionOrder, :business_unit_id => user.business_unit_id, :state => %w(rejected designing)
    # elsif user.marketing?
    #   can :manage, ProductionOrder, :business_unit_id => user.business_unit_id, :state => %w(qualifying)
    # end


    if user.admin?
      can :manage, :all
    else
      # CREATE
      if user.master? || user.franchisee? || user.representative?
        can :create, ProductionOrder
      end

      # READ
      # Can read own ProductionOrders
      can :read, ProductionOrder, :soliciting_user => user

      if user.master?
        can :read, ProductionOrder, :business_unit => {:federation_unit_id => user.business_unit.federation_unit_id}
      elsif user.franchisee?
        can :read, ProductionOrder, :business_unit => {:city_id => user.business_unit.city_id}
      elsif user.representative?
        can :read, ProductionOrder, :business_unit => user.business_unit
      elsif user.designer?
        can :read, ProductionOrder, :responsible_user => user, :state => %w(rejected designing)
      elsif user.marketing?
        can :read, ProductionOrder, :state => %w(qualifying)
      end

      # UPDATE
      can :update, ProductionOrder, :responsible_user => user

      # DELETE
    end
  end
end
