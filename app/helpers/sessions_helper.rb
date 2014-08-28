module SessionsHelper

	def sign_in(user)
		session[:user_id] = user.id
		self.current_user = user
	end

	def sign_out
		session[:user_id] = nil
		self.current_user = nil
	end

	def signed_in?
		!current_user.nil?
	end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in." 
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
  	@current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Should be used in place of current_user.admin? as this will check for nil user as well
  def current_user_is_admin?
    !current_user.nil? && current_user.admin?
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def log_last_action
    session[:last_controller] = params[:controller]
    session[:last_action] = params[:action]
  end

end
