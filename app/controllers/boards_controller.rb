class BoardsController < ApplicationController
	
	def show
		@board = Board.find(params[:id])
		@topics = @board.topics.paginate(page: params[:page])
	end

	def index
		@boards = Board.paginate(page: params[:page])
	end
end
