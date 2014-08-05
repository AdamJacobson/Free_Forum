class TopicsController < ApplicationController
	before_action :signed_in_user, only: [:create, :new]

  def show
  	@topic = Topic.find(params[:id])
  end

  def new
		@board = Board.find(params[:id])
  end

	def create
		@board = Board.find(params[:id])
		@topic = @board.topics.build(topic_params.merge({user_id: current_user.id}))

		debugger
		if @topic.save
			flash[:success] = "Topic created"
			redirect_to @topic
		else
			render 'new'
		end
	end

	private

		def topic_params
			params.require(:topic).permit(:title, :content)
		end
end
