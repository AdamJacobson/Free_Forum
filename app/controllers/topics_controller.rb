class TopicsController < ApplicationController
	before_action :signed_in_user, only:       [:create, :new, :update]

	def show
		@topic = Topic.find(params[:id])
		if params[:page].to_i > @topic.last_page
			flash[:error] = "There is no page with that index"
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
end
