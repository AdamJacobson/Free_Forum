class BoardsController < ApplicationController
	require 'will_paginate/array'

	add_breadcrumb "Forums", :boards_path
	
	def show
		@board = Board.find(params[:id])
		@topics = @board.topics.order("sticky DESC, last_replied_to_at DESC").paginate(page: params[:page])

		add_breadcrumb "#{@board.title}", board_path(@board)
	end

	def index
		@boards = Board.paginate(page: params[:page])
	end
end
