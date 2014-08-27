class BoardsController < ApplicationController
	require 'will_paginate/array'
	
	def show
		@board = Board.find(params[:id])
		@topics = @board.topics.order("last_replied_to_at DESC").paginate(page: params[:page])
	end

	def index
		@boards = Board.paginate(page: params[:page])
	end
end
