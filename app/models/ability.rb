# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if !user
    elsif user.admin?
      can :manage, User
      can :manage, Micropost
    elsif !user.admin?
      can :read, User
      can %i[update destroy], User, id: user.id
      can :read, Micropost
      can :manage, Micropost, user_id: user.id
    end
  end
end
