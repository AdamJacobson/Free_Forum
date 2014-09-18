class TopicsController < ApplicationController
	before_action :check_permission, only: [:create, :new, :update, :edit]

	add_breadcrumb "Forums", :boards_path

	def show
		@topic = Topic.find(params[:id])
		if params[:page].to_i > @topic.last_page
			flash[:error] = "There is no page with that index"
			redirect_to @topic
		end
		@board = @topic.board
		@posts = @topic.posts.paginate(page: params[:page])

		add_breadcrumb "#{@topic.board.title}", board_path(@board)
		add_breadcrumb "#{@topic.title.truncate(40, separator: ' ')}", topic_path(@topic)
	end

	def new
		@board = Board.find(params[:board_id])
		@topic = @board.topics.build
		@post = @topic.posts.build

		add_breadcrumb "#{@topic.board.title}", board_path(@board)
		add_breadcrumb "New Topic"
	end

	def create
		@board = Board.find(params[:board_id])
		@topic = @board.topics.build(topic_params.merge({user_id: current_user.id}))

		if @topic.save
			flash[:success] = "Topic created"
			redirect_to @topic
		else
			render 'new'
		end

		add_breadcrumb "#{@topic.board.title}", board_path(@board)
	end

	def update
		@topic = Topic.find(params[:id])
		if @topic.update_attributes(topic_params)
			flash[:success] = "Topic updated"
      redirect_to @topic
    else
      flash[:error] = "Topic failed to update"
      redirect_to @topic
		end
	end

	private

		def topic_params
			params.require(:topic).permit(:title, :sticky, :locked, :board_id, posts_attributes: [:content, :user_id])
		end

		# Before actions

		def check_permission

			# Check if user is signed in
			signed_in_user

			if (params[:board_id]).nil?
				board = Board.find(params[:id])
			else
				board = Board.find(params[:board_id])
			end

			# Admins have unlimited power
      if !current_user_is_admin?
        # Moderators have unlimited power in their boards
        if !current_user_is_moderator?(board.id)

          # Check that user has the required rank to post in the board
          if !board.required_rank.nil?
            req_rank = Rank.find(board.required_rank)
            unless current_user.rank >= req_rank
              flash[:alert] = "You do not have the required rank for that board."
              redirect_to board
              return
            end
          end

          # Check if the topic is unlocked
          if board.locked?
            flash[:alert] = "That board is currently locked."
            redirect_to board
            return
          end

        end
      end

		end
end
