class RanksController < ApplicationController
	before_action :admin_user

	add_breadcrumb "Forum Settings", :forum_settings_path
	add_breadcrumb "Ranks", :ranks_path

	def index
		@rank = Rank.new
		@user_ranks = Rank.where(system: false).order('requirement ASC')
		@system_ranks = Rank.where(system: true)
	end

	def new
		@rank = Rank.new

		add_breadcrumb "New"
	end

	def create
		@rank = Rank.new(rank_params)

		if @rank.save
			redirect_to ranks_path
			update_user_ranks
		else
			@user_ranks = Rank.where(system: false).order('requirement ASC')
			@system_ranks = Rank.where(system: true)
			render 'index'
		end
	end

	def edit
		@rank = Rank.find(params[:id])

		add_breadcrumb "Edit"
	end

	def update
		@rank = Rank.find(params[:id])

    # Only update users if a requirement is changed
    if rank_params[:requirement].to_i != @rank.requirement
    	update_all_users = true
    end

    if @rank.update_attributes(rank_params)
    	flash[:success] = "Rank updated."
    	redirect_to ranks_path

    	if update_all_users
    		flash[:success] += " All users updated."
    		update_user_ranks
    	end
    else
    	render 'edit'
    end
  end

  def destroy
  	rank = Rank.find(params[:id])

    boards = Board.find(:all, conditions: {required_rank: params[:id]})

    # Cannot delete rank if it is currently in use
    if boards.empty?
      rank.destroy
      redirect_to ranks_path
      update_user_ranks(rank.id)
    else
      flash[:error] = "You cannot delete that rank because it is used by the following boards: \n"
      boards.each do |board|
        flash[:error] += "#{board.title} | "
      end
      redirect_to ranks_path
    end
  end

  private

	  def rank_params
	  	params.require(:rank).permit(:color, :title, :requirement)
	  end

    # Update ranks for users
    # If rank_id is specified, update users with only that rank_id
    def update_user_ranks(rank_id = nil)
    	if rank_id.nil?
    		users = User.all
    	else
    		users = User.find(:all, conditions: {rank_id: rank_id})
    	end

    	if !users.empty?
    		users.each do |user|
    			user.update_user_rank
    		end
    	end
    end

  end