class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
    	flash[:success] = "New user created."
    	redirect_to @user
    else
    	render 'new'
    end
  end

  def show
  	@user = User.find(params[:id])
  end

  private

  def user_params
  	params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
