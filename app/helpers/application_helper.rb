module ApplicationHelper
  def platform_admin?
    current_user && current_user.platform_admin?
  end

  def store_admin?
    current_user && current_user.store_admin?
  end

  def registered_user?
    current_user && current_user.registered_user?
  end
end
