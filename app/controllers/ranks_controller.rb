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
  	rank.destroy

  	redirect_to ranks_path
  	update_user_ranks(rank.id)
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