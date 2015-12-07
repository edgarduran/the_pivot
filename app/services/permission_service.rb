class PermissionService
  attr_reader :user
              :controller
              :action

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action     = action
    if user.platform_admin?
      return true if controller == 'home'            && action == 'home'
      return true if controller == 'sessions'        && action.in?(%w(new create destroy))
      return true if controller == 'cars'            && action.in?(%w(index show))
      return true if controller == 'locations'       && action.in?(%w(index show))
      return true if controller == 'stores/cars'     && action.in?(%w(index show))
      return true if controller == 'admin/items'     && action.in?(%w(index show new create destroy))
      return true if controller == 'admin/dashboard' && action.in?(%w(index show))
      return true if controller == 'admin/locations' && action.in?(%w(index show))
      return true if controller == 'users'           && action.in?(%w(show edit update))
      return true if controller == 'stores'          && action.in?(%w(index edit))
    elsif user.store_admin?
      return true if controller == 'home'             && action == 'home'
      return true if controller == 'sessions'         && action.in?(%w(new create destroy))
      return true if controller == 'cars'             && action.in?(%w(index show))
      return true if controller == 'locations'        && action.in?(%w(index show))
      return true if controller == 'stores/cars'      && action.in?(%w(index show))
      return true if controller == 'stores/dashboard' && action == 'show'
    elsif user.registered_user?
      return true if controller == 'home'        && action == 'home'
      return true if controller == 'sessions'    && action.in?(%w(new create destroy))
      return true if controller == 'cars'        && action.in?(%w(index show))
      return true if controller == 'locations'   && action.in?(%w(index show))
      return true if controller == 'stores/cars' && action.in?(%w(index show))
      return true if controller == 'cart_cars'   && action.in?(%w(create destroy update))
      return true if controller == 'cart'        && action == 'show'
      return true if controller == 'orders'      && action.in?(%w(index create show))
      return true if controller == 'users'       && action.in?(%w(show edit update))
      return true if controller == 'stores'      && action.in?(%w(new create))
    else
      return true if controller == 'home'        && action == 'home'
      return true if controller == 'sessions'    && action.in?(%w(new create))
      return true if controller == 'users'       && action.in?(%w(new create))
      return true if controller == 'cars'        && action.in?(%w(index show))
      return true if controller == 'locations'   && action.in?(%w(index show))
      return true if controller == 'stores/cars' && action.in?(%w(index show))
      return true if controller == 'cart'        && action == 'show'
      return true if controller == 'cart_cars'   && action.in?(%w(create destroy update))
      return true if controller == 'orders'      && action == 'create'
    end
  end

  # private
  #
  # def platform_admin_permissions
  # end
  #
  # def store_admin_permissions
  # end
  #
  # def registered_user_permissions
  # end
  #
  # def guest_permissions
  # end

end
