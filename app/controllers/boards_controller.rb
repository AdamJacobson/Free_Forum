class BoardsController < ApplicationController
  def show
  	@board = Board.find(params[:id])
  end

  def index
  	@boards = Board.paginate(page: params[:page])
  end

  def new
  end
end
