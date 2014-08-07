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
		@board = Board.find(params[:id])
		@topic = Topic.new
		@post = Post.new
	end

	def create
		@board = Board.find(params[:id])
		@topic = @board.topics.build(topic_params.merge({user_id: current_user.id}))
		@post = Post.new

		if @topic.save
			post_content = {content: params[:topic][:content], user_id: current_user.id}
			@post = @topic.posts.build(post_content)

			if @post.save
				flash[:success] = "Topic created"
				redirect_to @topic
			else
				@topic.delete
				render 'new'
			end

		else
			render 'new'
		end
	end

	private

	def topic_params
		params.require(:topic).permit(:title, :content)
	end
end
