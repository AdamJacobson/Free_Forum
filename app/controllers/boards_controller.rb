class BoardsController < ApplicationController
	require 'will_paginate/array'

	add_breadcrumb "Forums", :boards_path
	
	def show
		@board = Board.find(params[:id])
		@topics = @board.topics.order("sticky DESC, last_replied_to_at DESC").paginate(page: params[:page])

		add_breadcrumb "#{@board.title}", board_path(@board)
	end

	def index
		@boards = Board.all
	end

	def new
		@board = Board.new

		add_breadcrumb "Create New Board"
	end

	def create
		@board = Board.create(board_params)

		if @board.save
			flash[:success] = "Board created"
			redirect_to @board
		else
			render 'new'
		end
	end

		private

		def board_params
			params.require(:board).permit(:title, :description)
		end
end
