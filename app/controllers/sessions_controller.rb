class SessionsController < ApplicationController
	def new
	end

	def create
		# Returns user if it exists
		user = User.find_by(email: params[:session][:email].downcase)

		if user && user.authenticate(params[:session][:password])
	    sign_in user
	    redirect_to user
	  else
	  	flash.now.alert = "Invalid email/password combination"
	  	render 'new'
	    # Create an error message and re-render the signin form.
	  end
	end

	def destroy
		sign_out
		flash.alert = "Signed out."
		redirect_to root_path
	end
end
