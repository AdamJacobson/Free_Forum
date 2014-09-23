class ModeratorJoinsController < ActionController::Base
	include SessionsHelper

	before_action :admin_user, only: [:destroy]

	def create
		unless check_permission(join_params[:board_id])
			flash[:error] = "You do not have permission to grant moderator privelages of that type."
			redirect_to boards_path
			return
		end

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

		# Only admins and moderators of the specified board can add moderating privelages
		def check_permission(board_id)
			if current_user.admin? || current_user.moderating?(Board.find(board_id))
				return true
			end
			return false
		end

end