class AddRequiredRankToBoard < ActiveRecord::Migration
  def change
  	add_column :boards, :required_rank, :integer
  end
end
