module UserSessionsHelper
  def logged_in?
    current_user ? true : false
  end
end
