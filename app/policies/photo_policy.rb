class PhotoPolicy < ApplicationPolicy
  attr_reader :user, :photo

  def initialize(user, photo)
    @user = user
    @photo = photo
  end

  # Our policy is that a photo should only be seen by the owner or followers
  #   of the owner, unless the owner is not private in which case anyone can
  #   see it
  def show?
    user == photo.owner ||
      !photo.owner.private? ||
      photo.owner.followers.include?(user)
  end

  def new?
    true
  end

  def create?
    new?
  end

  def update?
    user == photo.owner
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end
