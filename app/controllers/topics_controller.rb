class TopicsController < ApplicationController
	before_action :signed_in_user, only: [:create, :new]

	def show
		@topic = Topic.find(params[:id])
		if params[:page].to_i > @topic.last_page
			flash[:error] = "There is no page with the given index. Automatically redirecting to the first page..."
			redirect_to @topic
		end
		@board = @topic.board
		@posts = @topic.posts.paginate(page: params[:page])
	end

	def new
		@board = Board.find(params[:board_id])
		@topic = @board.topics.build
		@post = @topic.posts.build
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
	end

	private

	def topic_params
		params.require(:topic).permit(:title, posts_attributes: [:id, :content])
	end
end
