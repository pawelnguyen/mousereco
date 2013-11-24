class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.persisted?
      can :manage, Website, user_id: user.id
    end
  end
end
