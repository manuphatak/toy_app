# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user) # rubocop:disable Metrics/MethodLength
    if !user
    elsif user.admin?
      can :manage, User
      can :manage, Micropost
    elsif !user.admin?
      can %i[read following followers], User
      can %i[update destroy], User, id: user.id

      can :read, Micropost
      can :manage, Micropost, user: user

      can :read, Relationship
      can %i[create destroy], Relationship, follower: user
    end
  end
end
