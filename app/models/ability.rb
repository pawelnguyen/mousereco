class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.persisted?
      can :manage, Website, user_id: user.id
      can :manage, Pageview do |pageview|
        pageview.website.try(:user_id) == user.id
      end
    end
  end
end
