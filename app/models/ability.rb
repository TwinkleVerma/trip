class Ability
  include CanCan::Ability

  def initialize(user)

    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.has_role? :admin
        can :manage, :all
      elsif user.has_role? :airTrafficManager
        can :read, Airline
        can :update, Role
        can :manage, Flight
        can :create, Crew
        can :manage, Image, user_id: user.id
        can :manage, Schedule
        can :read, Airline
        can :update, User, user_id: user.id
      elsif user.has_role? :piolet
        can :create, Image, user_id: user.id
        can :update, User, user_id: user.id
        can :show, Airline
        can :read, Schedule
        can :read, Flight, user_ids: user.id
        can :read, Crew, user_id: user.id
      elsif user.has_role? :user
        can :read, Airline
        can :update, User, user_id: user.id
        can :manage, Booking, user_id: user.id
        can :manage, Image, user_id: user.id
        can :create, Role
      else
        can :read, :all
        can :create, User
      end
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
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
