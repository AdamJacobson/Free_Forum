class ModeratorJoinsController < ActionController::Base
	include SessionsHelper

	before_action :admin_user

	def create
		join = ModeratorJoin.new(join_params)
		user = User.find(join_params[:user_id])

		if join.save
			redirect_to user
		else
			flash[:error] = "An error occured when trying to add a moderating privelage."
			redirect_to user
		end
	end

	def destroy
		join = ModeratorJoin.find(params[:id])
		user = join.user
		join.destroy
		redirect_to user
	end

	private

		def join_params
			params.require(:moderator_join).permit(:user_id, :board_id)
		end

end