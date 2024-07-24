class UserPolicy < ApplicationPolicy
  attr_reader :user, :current_user

  def initialize(user, current_user)
    @user = user
    @current_user = current_user
  end

  def feed?
    true
  end

  def liked?
    show?
  end

  def discover?
    feed?
  end

  def show?
    true
  end

  def show_photos?
    user == current_user ||
      !user.private? ||
      user.followers.include?(current_user)
  end
end
