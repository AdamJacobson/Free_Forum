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

	def current_user=(user)
    @current_user = user
  end

  def current_user
  	@current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
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

end
